part of 'bloc.dart';

enum BooksScreenStatus {loading, ready}

final class BooksScreenState{
  final List<BookModel> books;
  final Map<String, LoadListner> loadingAudios;
  final BooksScreenStatus status;
  final PlayStreams? playStreams;
  final int playIndex;

  BooksScreenState({
    this.books = const[],
    this.loadingAudios = const{},
    this.playIndex = 0,
    this.playStreams,
    this.status = BooksScreenStatus.loading,
  });

  BooksScreenState copyWith({
    List<BookModel>? books,
    Map<String, LoadListner>? loadingAudios,
    BooksScreenStatus? status,
    PlayStreams? playStreams,
    int? playIndex,
  }) => BooksScreenState(
    books: books ?? this.books,
    loadingAudios: loadingAudios ?? this.loadingAudios,
    status: status ?? this.status,
    playStreams: playStreams ?? this.playStreams,
    playIndex: playIndex ?? this.playIndex,
  );
}

typedef LoadListner = ValueListenableBuilder<double>;
