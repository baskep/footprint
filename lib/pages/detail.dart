import 'package:flutter/material.dart';

import 'package:footprint/model/category.dart';

import 'package:footprint/widgets/detail_content/detail_content_image.dart';
import 'package:footprint/widgets/detail_content/detail_content_text.dart';
import 'package:footprint/widgets/detail_content/detail_content_info.dart';

class Detail extends StatefulWidget {
  final CategoryDetail listItem;

  Detail({Key key, this.listItem}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text(widget.listItem.categoryDetailName, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
          backgroundColor: Color(0xFF4abdcc),
          elevation: 0.8,
          leading: IconButton(
            icon: Image.asset('assets/img/back.png', width: 18.0, height: 18.0),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ),
        preferredSize: Size.fromHeight(44.0)
      ),
      body: _detailContent(context, widget.listItem),
      backgroundColor: Color(0xFFfbf7ed)
    );
  }
}

Widget _detailContent(context, listItem) {
  return SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0, bottom: 44.0),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            DetailContentImage(imageUrl: listItem.imageUrl ),
            DetailContentText(content: listItem.content),
            DetailContentInfo(listItem: listItem),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFe7e7e7),
            offset: Offset(0.0, 3.0),
            blurRadius: 3.0,
            spreadRadius: 1.0
          )
        ]
      )
    ),
  );
}