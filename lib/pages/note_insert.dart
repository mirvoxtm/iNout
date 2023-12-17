import 'package:flutter/material.dart';
import 'package:inout/custom_drawer.dart';
import 'package:inout/globals.dart';
import 'package:inout/model/notes.dart';
import 'package:inout/repositories/note_repo.dart';

class NoteInsert extends StatelessWidget {
  NoteInsert({Key? key}) : super(key: key);

  TextEditingController noteNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  FocusNode isTitleFocused = FocusNode();
  final NoteRepo noterepo = new NoteRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDFD837),
        shadowColor: Colors.transparent,
      ),
      drawer: CustomDrawer(removeAllNotes: removeAllNotes),
      backgroundColor: const Color(0xFFDFD837),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(children: [
                          Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: noteNameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Title of the note...',
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.text,
                                    onChanged: onChangedTitle,
                                    maxLines: null,
                                    // onSubmitted: onSubmitted,
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 10,
                                    thickness: 1,
                                  ),
                                  TextField(
                                    controller: descriptionController,
                                    decoration: const InputDecoration(
                                      hintText: 'Description of the note...',
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.text,
                                    onChanged: onChangedDescription,
                                    maxLines: null,
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      sendNote(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFDFD837),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        fixedSize: const Size(300, 40)),
                                    child: const Text("Create Note", style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              )),
                        ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Stack(children: [
                        Positioned(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/view_notes');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              fixedSize: const Size(80, 80),
                            ),
                            child: const Icon(
                              Icons.import_contacts_sharp,
                              color: Color(0xFFDFD837),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendNote(BuildContext context) {
    String title = noteNameController.text;
    String description = descriptionController.text;
    DateTime? setDate = DateTime.now();

    if (title != '' && description != '') {
      notes.add(Note(
          title: title, description: description, createdDate: DateTime.now()));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Text("Note \"${title}\" has been added.")),
      );

      noteNameController.clear();
      descriptionController.clear();
      noterepo.saveNote(notes);
    } else if (title == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Text("Note title must be filled.")),
      );
    } else if (description == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Text("Note description must be filled.")),
      );
    }
  }

  void onChangedTitle(String text) {
    print(text);
  }

  void onChangedDescription(String text) {
    print(text);
  }

  void onSubmitted(String text) {
    print(text);
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
        notes.removeRange(0, notes.length);
        noterepo.saveNote(notes);
    }
  }

}
