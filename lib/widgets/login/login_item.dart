import 'package:flutter/material.dart';

class LoginItem extends StatelessWidget {

  final placeholder;

  LoginItem({Key key, this.placeholder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: TextFormField(
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFe3e3e3), fontWeight: FontWeight.w300),
              disabledBorder: InputBorder.none,
              enabledBorder:  InputBorder.none,
              focusedBorder:   InputBorder.none
            ),
            cursorColor: Colors.white,
          )
        ),
        Divider(height: 1.0, color: Colors.white)
      ],
    );
  }
}