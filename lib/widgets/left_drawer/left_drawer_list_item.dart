import 'package:flutter/material.dart';

class LeftDrawerListItem extends StatelessWidget {

  final imgUrl;
  final text;
  final link;
  final callback;

  LeftDrawerListItem({Key key, this.imgUrl, this.text, this.link, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: GestureDetector(
                    onTap: () {
                      callback(link);
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10.0, left: 10.0),
                          child: Image.asset(imgUrl, width: 20.0, height: 20.0, fit: BoxFit.contain),
                        ),
                        Container(
                          child: Text(text, style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w300)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
          Divider(height: 1.0, color: Colors.white),
        ],
      )
    );
  }
}