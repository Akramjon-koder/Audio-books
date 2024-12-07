
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../home.dart';
import 'common.dart';

class ControlButtons extends StatelessWidget {

  const ControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final streams = context.read<BooksBloc>().state.playStreams!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: streams.volumeStream,
              onChanged: (v) => context.read<BooksBloc>().add(SetVolumeEvent(v)),
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: streams.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: context.read<BooksBloc>().state.playIndex > 0
                ? () => context.read<BooksBloc>().add(SeektoPervousEvent()) : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: streams.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: () => context.read<BooksBloc>().add(PlayEvent()),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: () => context.read<BooksBloc>().add(PauseEvent()),
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => context.read<BooksBloc>().add(RestartEvent()),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: streams.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: context.read<BooksBloc>().state.playIndex < context.read<BooksBloc>().state.books.length - 1
                ? () => context.read<BooksBloc>().add(SeektoNextEvent()) : null,
          ),
        ),
        StreamBuilder<double>(
          stream: streams.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                stream: streams.speedStream,
                onChanged: (v) => context.read<BooksBloc>().add(SetSpeedEvent(v)),
              );
            },
          ),
        ),
      ],
    );
  }
}