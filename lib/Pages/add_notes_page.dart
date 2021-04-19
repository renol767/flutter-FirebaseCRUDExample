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
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  double defaultMargin = 15.0;
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      nimController.text = widget.note.nim;
      namaController.text = widget.note.nama;
      kelasController.text = widget.note.kelas;
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
                      controller: nimController,
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Nim",
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
                      controller: namaController,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Nama",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                      controller: kelasController,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Kelas",
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
                    if (namaController.text.trim() != "") {
                      await NotesServices.updateNotes(Note(
                          id: (widget.note != null) ? widget.note.id : null,
                          nim: nimController.text,
                          nama: namaController.text,
                          kelas: kelasController.text));
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
