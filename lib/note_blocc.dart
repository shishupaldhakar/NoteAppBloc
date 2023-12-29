import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp_bloc/note_model.dart';

import 'db_helper.dart';
import 'note_events.dart';
import 'note_stats.dart';

class NoteBloc extends Bloc<NoteEvent, NoteStates> {
  DbHelper dbHelper;
  NoteBloc({required this.dbHelper}) : super(InitialStates()) {
    on<AddNoteEvent>((event, emit)async{
      emit(LoadingStates());
      bool check =await dbHelper.insertData(event.noteModel);
      if(check){
        var array = await dbHelper.fetchData();
      emit(LoadedStates(arraNote: array));
      }
    });
    on<FetchEvent>((event,emit)async{
      emit(LoadingStates());
      var check= await dbHelper.fetchData();
      emit(LoadedStates(arraNote: check));
    });
    on<DeleteEvent>((event, emit)async{
      emit(LoadingStates());
      bool check = await dbHelper.deleteNote(event.id);
      if(check){
        var array = await dbHelper.fetchData();
        emit(LoadedStates(arraNote: array));
      }
    });
    on<UpdateEvent>((event, emit)async{
      emit(LoadingStates());
      bool check = await dbHelper.updateData(NoteModel(title: event.title, desc: event.desc,id:event.id));
      if(check){
        var array = await dbHelper.fetchData();
        emit(LoadedStates(arraNote: array));
      }
    });
  }
}
