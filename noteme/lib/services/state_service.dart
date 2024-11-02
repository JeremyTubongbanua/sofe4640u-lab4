import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/note.dart';

class StateService {
  List<Note> notes = [];

  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedNotes = prefs.getString('notes');
    if (savedNotes != null) {
      List<dynamic> notesList = jsonDecode(savedNotes);
      notes = notesList.map((note) => Note.fromMap(Map<String, String>.from(note))).toList();
    }
  }

  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'notes',
      jsonEncode(notes.map((note) => note.toMap()).toList()),
    );
  }

  void addNoteToState(Note note) {
    notes.add(note);
    saveNotes();
  }

  void deleteNoteFromState(int index) {
    notes.removeAt(index);
    saveNotes();
  }
}
