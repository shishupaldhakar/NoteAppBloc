import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp_bloc/add_data_page.dart';
import 'package:notesapp_bloc/note_events.dart';
import 'package:notesapp_bloc/ui_helper.dart';

import 'note_blocc.dart';
import 'note_stats.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoteBloc>(context).add(FetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController tController = TextEditingController();
    TextEditingController dController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text(
            'NoteApp',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          elevation: 0,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddData()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: BlocBuilder<NoteBloc, NoteStates>(builder: (context, state) {
          if (state is LoadingStates) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedStates) {
            return ListView.builder(
                itemCount: state.arraNote.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      tController.text = state.arraNote[index].title;
                      dController.text = state.arraNote[index].desc;
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        UiHelper.CustomTextField(
                                          tController,
                                          'title',
                                          Icons.title,
                                        ),
                                        UiHelper.CustomTextField(
                                          dController,
                                          'Description',
                                          Icons.description_outlined,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              BlocProvider.of<NoteBloc>(context)
                                                  .add(UpdateEvent(
                                                      id: state
                                                          .arraNote[index].id!,
                                                      title: tController.text
                                                          .toString(),
                                                      desc: dController.text
                                                          .toString()));
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black12,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            child: const Text(
                                              'Update Data',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: ListTile(
                      leading: Text('${state.arraNote[index].id}'),
                      title: Text(state.arraNote[index].title),
                      subtitle: Text(state.arraNote[index].desc),
                      trailing: IconButton(
                          onPressed: () {
                            BlocProvider.of<NoteBloc>(context).add(
                                DeleteEvent(id: state.arraNote[index].id!));
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                });
          } else {
            return Container();
          }
        }));
  }
}
