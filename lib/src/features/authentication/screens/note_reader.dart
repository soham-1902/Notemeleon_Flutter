import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_up/src/my_style/AppStyle.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

class NoteReaderScreen extends  StatefulWidget {
  const NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

String sResponse = "No summary generated yet. Please try again after a while!";
Map<String, dynamic> mapResponse = {};

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool isYes = false;

  postCall() async {
    mapResponse['text'] = json.encode(_contentController.text);
    mapResponse['temperature'] = json.encode(0);
    mapResponse['max_words'] = json.encode(30);

    final res = jsonEncode(mapResponse);

    var response = await http.post(Uri.http("v1.genr.ai","/api/circuit-element/summarize"),
        body: res,
        headers: { 'Content-Type': "application/json" }
    );

    if(response.statusCode == 200) {
      setState(() {
        sResponse = response.body;
        print(sResponse);
      });
    } else {
      sResponse = "Error.";
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.doc['note_title']);
    _contentController = TextEditingController(text: widget.doc['note_content']);
  }

  @override
  Widget build(BuildContext context) {
    int colorId = int.parse(widget.doc['color_id']);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save',
        backgroundColor: AppStyle.accentColor,
        onPressed: () {
          FirebaseFirestore.instance.collection(Globals.uId).doc(widget.doc.id).update({'note_title': _titleController.text});
          FirebaseFirestore.instance.collection(Globals.uId).doc(widget.doc.id).update({'note_content': _contentController.text});
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: 'Summarize',
              onPressed: () {
                postCall();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Gist (BETA)'),
                        content: Scrollbar(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: Text(sResponse.substring(0, 10) == 'No summary' ? sResponse : sResponse.substring(11, sResponse.length-2)),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });

          }, icon: Icon(Icons.summarize, color: Colors.black54,)),

          IconButton(
              tooltip: 'Delete Note',
              onPressed: () {
            showAlertDialog(context, widget.doc);
          }, icon: Icon(Icons.delete, color: Colors.black54,)),
        ],
        elevation: 0.0,
        backgroundColor: AppStyle.cardsColor[colorId],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _titleController,
                style: AppStyle.mainTitle,
                decoration: InputDecoration(
                  hintText: 'Note Title',
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 4.0,),
              Text(widget.doc['creation_date'], style: AppStyle.dateTitle),
              SizedBox(height:28.0,),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _contentController,
                style: AppStyle.mainContent,
                decoration: InputDecoration(
                  hintText: 'Note content',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, QueryDocumentSnapshot doc) {
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {
      Navigator.pop(context, false);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () async {
      await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
        myTransaction.delete(doc.reference);
      });
      Navigator.pop(context, true);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Note"),
    content: Text("Are you sure you want to delete this note?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) {
    if(value) {
      Navigator.pop(context);
    }
  });
}