part of 'bloc.dart';

@immutable
abstract class BooksScreenEvent{}

final class GetBooksEvent extends BooksScreenEvent {}

final class DownloadTapEvent extends BooksScreenEvent {
  final BookModel data;
  DownloadTapEvent(this.data);
}

final class SetLastPlayedEvent extends BooksScreenEvent {
  final Duration position;
  final int index;

  SetLastPlayedEvent({
    required this.index,
    this.position = Duration.zero,
});
}
