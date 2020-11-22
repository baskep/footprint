import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cool_ui/cool_ui.dart';

import 'package:footprint/api/dio_web.dart';

import 'package:footprint/model/login_form_data.dart';
import 'package:footprint/pages/home.dart';

import 'package:footprint/widgets/verify_code/code_review.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  TextEditingController accountController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController invitionCodeController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();

  LoginFormDataModel loginFormData = new LoginFormDataModel('', '', '', '');
  
  String verifyCode = '';

  bool isLogin = false;

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
            verifyCode = data;
          });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 30, right: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              // 用户名
              Container(
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  keyboardType: TextInputType.number,
                  controller: accountController,
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
                  controller: pwdController,
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
                    width: 200.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            controller: verifyCodeController,
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
                  verifyCode != '' ? 
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    width: 100.0,
                    child: CodeReview(
                      text: verifyCode,
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
                  controller: invitionCodeController,
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
                  onTap: () async {
                    if (
                      accountController.text.length > 0 &&
                      pwdController.text.length > 0 &&
                      verifyCodeController.text.length > 0
                    ) {
                      loginFormData.mobile = accountController.text;
                      loginFormData.password = pwdController.text;
                      loginFormData.verifyCode = verifyCodeController.text;
                      loginFormData.invitionCode = invitionCodeController.text;
                      RegExp exp = RegExp(r'^1[3-9]\d{9}$');
                      if (isLogin) {
                        return;
                      }
                      if (!exp.hasMatch(loginFormData.mobile)) {
                        Fluttertoast.showToast(
                          msg: '请输入正确的手机号',
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1
                        );
                      } else if (loginFormData.password.length < 4) {
                        Fluttertoast.showToast(
                          msg: '密码不得小于四位',
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1
                        );
                      } else if (loginFormData.verifyCode != verifyCode) {
                        Fluttertoast.showToast(
                          msg: '验证码错误',
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1
                        );
                        verifyCodeController.text = '';
                        getVerifyCode();
                      } else if (!isLogin) {
                        setState(() {
                          isLogin = true;
                        });
                        final voidCallback = showWeuiLoadingToast(context: context, message: Text('登录中'));
                        bool result = await DioWeb.login(loginFormData);
                        voidCallback();
                        if (result) {
                          showWeuiSuccessToast(context: context, message: Text('登录成功'), closeDuration: Duration(milliseconds: 1000));
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Home(id: '', name: '生活');
                              }
                            ));     
                          });
                        } else {
                          getVerifyCode();
                        }
                        setState(() {
                          isLogin = false;
                        });
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: '请检查信息是否填写完整',
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1
                      );
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
