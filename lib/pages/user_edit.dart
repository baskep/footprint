import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:footprint/pages/user_edit_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import 'package:footprint/api/dio_web.dart';

class UserEdit extends StatefulWidget {
  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {

  var contextObj;
  var sp;

  String imageUrl = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    initAvatarData();
    contextObj = this.context;
  }

  void initAvatarData() async {
    var cacheSp = await SharedPreferences.getInstance();
    var avatarData = cacheSp.getString('avatar');
    var userNameData = cacheSp.getString('userName');
    setState(() {
      sp = cacheSp;
      imageUrl = avatarData;
      userName = userNameData;
    });
  }

  void pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      var image = await picker.getImage(source: ImageSource.gallery);
      var url = await DioWeb.upload(image);
      if (url != '') {
        var result = await DioWeb.editUserInfo(url, 'avatar');
        if (result) {
          setState(() {
            sp.setString('avatar', url);
            imageUrl = url;
            showWeuiSuccessToast(context: this.context, message: Text('修改头像成功'));
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: '请获取相机权限',
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人信息', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
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
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        height: 185.0,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFe7e7e7), width: 1.0),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 60.0,
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('头像', style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        ClipOval(
                          child: GestureDetector(
                            child: imageUrl != null && imageUrl != '' ?
                            Image.network(
                              imageUrl,
                              width: 49,
                              height: 49,
                              fit: BoxFit.cover,
                            ) :
                            Image.asset(
                              'assets/img/default-avatar.png',
                              width: 49,
                              height: 49,
                            ),
                            onTap: () {
                              pickImage();
                            },
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.0),
                          child: Image.asset('assets/img/right-icon.png', width: 14.0, height: 14.0,)
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0),
              child: Divider(color: Color(0xFFe7e7e7))
            ),
            Container(
              height: 20.0,
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('用户名', style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return UserNameEditDetail(paramData: userName != null && userName != '' ? userName : '');
                              }
                            ));
                          },
                          child: Text(userName != null && userName != '' ? userName : '用户名', style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w300)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 12.0),
                          child: Image.asset('assets/img/right-icon.png', width: 14.0, height: 14.0,)
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0),
              child: Divider(color: Color(0xFFe7e7e7))
            ),
            Container(
              height: 18.0,
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text('密码', style: TextStyle(fontWeight: FontWeight.w300)),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12.0),
                          child: Image.asset('assets/img/right-icon.png', width: 14.0, height: 14.0,)
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFfbf7ed),
    );
  }
}