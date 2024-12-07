
import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';

import '../bloc/bloc.dart';
import 'common.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final streams = context.read<PlayerBloc>().state.playStreams!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.volume_up,
            color: theme.text,
          ),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: streams.volumeStream,
              onChanged: (v) => context.read<PlayerBloc>().add(SetVolumeEvent(v)),
            );
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: streams.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: FaIcon(
              FontAwesomeIcons.backward,
              color: context.read<PlayerBloc>().state.playIndex > 0 ? theme.text : theme.line,
            ),
            iconSize: 26.a,
            onPressed: (){
              if(context.read<PlayerBloc>().state.playIndex > 0){
                context.read<PlayerBloc>().add(SeektoPervousEvent());
              }
            },
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
                icon: FaIcon(
                  FontAwesomeIcons.play,
                  color: theme.text,
                ),
                iconSize: 32.a,
                onPressed: () => context.read<PlayerBloc>().add(PlayEvent()),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.pause,
                  color: theme.text,
                ),
                iconSize: 32.a,
                onPressed: () => context.read<PlayerBloc>().add(PauseEvent()),
              );
            } else {
              return IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.rotateLeft,
                  color: theme.text,
                ),
                iconSize: 32.a,
                onPressed: () => context.read<PlayerBloc>().add(RestartEvent()),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: streams.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: FaIcon(
              FontAwesomeIcons.forward,
              color: context.read<PlayerBloc>().state.haveNext
                  ? theme.text : theme.line,
            ),
            iconSize: 26.a,
            onPressed: context.read<PlayerBloc>().state.haveNext
                ? () => context.read<PlayerBloc>().add(SeektoNextEvent()) : null,
          ),
        ),
        StreamBuilder<double>(
          stream: streams.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: theme.textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                stream: streams.speedStream,
                onChanged: (v) => context.read<PlayerBloc>().add(SetSpeedEvent(v)),
              );
            },
          ),
        ),
      ],
    );
  }
}