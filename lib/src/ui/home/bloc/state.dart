part of 'bloc.dart';

final class BooksScreenState{
  final List<BookModel> books;
  final ScreenStatus status;
  final int? lastPlayedIndex;
  final Duration lastPlayedDuration;

  BooksScreenState({
    this.books = const[],
    this.status = ScreenStatus.loading,
    this.lastPlayedIndex,
    this.lastPlayedDuration = Duration.zero,
  });

  BooksScreenState copyWith({
    List<BookModel>? books,
    ScreenStatus? status,
    int? playIndex,
    int? lastPlayedIndex,
    Duration? lastPlayedDuration,
  }) => BooksScreenState(
    books: books ?? this.books,
    status: status ?? this.status,
    lastPlayedIndex: lastPlayedIndex ?? this.lastPlayedIndex,
    lastPlayedDuration: lastPlayedDuration ?? this.lastPlayedDuration,
  );
}

