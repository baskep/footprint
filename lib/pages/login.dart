import 'package:flutter/material.dart';
import 'package:footprint/api/dio_web.dart';
import 'package:random_string/random_string.dart';

import 'package:footprint/model/login_form_data.dart';

import 'package:footprint/widgets/verify_code/code_review.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _accountController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _invitionCodeController = TextEditingController();
  TextEditingController _verifyCodeController = TextEditingController();

  LoginFormDataModel loginFormData = new LoginFormDataModel('', '', '', '');
  
  String _verifyCode = '';

  @override
  void initState() {
    super.initState();
    getVerifyCode();
  }

  // 获取验证码
  Future getVerifyCode() async {
    DioWeb.getVerifyCode()
      .then((data) { 
          setState(() {
            var a = 1;
            _verifyCode = data;
            var b = _verifyCode;
            var c = 2;
          });
      });
  }

  // 登录
  Future login(LoginFormDataModel loginFormData) async {
    DioWeb.login(loginFormData)
      .then((data) { 
        print('登录成功');
        print(data);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // 用户名
              Container(
                child: TextFormField(
                  controller: _accountController,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    hintText: '手机号',
                    hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFe3e3e3), fontWeight: FontWeight.w300),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                  ),
                  cursorColor: Colors.white
                )
              ),
              Divider(height: 1.0, color: Colors.white),
              // 密码
              Container(
                child: TextFormField(
                  controller: _pwdController,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    hintText: '账号密码(不少于4位)',
                    hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFe3e3e3), fontWeight: FontWeight.w300),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                  ),
                  cursorColor: Colors.white,
                  obscureText: true
                )
              ),
              Divider(height: 1.0, color: Colors.white),
              // 验证码     
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 150.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            controller: _verifyCodeController,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                              hintText: '验证码',
                              hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFe3e3e3), fontWeight: FontWeight.w300),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none
                            ),
                            cursorColor: Colors.white
                          )
                        ),
                        Divider(height: 1.0, color: Colors.white)
                      ],
                    ),
                  ),
                  _verifyCode != '' ? 
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: 100.0,
                    child: CodeReview(
                      text: _verifyCode,
                      callback: () {
                        getVerifyCode();
                      },
                    ),
                  ) : Container()
                ],
              ),
              // 邀请码
              Container(
                child: TextFormField(
                  controller: _invitionCodeController,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    hintText: '邀请码',
                    hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFe3e3e3), fontWeight: FontWeight.w300),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none
                  ),
                  cursorColor: Colors.white
                )
              ),
              Divider(height: 1.0, color: Colors.white),
              // 登录
              Container(
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
                    if (
                      _accountController.text.length > 0 &&
                      _pwdController.text.length > 0 &&
                      _verifyCodeController.text.length > 0
                    ) {
                      loginFormData.mobile = _accountController.text;
                      loginFormData.password = _pwdController.text;
                      loginFormData.verifyCode = _verifyCodeController.text;
                      loginFormData.invitionCode = _invitionCodeController.text;
                      // EasyLoading.show(status: 'loading...');
                      login(loginFormData);
                    } else {
                    }
                  },
                ),
              )
            ],
          ),
        )
      ),
      backgroundColor: Color(0xFF4abdcc),
    );
  }
}
