import 'package:flutter/material.dart';

import 'package:notesapp_bloc/note_model.dart';
import 'package:notesapp_bloc/ui_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note_blocc.dart';
import 'note_events.dart';
import 'note_stats.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteStates>(
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiHelper.CustomTextField(
                      titleController, 'title', Icons.title),
                  UiHelper.CustomTextField(
                      descController, 'description', Icons.description),
                  ElevatedButton(
                      onPressed: () {
                        var title = titleController.text.toString();
                        var desc= descController.text.toString();
                        BlocProvider.of<NoteBloc>(context).add(AddNoteEvent(
                            noteModel: NoteModel(
                                title: title,
                                desc: desc)));
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black12,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'SaveData',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ));
      },
    );
  }
}
