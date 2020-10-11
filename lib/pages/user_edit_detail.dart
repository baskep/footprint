import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserNameEditDetail extends StatefulWidget {

  final String paramData;

  UserNameEditDetail({this.paramData});

  @override
  _UserNameEditDetailState createState() => _UserNameEditDetailState();
}

class _UserNameEditDetailState extends State<UserNameEditDetail> {

  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改用户名', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
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
                if (userNameController.text == '' || userNameController.text.length == 0) {
                  Fluttertoast.showToast(
                    msg: '用户名不能为空哦',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                  );
                } else {
                  showModel(context);
                }
              },
            );
          })
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        height: 120.0,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFe7e7e7), width: 1.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20.0,
              margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: Text(widget.paramData, style: TextStyle(fontSize: 15.0, color: Color(0xFF999999), fontWeight: FontWeight.w300)),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(color: Color(0xFFe7e7e7))
            ),
            Container(
              height: 20.0,
              margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              child: TextFormField(          
                controller: userNameController,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(20)
                ],
                style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  hintText: '新用户名',
                  hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
                cursorColor: Color(0xFFCCCCCC)
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
          title: Text('确定修改用户名？'),
          actions:<Widget>[
            CupertinoDialogAction(
              child: Text('确定'),
              onPressed: () async {
                Navigator.of(context).pop();
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