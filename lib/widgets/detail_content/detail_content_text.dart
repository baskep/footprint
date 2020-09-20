import 'package:flutter/material.dart';

class DetailContentText extends StatelessWidget {
  final String content;

  const DetailContentText({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: content == null || content == '' ?
        Row(
          children: <Widget>[
            Text('请添加内容', style: TextStyle(fontSize: 14.0, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300))
          ],
        ) :
        Row(
          children: <Widget>[
            Expanded(
              child: Text(content, style: TextStyle(fontSize: 14.0, color: Color(0xFF5C5C5C), fontWeight: FontWeight.w300)),
            )
          ],
        )
    );
  }
}