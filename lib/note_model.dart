import 'package:notesapp_bloc/db_helper.dart';

class NoteModel {
  int? id;
  String title;
  String desc;

  NoteModel({this.id, required this.title, required this.desc});
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        title: map[DbHelper.noteTitle],
        desc: map[DbHelper.noteDesc],
        id: map[DbHelper.noteId]);
  }
  Map<String,dynamic>toMap(){
    return {
      DbHelper.noteId:id,
      DbHelper.noteTitle:title,
      DbHelper.noteDesc:desc
    };
  }
}
