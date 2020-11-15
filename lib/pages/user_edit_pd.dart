import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cool_ui/cool_ui.dart';

import 'package:footprint/pages/user_edit.dart';

import 'package:footprint/api/dio_web.dart';

class UserEditPassword extends StatefulWidget {

  @override
  _UserEditPasswordState createState() => _UserEditPasswordState();

}

class _UserEditPasswordState extends State<UserEditPassword> {

  TextEditingController userOldPdController = TextEditingController();
  TextEditingController userNewPdPdController = TextEditingController();
  TextEditingController userNewPdSurePdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
        backgroundColor: Color(0xFF4abdcc),
        elevation: 0.8,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Image.asset('assets/img/back.png', width: 18.0, height: 18.0),
            onPressed: () {
              Navigator.of(context).pop();
            }
          );
        }),
        actions: <Widget>[
          Builder(builder: (context){
            return IconButton(
              icon: Image.asset('assets/img/edit-publish.png', width: 18.0, height: 18.0),
              onPressed: () {
                showModel(context);
              },
            );
          })
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        height: 170.0,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFe7e7e7), width: 1.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20.0,
              margin: EdgeInsets.only(top: 28.0, left: 15.0, right: 15.0, ),
              child: TextFormField(          
                controller: userOldPdController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20)
                ],
                style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: '旧密码',
                  hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
                cursorColor: Color(0xFFCCCCCC),
                obscureText: true
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(color: Color(0xFFe7e7e7))
            ),
            Container(
              height: 20.0,
              margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              child: TextFormField(          
                controller: userNewPdPdController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20)
                ],
                style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: '新密码',
                  hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
                cursorColor: Color(0xFFCCCCCC),
                obscureText: true
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(color: Color(0xFFe7e7e7))
            ),
            Container(
              height: 20.0,
              margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              child: TextFormField(          
                controller: userNewPdSurePdController,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(20)
                ],
                style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: '确认新密码',
                  hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                cursorColor: Color(0xFFCCCCCC),
                obscureText: true
              )
            )
          ],
        ),
      ),
      backgroundColor: Color(0xFFfbf7ed),
    );
  }

  void showModel(preContext) {
    showDialog(
      context: preContext, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('确定修改密码？'),
          actions:<Widget>[
            CupertinoDialogAction(
              child: Text('确定'),
              onPressed: () async {
                Navigator.of(context).pop();
                String userOldPdText = userOldPdController.text;
                String userNewPdText = userNewPdPdController.text;
                String userNewSurePdText = userNewPdSurePdController.text;
                if (userOldPdText == null || userOldPdText == '') {
                  Fluttertoast.showToast(
                    msg: '请输入旧密码',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                  );
                  return;
                } else if (userNewPdText == null || userNewPdText == '') {
                  Fluttertoast.showToast(
                    msg: '请输入新密码',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                  );
                  return;
                } else if (userNewSurePdText == null || userNewSurePdText == '') {
                  Fluttertoast.showToast(
                    msg: '请输入新密码',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                  );
                  return;
                } else if (userNewPdText != userNewSurePdText) {
                  Fluttertoast.showToast(
                    msg: '两次输入的密码不同',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                  );
                  return;
                } else if (userNewPdText.length < 4 || userNewSurePdText.length < 4) {
                  Fluttertoast.showToast(
                    msg: '密码长度不得小于4位',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                  );
                  return;
                }
                final voidCallback = showWeuiLoadingToast(context: context, message: Text('修改中'));
                bool result = await DioWeb.editUserPdInfo(userOldPdText, userNewPdText, preContext);
                voidCallback();
                if (result) {
                  showWeuiSuccessToast(context: context, message: Text('修改密码成功'), closeDuration: Duration(milliseconds: 1000));
                  Future.delayed(Duration(milliseconds: 1200), (){
                    Navigator.of(preContext).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UserEdit();
                      }
                    )); 
                  });
                }
              },
            ),
            CupertinoDialogAction(
              child: Text('取消'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
    });
  }
}