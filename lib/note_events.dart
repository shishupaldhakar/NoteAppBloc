import 'note_model.dart';

abstract class NoteEvent{}
class AddNoteEvent extends NoteEvent{
  NoteModel noteModel;
  AddNoteEvent({required this.noteModel});
}
class FetchEvent extends NoteEvent{}
class UpdateEvent extends NoteEvent{
  int id;
  String title;
  String desc;

  UpdateEvent({required this.id, required this.title, required this.desc});
}
class DeleteEvent extends NoteEvent{
  int id;
  DeleteEvent({required this.id});
}