import 'package:flutter/material.dart';
import '../Model/note.dart';
import 'add_notes_page.dart';
import '../Service/notes_services.dart';

class ListNotesPage extends StatefulWidget {
  ListNotesPage({Key key}) : super(key: key);

  @override
  _ListNotesPageState createState() => _ListNotesPageState();
}

class _ListNotesPageState extends State<ListNotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNotesPage()));
        },
        child: Container(
          height: 60,
          width: 60,
          decoration:
              BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
          child: Center(
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
      body: FutureBuilder(
          key: Key("future"),
          future: NotesServices.getNotes(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            List<Note> notes = snapshot.data;
            return (notes.length != 0)
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: notes.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddNotesPage(note: notes[index])));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: (index == 0) ? 10 : 5,
                              bottom: (index == notes.length - 1) ? 30 : 0),
                          child: Center(
                            child: Card(
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width - 2 * 20,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(notes[index].title),
                                  subtitle: Text(
                                    notes[index].content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () async {
                                        await NotesServices.deleteNote(
                                            notes[index].id);
                                        setState(() {});
                                      },
                                      child: Icon(Icons.delete)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No Note",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
          }),
    );
  }
}
