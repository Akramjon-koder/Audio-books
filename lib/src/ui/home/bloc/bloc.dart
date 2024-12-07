import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';


import '../../../network/dio.dart';
import '../../../network/links.dart';
import '../home.dart';
import '../models/play_streams.dart';
import '../models/position_data.dart';

part 'state.dart';
part 'event.dart';

class BooksBloc extends Bloc<BooksScreenEvent, BooksScreenState> {

  BooksBloc() : super(BooksScreenState()) {
    on<GetBooksEvent>(_getData);
    on<SetBooksIndexEvent>(_setAudio);
    on<SetVolumeEvent>(_setVolume);
    on<SeektoPervousEvent>(_seekToPrevious);
    on<SeektoNextEvent>(_seekToNext);
    on<PlayEvent>(_play);
    on<PauseEvent>(_pause);
    on<RestartEvent>(_restart);
    on<SetSpeedEvent>(_setSpeed);
  }

  final _client = DioClient();
  final AudioPlayer _player = AudioPlayer();
  late final playlist;

  Future<void> _getData(GetBooksEvent event, Emitter<BooksScreenState> emit) async {

    ///set player streams
    emit(state.copyWith(
      playStreams: _initPlayStreams,
    ));

    final result = await _client.get(Links.books);

    if(result.statusCode != 200) {
      throw result.statusMessage ?? 'Internet error';
    }

    final books = List<BookModel>.from(
        result.data.map((x) => BookModel.fromJson(x)));

    /// set playlist
    playlist = ConcatenatingAudioSource(children: List<AudioSource>.generate(books.length, (index) => AudioSource.uri(
      Uri.parse(books[index].audio),
      tag: MediaItem(
        id: books[index].id,
        album: books[index].author,
        title: books[index].title,
        artUri: Uri.parse(books[index].image),
      ),
    )));
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try {
      await _player.setAudioSource(playlist);
    } catch (e, stackTrace) {
      print("Error loading playlist: $e");
      print(stackTrace);
    }

    emit(state.copyWith(
      status: BooksScreenStatus.ready,
      books: books,
    ));
  }

  // player controll -------------->

  PlayStreams get _initPlayStreams => PlayStreams(
    playerStateStream: _player.playerStateStream,
    sequenceStateStream: _player.sequenceStateStream,
    volumeStream: _player.volumeStream,
    speedStream: _player.speedStream,
    positionDataStream: Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
            (position, bufferedPosition, duration) => PositionData(
            position, bufferedPosition, duration ?? Duration.zero)),
  );

  void _setAudio(SetBooksIndexEvent event, Emitter<BooksScreenState> emit){
    emit(state.copyWith(
      playIndex: event.index,
    ));
  }

  void _setVolume(SetVolumeEvent event, Emitter<BooksScreenState> emit) => _player.setVolume(event.volume);

  void _setSpeed(SetSpeedEvent event, Emitter<BooksScreenState> emit) => _player.setSpeed(event.speed);

  void _seekToPrevious(SeektoPervousEvent event, Emitter<BooksScreenState> emit) => _player.seekToPrevious();

  void _seekToNext(SeektoNextEvent event, Emitter<BooksScreenState> emit) => _player.seekToNext();

  void _play(PlayEvent event, Emitter<BooksScreenState> emit) => _player.play();

  void _pause(PauseEvent event, Emitter<BooksScreenState> emit) => _player.pause();

  void _restart(RestartEvent event, Emitter<BooksScreenState> emit) => _player.seek(Duration.zero, index: _player.effectiveIndices!.first);

}