import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notesapp_bloc/db_helper.dart';

import 'note_app.dart';
import 'note_blocc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NoteBloc(dbHelper: DbHelper.instanse),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: NoteApp()
    );
  }
}
