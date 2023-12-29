import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'note_model.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper instanse = DbHelper._();
  Database? _database;
  static const noteTable = 'NoteTable';
  static const noteId = 'NoteId';
  static const noteTitle = 'NoteTitle';
  static const noteDesc = 'NoteDesc';
  Future<Database> getDb() async {
    if (_database != null) {
      return _database!;
    } else {
      return initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join('${directory.path}noted.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      return db.execute(
          'create table $noteTable ( $noteId integer primary key autoincrement, $noteTitle Text, $noteDesc Text)');
    });
  }

  Future<bool> insertData(NoteModel noteModel) async {
    var db = await getDb();
    var count = await db.insert(noteTable, noteModel.toMap());
    return count > 0;
  }

  Future<List<NoteModel>> fetchData() async {
    var db = await getDb();
    List<Map<String, dynamic>> data = await db.query(noteTable);
    List<NoteModel> arrayNote = [];
    for (Map<String, dynamic> eachData in data) {
      NoteModel noteModel = NoteModel.fromMap(eachData);
      arrayNote.add(noteModel);
    }
    return arrayNote;
  }

  Future<bool> updateData(NoteModel noteModel) async {
    var db = await getDb();
    var count = await db.update(noteTable, noteModel.toMap(),
        where: '$noteId=${noteModel.id}');
    return count > 0;
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDb();
    var count = await db
        .delete(noteTable, where: '$noteId=?', whereArgs: [id.toString()]);
    return count > 0;
  }
}
