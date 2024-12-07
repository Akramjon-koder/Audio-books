part of 'bloc.dart';

final class AudioScreenState{
  final PlayStreams? playStreams;
  final int playIndex;
  final bool haveNext;
  final ScreenStatus screenStatus;

  AudioScreenState({
    this.playIndex = 0,
    this.screenStatus = ScreenStatus.loading,
    this.playStreams,
    this.haveNext = false,
  });

  AudioScreenState copyWith({
    PlayStreams? playStreams,
    ScreenStatus? screenStatus,
    int? playIndex,
    bool? haveNext,
    bool? havePervous,
  }) => AudioScreenState(
    playStreams: playStreams ?? this.playStreams,
    screenStatus: screenStatus ?? this.screenStatus,
    playIndex: playIndex ?? this.playIndex,
    haveNext: haveNext ?? this.haveNext,
  );
}
