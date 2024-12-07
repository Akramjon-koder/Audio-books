import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';


import '../../../network/dio.dart';
import '../../../network/links.dart';
import '../../widgets/enums.dart';
import '../home.dart';
import '../../audio_play/model/play_streams.dart';

part 'state.dart';
part 'event.dart';

class BooksBloc extends Bloc<BooksScreenEvent, BooksScreenState> {

  BooksBloc() : super(BooksScreenState()) {
    on<GetBooksEvent>(_getData);
  }

  final _client = DioClient();

  Future<void> _getData(GetBooksEvent event, Emitter<BooksScreenState> emit) async {

    final result = await _client.get(Links.books);

    if(result.statusCode != 200) {
      throw result.statusMessage ?? 'Internet error';
    }

    final books = List<BookModel>.from(
        result.data.map((x) => BookModel.fromJson(x)));

    emit(state.copyWith(
      status: ScreenStatus.ready,
      books: books,
    ));
  }

}