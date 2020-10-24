import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MoreInfoItem extends StatelessWidget {

  final String name;
  final String url;
  final callback;
  final bool type;

  const MoreInfoItem({Key key, this.name, this.url, this.callback, this.type}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xFFe7e7e7),
            ),
          ),
          color: Colors.white
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(name, style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300)),
              ),
              type ?
                Container(
                  margin: EdgeInsets.only(left: 12.0),
                  child: Image.asset('assets/img/right-icon.png', width: 14.0, height: 14.0,)
                ) :
                Container(
                  margin: EdgeInsets.only(left: 12.0),
                  child: Text(url, style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300)),
                )
            ],
          ),
        ),
      ),
      onTap: () {
        callback(url);
      },
    );
  }
}