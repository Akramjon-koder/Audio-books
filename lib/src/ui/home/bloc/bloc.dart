import 'package:audiobook/src/ui/home/models/audio_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import '../../../network/dio.dart';
import '../../../network/links.dart';

part 'state.dart';
part 'event.dart';

class BooksBloc extends Bloc<BooksScreenEvent, BooksScreenState> {

  BooksBloc() : super(BooksScreenState()) {
    on<GetBooksEvent>(getData);
    //on<RegisterEvent>(register);
    print('sadfds');

  }
  final client = DioClient();

  Future<void> getData(BooksScreenEvent event, Emitter<BooksScreenState> emit) async {
    final result = await client.get(Links.books);

    if(result.statusCode != 200) {
      throw result.statusMessage ?? 'Internet error';
    }

    emit(state.copyWith(
      status: BooksScreenStatus.ready,
      books: List<AudioModel>.from(
          result.data.map((x) => AudioModel.fromJson(x))),
    ));
  }

}