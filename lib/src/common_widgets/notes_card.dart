import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sign_up/src/my_style/AppStyle.dart';

Widget NoteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[int.parse(doc['color_id'])],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc['note_title'], style: AppStyle.mainTitle, overflow: TextOverflow.ellipsis,),
          SizedBox(height: 4.0,),
          Text(doc['creation_date'], style: AppStyle.dateTitle),
          SizedBox(height:8.0,),
          Text(doc['note_content'], style: AppStyle.mainContent, overflow: TextOverflow.ellipsis,),
        ],
      ),
    ),
  );
}