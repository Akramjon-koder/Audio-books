import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

import 'src/extensions/size_extensions.dart';
import 'src/ui/audio_play/bloc/bloc.dart';
import 'src/ui/home/home.dart';
import 'src/variables/util_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.audio.books.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(BookAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BooksBloc()..add(GetBooksEvent()),
        ),
        BlocProvider(
          create: (context) => PlayerBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        builder: (BuildContext context, Widget? child) {
          setSizeExt(MediaQuery.of(context).size);
          bottom.value = MediaQuery.of(context).viewInsets.bottom;
          return MediaQuery(
            data: MediaQuery.of(context),
            child: child!,
          );
        },
        home: BooksScreen(),
      ),
    );
  }
}
