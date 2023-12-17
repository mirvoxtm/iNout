// routes.dart
import 'package:flutter/material.dart';
import 'package:inout/pages/note_insert.dart';
import 'package:inout/pages/view_notes.dart';

var appRoutes = <String, WidgetBuilder>{
  '/': (context) => NoteInsert(),
  '/view_notes': (context) => ViewNotes(),
};