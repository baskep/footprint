import 'package:flutter/material.dart';
import 'package:footprint/pages/login.dart';

class LeftDrawerAvatar extends StatelessWidget {
  final token;
  final userName;
  final avatar;
  const LeftDrawerAvatar({Key key, this.token, this.userName, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 44.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: token != '' && token != null ?  
                    GestureDetector(
                      child: ClipOval(
                        child: Image.network(
                          'https://s3.cn-north-1.amazonaws.com.cn/mococn-fxa-prod/8a35b20c4579951a964ff1ab192f71fe',
                          width: 59,
                          height: 59,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        print('修改个人信息');
                      },
                    ) :
                    GestureDetector(
                      child: ClipOval(
                        child: Image.asset(
                          'assets/img/avatar.png',
                          width: 59,
                          height: 59,
                        ),
                      ),
                      onTap: () {    
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Login();
                          }
                        ));  
                      },
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  width: 80.0,
                  child: Text(token != '' && token != null ? userName : '请登录', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15.0, color: Colors.white))
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.white),
        ],
      )
    );
  }
}