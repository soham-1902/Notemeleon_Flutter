import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_up/src/my_style/AppStyle.dart';
import  'package:intl/intl.dart';

import '../../../../main.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  @override
  Widget build(BuildContext context) {
    int colorId = Random().nextInt(AppStyle.cardsColor.length);
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();
    String date = '${DateFormat("dd/MM/yyyy").format(DateTime.now())} ${DateFormat("hh:mm a").format(DateTime.now())}';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection(Globals.uId).add({
            "note_title":_titleController.text,
            "creation_date":date,
            "note_content":_mainController.text,
            "color_id":colorId.toString()
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print('Failed to add new note due to $error'));
        },
        child: Icon(Icons.save),

      ),
       backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppStyle.cardsColor[colorId],
         elevation: 0.0,
        title: Text('Add a new note', style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: AppStyle.mainTitle,
              decoration: InputDecoration(
                hintText: 'Note Title',
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 8.0,),
            Text(date, style: AppStyle.dateTitle,),
            SizedBox(height: 28.0,),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _mainController ,
              style: AppStyle.mainContent,
              decoration: InputDecoration(
                hintText: 'Note content',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
