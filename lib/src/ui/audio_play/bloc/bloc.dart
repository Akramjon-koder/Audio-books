
import 'package:audio_session/audio_session.dart';
import 'package:audiobook/src/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

import '../../widgets/enums.dart';
import '../model/play_streams.dart';
import '../model/position_data.dart';

part 'state.dart';
part 'event.dart';

class PlayerBloc extends Bloc<AudioEvent, AudioScreenState> {

  PlayerBloc() : super(AudioScreenState()) {
    on<InitEvent>(_init);
    on<SetAudioIndexEvent>(_setAudio);
    on<SetVolumeEvent>(_setVolume);
    on<SeektoPervousEvent>(_seekToPrevious);
    on<SeektoNextEvent>(_seekToNext);
    on<PlayEvent>(_play);
    on<PauseEvent>(_pause);
    on<RestartEvent>(_restart);
    on<SetSpeedEvent>(_setSpeed);
    on<SeekEvent>(_seek);
    on<SetLoopModeEvent>(_setLoopMode);
    on<SetShuffleModeEvent>(_setShuffleMode);
    on<DisposeEvent>(_dispose);
  }

  late AudioPlayer _player;
  late ConcatenatingAudioSource _playlist;
  AudioSession? session;

  Future<void> _init(InitEvent event, Emitter<AudioScreenState> emit) async {
    _player = AudioPlayer();

    ///set player streams
    emit(state.copyWith(
      playStreams: PlayStreams(
        playerStateStream: _player.playerStateStream,
        sequenceStateStream: _player.sequenceStateStream,
        volumeStream: _player.volumeStream,
        speedStream: _player.speedStream,
        loopModeStream: _player.loopModeStream,
        shuffleModeEnabledStream: _player.shuffleModeEnabledStream,
        positionDataStream: Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
            _player.positionStream,
            _player.bufferedPositionStream,
            _player.durationStream,
                (position, bufferedPosition, duration) => PositionData(
                position, bufferedPosition, duration ?? Duration.zero)),
      ),
    ));

    /// set playlist
    _playlist = ConcatenatingAudioSource(children: List<AudioSource>.generate(event.data.length, (index) => event.data[index].isLoaded
        ? AudioSource.file(
      event.data[index].audio,
      tag: MediaItem(
        id: event.data[index].id,
        album: event.data[index].author,
        title: event.data[index].title,
        artUri: Uri.parse(event.data[index].imageUrl),
      ),
    ) : AudioSource.uri(
      Uri.parse(event.data[index].audio),
      tag: MediaItem(
        id: event.data[index].id,
        album: event.data[index].author,
        title: event.data[index].title,
        artUri: Uri.parse(event.data[index].imageUrl),
      ),
    )));
    if(session == null){
      session = await AudioSession.instance;
      await session!.configure(const AudioSessionConfiguration.speech());
    }
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try {
      await _player.setAudioSource(_playlist);
      await _player.seek(event.position, index: event.index);
      emit(state.copyWith(
        screenStatus: ScreenStatus.ready,
        playIndex: _player.currentIndex,
        haveNext: _player.hasNext,
      ));
    } catch (e, stackTrace) {
      print("Error loading playlist: $e");
      print(stackTrace);
    }
  }

  void _setAudio(SetAudioIndexEvent event, Emitter<AudioScreenState> emit) async {
    await _player.seek(event.position, index: event.index);
    emit(state.copyWith(
      playIndex: _player.currentIndex,
      haveNext: _player.hasNext,
    ));
  }

  void _setVolume(SetVolumeEvent event, Emitter<AudioScreenState> emit) => _player.setVolume(event.volume);

  void _setSpeed(SetSpeedEvent event, Emitter<AudioScreenState> emit) => _player.setSpeed(event.speed);

  void _seekToPrevious(SeektoPervousEvent event, Emitter<AudioScreenState> emit) async {
    await _player.seekToPrevious();
    emit(state.copyWith(
      playIndex: _player.currentIndex,
      haveNext: _player.hasNext,
    ));
  }

  void _seekToNext(SeektoNextEvent event, Emitter<AudioScreenState> emit) async {
    await _player.seekToNext();
    emit(state.copyWith(
      playIndex: _player.currentIndex,
      haveNext: _player.hasNext,
    ));
  }

  void _play(PlayEvent event, Emitter<AudioScreenState> emit) => _player.play();

  void _pause(PauseEvent event, Emitter<AudioScreenState> emit) => _player.pause();

  void _restart(RestartEvent event, Emitter<AudioScreenState> emit) => _player.seek(Duration.zero, index: _player.effectiveIndices!.first);

  void _seek(SeekEvent event, Emitter<AudioScreenState> emit) => _player.seek(event.seek);

  void _setLoopMode(SetLoopModeEvent event, Emitter<AudioScreenState> emit) => _player.setLoopMode(event.loopMode);

  void _dispose(DisposeEvent event, Emitter<AudioScreenState> emit){
    _player.dispose();
    emit(state.copyWith(
      screenStatus: ScreenStatus.loading,
    ));
  }

  void _setShuffleMode(SetShuffleModeEvent event, Emitter<AudioScreenState> emit) async {
    if (event.enabled) {
      await _player.shuffle();
    }
    _player.setShuffleModeEnabled(event.enabled);
  }

}