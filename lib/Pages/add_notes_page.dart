import 'package:flutter/material.dart';
import '../Model/note.dart';
import 'list_notes_page.dart';
import '../Service/notes_services.dart';

class AddNotesPage extends StatefulWidget {
  final Note note;

  AddNotesPage({this.note});

  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  double defaultMargin = 15.0;
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note.title;
      contentController.text = widget.note.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Note"),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    //color: Colors.white,
                    child: TextField(
                      controller: titleController,
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Title",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    //color: Colors.white,
                    child: TextField(
                      controller: contentController,
                      maxLines: 100,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Content....",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
                child: RaisedButton(
                  color: Colors.grey,
                  onPressed: () async {
                    if (contentController.text.trim() != "") {
                      await NotesServices.updateNotes(Note(
                          id: (widget.note != null) ? widget.note.id : null,
                          title: titleController.text,
                          content: contentController.text));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListNotesPage()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
