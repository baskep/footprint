import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {

  final callback;

  LoginButton({Key key, this.callback}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 60.0),
      width: 164.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0xFF4abdcc),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        border: Border.all(
          color: Colors.white,
        )
      ),
      child: GestureDetector(
        child: Text('登录', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 17.0)),
        onTap: () {
          callback();
        },
      ),
    );
  }
}
