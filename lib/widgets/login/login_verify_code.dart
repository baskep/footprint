import 'dart:math';

import 'package:flutter/material.dart';
import 'package:footprint/widgets/verify_code/code_review.dart';
import 'package:footprint/widgets/verify_code/code_print.dart';


class LoginVerifyCode extends StatelessWidget {

  final placeholder;

  final callback;

  LoginVerifyCode({Key key, this.placeholder, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 150.0,
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      hintText: placeholder,
                      hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFe3e3e3), fontWeight: FontWeight.w300),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none
                    ),
                    cursorColor: Colors.white,
                    obscureText: true
                  )
                ),
                Divider(height: 1.0, color: Colors.white)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            width: 100.0,
            child: CodeReview(
              text: 'sdas',
              callback: () {
                callback();
              },
            ),
          )
        ],
      )
    );
  }
}