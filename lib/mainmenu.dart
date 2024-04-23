
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> _notes = [];

  void _addNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter your note'),
            onSubmitted: (String value) {
              setState(() {
                _notes.add(value);
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  void _editNote(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedNote = _notes[index];
        return AlertDialog(
          title: Text('Edit Note'),
          content: TextField(
            autofocus: true,
            controller: TextEditingController(text: editedNote),
            decoration: InputDecoration(hintText: 'Edit your note'),
            onChanged: (String value) {
              editedNote = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _notes[index] = editedNote;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Amber Notes'),
      ),
      body: _buildNotesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Add Note',
        child: Icon(Icons.new_label_outlined),
      ),
    );
  }

  Widget _buildNotesList() {
    return ListView.builder(
      itemCount: _notes.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_notes[index]),
          onTap: () {
            _editNote(index);
          },
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteNote(index);
            },
          ),
        );
      },
    );
  }
}