import 'package:audiobook/src/extensions/size_extensions.dart';
import 'package:audiobook/src/theme/apptheme.dart';
import 'package:audiobook/src/ui/home/home.dart';
import 'package:audiobook/src/ui/widgets/screen_widget.dart';
import 'package:audiobook/src/variables/icons.dart';
import 'package:audiobook/src/variables/util_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../widgets/enums.dart';
import '../bloc/bloc.dart';
import '../model/position_data.dart';
import 'common.dart';
import 'controll_buttons.dart';

class AudioPage extends StatefulWidget {
  final List<BookModel> data;
  final int index;
  final Duration position;
  const AudioPage({
    super.key,
    required this.data,
    required this.index,
    this.position = Duration.zero,
  });

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  Duration position = Duration.zero;
  late int index;

  @override
  void initState() {
    index = widget.index;
    context.read<PlayerBloc>().add(InitEvent(
      data: widget.data,
      index: widget.index,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((PlayerBloc bloc) => bloc.state);
    final streams = context.read<PlayerBloc>().state.playStreams;
    return Screen(
      title: 'Audio',
      child: state.screenStatus == ScreenStatus.loading ? Center(
        child: CupertinoActivityIndicator(
          color: theme.grey,
        ),
      ): PopScope(
        onPopInvokedWithResult: (canPop, result){
          context.read<PlayerBloc>().add(DisposeEvent());
          print('pop');
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: 15.a.vertical,
                child: Center(
                  child: StreamBuilder<SequenceState?>(
                    stream: streams!.sequenceStateStream,
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
                    },
                  ),
                ),
              ),
              ControlButtons(),
              StreamBuilder<PositionData>(
                stream: streams.positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  position = positionData?.position ?? Duration.zero;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: position,
                    bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: (newPosition) => context.read<PlayerBloc>().add(SeekEvent(newPosition)),
                  );
                },
              ),
              10.a.height,
              Row(
                children: [
                  StreamBuilder<LoopMode>(
                    stream: streams.loopModeStream,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.off;
                      return IconButton(
                        icon: loopModeIcons[cycleModes.indexOf(loopMode)],
                        onPressed: () => context.read<PlayerBloc>().add(SetLoopModeEvent(cycleModes[
                        (cycleModes.indexOf(loopMode) + 1) %
                            cycleModes.length])),
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Playlist",
                      style: theme.textStyle.copyWith(
                        fontSize: 18.a,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: streams.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? const Icon(Icons.shuffle, color: Colors.orange)
                            : const Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () => context.read<PlayerBloc>().add(SetShuffleModeEvent(!shuffleModeEnabled)),
                      );
                    },
                  ),
                ],
              ),
              StreamBuilder<SequenceState?>(
                stream: streams.sequenceStateStream,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  final sequence = state?.sequence ?? [];
                  index = state?.currentIndex ?? index;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(sequence.length, (i) => InkWell(
                      onTap: () => context.read<PlayerBloc>().add(SetAudioIndexEvent(i)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.a,
                          vertical: 10.a,
                        ),
                        child: Row(
                          children: [
                            Text(
                              sequence[i].tag.title as String,
                              textAlign: TextAlign.start,
                              style: theme.textStyle.copyWith(
                                color: i == state!.currentIndex ? theme.orange : theme.text,
                                fontSize: 15.a,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('disposed');
    super.dispose();
  }
}

