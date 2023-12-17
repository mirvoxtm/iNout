import 'package:flutter/material.dart';
import 'package:inout/globals.dart';
import 'package:inout/repositories/note_repo.dart';

class CustomDrawer extends StatefulWidget {
  final Function removeAllNotes;

  CustomDrawer({required this.removeAllNotes});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final NoteRepo noterepo = new NoteRepo();

  void initState() {
    noterepo.readNote().then((value) => {
      setState(() {
        notes = value;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(padding: EdgeInsets.zero, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
                image: ResizeImage(
                  AssetImage("assets/img/icon_yellow.png"),
                  width: 100,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFF507),
                      foregroundColor: Colors.white,
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Row(
                        children: [
                          Icon(Icons.add_box_rounded),
                          SizedBox(
                            width: 12,
                          ),
                          Text("Create new note"),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/view_notes');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFF507),
                      foregroundColor: Colors.white,
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Row(
                        children: [
                          Icon(Icons.import_contacts_sharp),
                          SizedBox(
                            width: 12,
                          ),
                          Text("View all notes"),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {widget.removeAllNotes(context);},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Row(
                        children: [
                          Icon(Icons.delete_forever),
                          SizedBox(
                            width: 12,
                          ),
                          Text("Erase Everything"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

