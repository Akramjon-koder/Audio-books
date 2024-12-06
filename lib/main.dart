import 'package:audiobook/src/ui/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/extensions/size_extensions.dart';
import 'src/ui/home/home.dart';
import 'src/variables/util_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
