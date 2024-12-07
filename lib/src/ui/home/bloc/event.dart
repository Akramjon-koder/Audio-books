part of 'bloc.dart';

@immutable
abstract class BooksScreenEvent{}

final class GetBooksEvent extends BooksScreenEvent {}

final class SetBooksIndexEvent extends BooksScreenEvent {
  final int index;

  SetBooksIndexEvent(this.index);
}

// player events ---------->

final class PlayEvent extends BooksScreenEvent {}

final class PauseEvent extends BooksScreenEvent {}

final class RestartEvent extends BooksScreenEvent {}

final class SeektoPervousEvent extends BooksScreenEvent {}

final class SeektoNextEvent extends BooksScreenEvent {}

final class SetVolumeEvent extends BooksScreenEvent {
  final double volume;

  SetVolumeEvent(this.volume);
}

final class SetSpeedEvent extends BooksScreenEvent {
  final double speed;

  SetSpeedEvent(this.speed);
}