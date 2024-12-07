import 'dart:async';

import 'package:just_audio/just_audio.dart';

import 'position_data.dart';

final class PlayStreams {
  PlayStreams({
    required this.playerStateStream,
    required this.sequenceStateStream,
    required this.positionDataStream,
    required this.loopModeStream,
    required this.volumeStream,
    required this.speedStream,
    required this.shuffleModeEnabledStream,
  });

  final Stream<PlayerState> playerStateStream;
  final Stream<SequenceState?> sequenceStateStream;
  final Stream<PositionData> positionDataStream;
  final Stream<LoopMode> loopModeStream;
  final Stream<double> volumeStream;
  final Stream<double> speedStream;
  final Stream<bool> shuffleModeEnabledStream;

  PlayStreams copyWith({
    Stream<PlayerState>? playerStateStream,
    Stream<SequenceState?>? sequenceStateStream,
    Stream<PositionData>? positionDataStream,
    Stream<LoopMode>? loopModeStream,
    Stream<double>? volumeStream,
    Stream<double>? speedStream,
    Stream<bool>? shuffleModeEnabledStream,
  }) => PlayStreams(
    playerStateStream: playerStateStream ?? this.playerStateStream,
    sequenceStateStream: sequenceStateStream ?? this.sequenceStateStream,
    positionDataStream: positionDataStream ?? this.positionDataStream,
    loopModeStream: loopModeStream ?? this.loopModeStream,
    volumeStream: volumeStream ?? this.volumeStream,
    speedStream: speedStream ?? this.speedStream,
    shuffleModeEnabledStream: shuffleModeEnabledStream ?? this.shuffleModeEnabledStream,
  );
}
