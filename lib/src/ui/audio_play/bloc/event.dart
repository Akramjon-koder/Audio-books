part of 'bloc.dart';

@immutable
abstract class AudioEvent{}

final class InitEvent extends AudioEvent {
  final List<BookModel> data;
  final int index;
  final Duration position;
  InitEvent({
    required this.data,
    this.index = 0,
    this.position = Duration.zero
  });
}

final class SetAudioIndexEvent extends AudioEvent {
  final int index;
  final Duration position;

  SetAudioIndexEvent(this.index,{this.position = Duration.zero});
}


final class PlayEvent extends AudioEvent {}

final class PauseEvent extends AudioEvent {}

final class RestartEvent extends AudioEvent {}

final class SeektoPervousEvent extends AudioEvent {}

final class SeektoNextEvent extends AudioEvent {}

final class DisposeEvent extends AudioEvent {}

final class SetVolumeEvent extends AudioEvent {
  final double volume;

  SetVolumeEvent(this.volume);
}

final class SetSpeedEvent extends AudioEvent {
  final double speed;

  SetSpeedEvent(this.speed);
}

final class SeekEvent extends AudioEvent {
  final Duration seek;

  SeekEvent(this.seek);
}

final class SetLoopModeEvent extends AudioEvent {
  final LoopMode loopMode;

  SetLoopModeEvent(this.loopMode);
}

final class SetShuffleModeEvent extends AudioEvent {
  final bool enabled;

  SetShuffleModeEvent(this.enabled);
}