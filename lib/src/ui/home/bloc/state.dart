part of 'bloc.dart';

enum BooksScreenStatus{loading, ready}

final class BooksScreenState {
  final List<AudioModel> books;
  final Map<String, LoadListner> loadingAudios;
  final BooksScreenStatus status;
  BooksScreenState({
    this.books = const[],
    this.loadingAudios = const{},
    this.status = BooksScreenStatus.loading,
  });

  BooksScreenState copyWith({
    List<AudioModel>? books,
    Map<String, LoadListner>? loadingAudios,
    BooksScreenStatus? status,
  }) => BooksScreenState(
    books: books ?? this.books,
    loadingAudios: loadingAudios ?? this.loadingAudios,
    status: status ?? this.status,
  );
}

typedef LoadListner = ValueListenableBuilder<double>;
