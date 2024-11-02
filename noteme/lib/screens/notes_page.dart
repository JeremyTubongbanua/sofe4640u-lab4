import 'package:flutter/material.dart';
import '../services/state_service.dart';
import '../models/note.dart';
import 'add_note_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final StateService _stateService = StateService();

  @override
  void initState() {
    super.initState();
    _stateService.loadNotes();
  }

  void addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNotePage()),
    );
    if (result != null && result is Note) {
      setState(() {
        _stateService.addNoteToState(result);
      });
    }
  }

  void deleteNoteAtIndex(int index) {
    setState(() {
      _stateService.deleteNoteFromState(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'), backgroundColor: Colors.purple[200]),
      body: _stateService.notes.isEmpty
          ? const Center(child: Text('No notes found', style: TextStyle(color: Colors.grey)))
          : ListView.builder(
              itemCount: _stateService.notes.length,
              itemBuilder: (context, index) {
                final note = _stateService.notes[index];
                return Card(
                  color: Colors.grey[200],
                  child: ListTile(
                    title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(note.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteNoteAtIndex(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
