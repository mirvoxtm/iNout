import 'dart:convert';

import 'package:inout/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/notes.dart';

class NoteRepo {

  NoteRepo() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  void saveNote(List<Note> notes) {
    sharedPreferences.setString('notes', json.encode(notes));
  }

  Future<List<Note>> readNote() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString('notes') ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Note.fromJson(e)).toList();
  }

}