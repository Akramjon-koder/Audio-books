import 'dart:io';

import 'package:audiobook/src/variables/util_variables.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../network/dio.dart';
import '../../../network/links.dart';
import '../../widgets/enums.dart';
import '../home.dart';

part 'state.dart';
part 'event.dart';

class BooksBloc extends Bloc<BooksScreenEvent, BooksScreenState> {

  BooksBloc() : super(BooksScreenState()) {
    on<GetBooksEvent>(_getData);
    on<DownloadTapEvent>(_downloadBookFromServer);
    on<SetLastPlayedEvent>(_saveLastPlayedBook);
  }

  final _client = DioClient();
  late final Box<BookModel> hiveBox;
  late final SharedPreferences pref;
  Directory directory = Directory("");

  Future<void> _getData(GetBooksEvent event, Emitter<BooksScreenState> emit) async {
    if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!;
    } else {
      directory = (await getApplicationDocumentsDirectory());
    }

    /// init SharedPreferences
    pref = await SharedPreferences.getInstance();

    /// get downloaded books
    hiveBox = await Hive.openBox<BookModel>(DataKeys.downloadedBooks);
    final storageList = hiveBox.values.toList();
    print('directory.path: ${directory.path}');
    final books = List<BookModel>.generate(storageList.length, (i) => storageList[i].copyWith(
      image: '${directory.path}/${storageList[i].image}',
      audio: '${directory.path}/${storageList[i].audio}'
    ));

    /// load data from server
    final result = await _client.get(Links.books);

    if(result.statusCode != 200) {
      emit(state.copyWith(
        status: ScreenStatus.ready,
        books: books,
      ));
      throw result.statusMessage ?? 'Internet error';
    }

    final serverBooks = List<BookModel>.from(
        result.data.map((x) => BookModel.fromJson(x)));

    /// remove downloaded server books
    serverBooks.removeWhere((book) => hiveBox.get(book.id) != null);

    ///set notifier
    for(final b in serverBooks){
      books.add(b.copyWith(progressNotifier: ValueNotifier<double?>(-1)));
    }

    final lastPlayedIndex = books.indexWhere((e) => e.id == pref.getString(DataKeys.lastPlayedBookId));

    emit(state.copyWith(
      status: ScreenStatus.ready,
      books: books,
      lastPlayedIndex: lastPlayedIndex < 0 ? null : lastPlayedIndex,
      lastPlayedDuration: Duration(milliseconds: pref.getInt(DataKeys.lastPlayedBookPosition) ?? 0),
    ));
  }

  final _loadedBookKeys = <String>{};
  void _downloadBookFromServer(DownloadTapEvent event, Emitter<BooksScreenState> emit) async {
    if(_loadedBookKeys.any((id) => id == event.data.id) || event.data.progressNotifier == null){
      return;
    }
    _loadedBookKeys.add(event.data.id);

    final dio = Dio();

    final String imageFileName = event.data.image.split('/').last;
    final imagePath = '${directory.path}/$imageFileName';

    event.data.progressNotifier!.value = null;

    ///download image
    await dio.download(
        event.data.image,
        imagePath,
        onReceiveProgress: (actualBytes, int totalBytes) {
          event.data.progressNotifier!.value = actualBytes / totalBytes / 10; // set <=10%
        });
    print('Image downloaded at ${event.data.image.split('/').last}');

    final String audioFileName = event.data.audio.split('/').last;
    final audioPath = '${directory.path}/$audioFileName';

    ///download media
    await dio.download(
        event.data.audio,
        audioPath,
        onReceiveProgress: (actualBytes, int totalBytes) {
          event.data.progressNotifier!.value = actualBytes * 9 / totalBytes / 10 + 0.1; // set <=100%
        });

    /// save local storage
    final downloadedBook = BookModel(
      id: event.data.id,
      author: event.data.author,
      title: event.data.title,
      isLoaded: true,
      image: imagePath,
      audio: audioPath,
      imageUrl: event.data.imageUrl,
    );

    hiveBox.put(event.data.id, downloadedBook.copyWith(
      image: imageFileName,
      audio: audioFileName,
    ));
    
    List<BookModel> allBooks = state.books;
    allBooks[allBooks.indexWhere((e) => e.id == downloadedBook.id)] = downloadedBook;

    emit(state.copyWith(
      books: allBooks,
    ));
    print('File downloaded at ${event.data.audio.split('/').last}');
  }

  void _saveLastPlayedBook(SetLastPlayedEvent event, Emitter<BooksScreenState> emit) async {
    emit(state.copyWith(
      lastPlayedIndex: event.index,
      lastPlayedDuration: event.position,
    ));

    pref.setString(DataKeys.lastPlayedBookId, state.books[event.index].id);
    pref.setInt(DataKeys.lastPlayedBookPosition, event.position.inMilliseconds);
  }
}