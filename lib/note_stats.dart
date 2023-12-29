import 'note_model.dart';

abstract class NoteStates{}

class InitialStates extends NoteStates{}

class LoadingStates extends NoteStates{}

class LoadedStates extends NoteStates{
  List<NoteModel>arraNote;
  LoadedStates({required this.arraNote});
}
