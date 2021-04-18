import '../Model/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesServices {
  static CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');
  static Future<void> updateNotes(Note note) async {
    await _notesCollection.doc(note.id).set({
      // 'userId': user.id,
      'title': note.title,
      'content': note.content,
      'time': DateTime.now()
    });
  }

  static Future<List<Note>> getNotes() async {
    QuerySnapshot snapshot =
        await _notesCollection.orderBy('time', descending: true).get();
    var documents = snapshot.docs;
    List<Note> notes = [];
    for (var document in documents) {
      notes.add(Note(
          id: document.id,
          title: document.data()['title'],
          content: document.data()['content'],
          time: document.data()['time'].toString()));
    }
    return notes;
  }

  static Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}
