import 'dart:async';

import 'package:just_audio/just_audio.dart';

import 'position_data.dart';

final class PlayStreams {
  PlayStreams({
    required this.playerStateStream,
    required this.sequenceStateStream,
    required this.positionDataStream,
    required this.volumeStream,
    required this.speedStream,
  });

  final Stream<PlayerState> playerStateStream;
  final Stream<SequenceState?> sequenceStateStream;
  final Stream<PositionData> positionDataStream;
  final Stream<double> volumeStream;
  final Stream<double> speedStream;

  PlayStreams copyWith({
    Stream<PlayerState>? playerStateStream,
    Stream<SequenceState?>? sequenceStateStream,
    Stream<PositionData>? positionDataStream,
    Stream<double>? volumeStream,
    Stream<double>? speedStream,
  }) => PlayStreams(
    playerStateStream: playerStateStream ?? this.playerStateStream,
    sequenceStateStream: sequenceStateStream ?? this.sequenceStateStream,
    positionDataStream: positionDataStream ?? this.positionDataStream,
    volumeStream: volumeStream ?? this.volumeStream,
    speedStream: speedStream ?? this.speedStream,
  );
}
