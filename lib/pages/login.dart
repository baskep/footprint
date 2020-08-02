import 'package:flutter/material.dart';
import 'package:footprint/widgets/login/login_item.dart';
import 'package:footprint/widgets/login/login_verify_code.dart';
import 'package:footprint/widgets/login/login_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              LoginItem(placeholder: '用户名或手机号'),
              LoginItem(placeholder: '账号密码'),
              LoginItem(placeholder: '邀请码'),
              LoginVerifyCode(placeholder: '验证码', callback: () {
                print('te');
              }),
              LoginButton(callback: test)
            ],
          ),
        )
      ),
      backgroundColor: Color(0xFF4abdcc),
    );
  }
}

void test() {
  print('测试');
}