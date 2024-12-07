part of 'bloc.dart';

final class BooksScreenState{
  final List<BookModel> books;
  final Map<String, LoadListner> loadingAudios;
  final ScreenStatus status;

  BooksScreenState({
    this.books = const[],
    this.loadingAudios = const{},
    this.status = ScreenStatus.loading,
  });

  BooksScreenState copyWith({
    List<BookModel>? books,
    Map<String, LoadListner>? loadingAudios,
    ScreenStatus? status,
    PlayStreams? playStreams,
    int? playIndex,
  }) => BooksScreenState(
    books: books ?? this.books,
    loadingAudios: loadingAudios ?? this.loadingAudios,
    status: status ?? this.status,
  );
}

typedef LoadListner = ValueListenableBuilder<double>;
