import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/ui/home/home.dart';
import 'package:audiobook/src/ui/widgets/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'widgets/common.dart';
import 'widgets/controll_buttons.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final streams = context.read<BooksBloc>().state.playStreams!;
    return Screen(
      title: 'Audio',
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Builder(
                builder: (context) {
                  return StreamBuilder<SequenceState?>(
                      stream: streams.sequenceStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        if (state?.sequence.isEmpty ?? true) {
                          return const SizedBox();
                        }
                        final metadata = state!.currentSource!.tag as MediaItem;
                      return Image.network(
                        width: 500.w,
                        height: 600.w,
                        metadata.artUri.toString(),
                        fit: BoxFit.cover,
                      );
                    }
                  );
                }
              ),
            ),
          ),
          ListenableBuilder(
            listenable: notifier,
            builder: (context, child){
              return Column(
                children: [
                  ControlButtons(notifier.player),
                  StreamBuilder<PositionData>(
                    stream: notifier.positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                        bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                        onChangeEnd: (newPosition) {
                          notifier.player.seek(newPosition);
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
          ControlButtons(),
          StreamBuilder<PositionData>(
            stream: notifier.positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                bufferedPosition:
                positionData?.bufferedPosition ?? Duration.zero,
                onChangeEnd: (newPosition) {
                  notifier.player.seek(newPosition);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

