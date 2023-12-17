import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inout/globals.dart';
import 'package:intl/intl.dart';

import '../custom_drawer.dart';
import '../model/notes.dart';
import '../repositories/note_repo.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({Key? key}) : super(key: key);

  @override
  _ViewNotesState createState() => _ViewNotesState();
}

final NoteRepo noterepo = new NoteRepo();

class _ViewNotesState extends State<ViewNotes> {

  @override
  void initState() {
    noterepo.readNote().then((value) => {
          setState(() {
            notes = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDFD837),
        shadowColor: Colors.transparent,
      ),
      drawer: CustomDrawer(removeAllNotes: removeAllNotes),
      backgroundColor: const Color(0xFFDFD837),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 88, top: 32),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(shrinkWrap: true, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.bookmark, size: 15),
                          const SizedBox(width: 8),
                          Text("You have ${notes.length} notes."),
                        ],
                      ),
                    ),
                    for (Note note in notes)
                      ClipRect(
                        child: Slidable(
                          startActionPane: const ActionPane(
                            extentRatio: 0.25,
                            motion: BehindMotion(),
                            children: [

                              // TBA

                              /*
                              SlidableAction(
                                onPressed: null,
                                backgroundColor: Colors.blueAccent,
                                icon: Icons.edit,
                                label: "Edit Note",
                                borderRadius: BorderRadius.circular(10.0),
                              ), */
                            ],
                          ),
                          endActionPane: ActionPane(
                            extentRatio: 0.25,
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => onDelete(context, note),
                                backgroundColor: Colors.redAccent,
                                icon: Icons.delete,
                                label: "Delete",
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ],
                          ),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(note.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(note.description),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_alarms_sharp,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat('dd/MM/yyyy - hh:mm')
                                            .format(note.createdDate),
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFFDFD837),
        child: const Icon(Icons.arrow_back),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  void onDelete(BuildContext context, Note note) {
    Note deletedNoteMaintainState = note;
    int deletedNoteMaintainPosition = notes.indexOf(note);

    setState(() {
      notes.remove(note);
      noterepo.saveNote(notes);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        content: Text("Note \"${note.title}\" has been deleted."),
        action: SnackBarAction(
          label: "Undo",
          textColor: Color(0xFFDFD837),
          onPressed: () {
            if (deletedNoteMaintainState != null &&
                deletedNoteMaintainPosition != null) {
              setState(() {
                notes.insert(
                    deletedNoteMaintainPosition, deletedNoteMaintainState);
              });
            }
          },
        ),
      ),
    );
  }

  Future<void> removeAllNotes(BuildContext context) async {
    bool shouldRemove = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erase"),
          content: const Text("Are you sure you want to erase all notes?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes", style: TextStyle(color: Colors.redAccent),),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No", style: TextStyle(color: Colors.blueAccent),),
            ),
          ],
        );
      },
    );

    if (shouldRemove) {
      setState(() {
        notes.removeRange(0, notes.length);
        noterepo.saveNote(notes);
        Navigator.pop(context);
      });
    }
  }

}
