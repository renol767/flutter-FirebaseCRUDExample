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
  void initState() {
    super.initState();
    NotesServices.getNotes();
  }

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
          builder: (BuildContext _, AsyncSnapshot<List<Note>> snapshot) {
            List<Note> notes = snapshot.data;
            if (notes.length == null) {
              return Center(
                child: Text(
                  "No Data",
                  style: TextStyle(fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: notes.length,
                itemBuilder: (BuildContext _, int index) {
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
                            width: MediaQuery.of(context).size.width - 2 * 20,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              title: Text(notes[index].nim),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Nama : " + notes[index].nama,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Kelas : " + notes[index].kelas,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              trailing: GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return AlertDialog(
                                              title: Text("Hapus"),
                                              content: Text(
                                                  "Apakah anda Serius ingin Menghapusnya"),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text("Tidak")),
                                                FlatButton(
                                                    onPressed: () async {
                                                      await NotesServices
                                                          .deleteNote(
                                                              notes[index].id);
                                                      setState(() {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListNotesPage()));
                                                      });
                                                    },
                                                    child: Text("Ya"))
                                              ],
                                            );
                                          });
                                        });
                                  },
                                  child: Icon(Icons.delete)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
