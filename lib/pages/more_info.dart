import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:footprint/widgets/more_info/more_info_item.dart';

class MoreInfo extends StatefulWidget {
  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更多', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
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
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Color(0xFFe7e7e7),
            ),
          ),
          color: Color(0xFFfbf7ed)
        ),
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            MoreInfoItem(name: '关于本项目', url: 'https://github.com/xtid/footprint', callback: (url) => { launchUrl(url) }, type: true),
            MoreInfoItem(name: '意见反馈', url: 'https://github.com/xtid/footprint/issues', callback: (url) => { launchUrl(url) }, type: true),
            MoreInfoItem(name: '版本号', url: 'Version 1.0.0', callback: () => {}, type: false),
          ],
        ),
      ),
      backgroundColor: Color(0xFFfbf7ed),
    );
  }
  void launchUrl(url) async {
    await launch(url);
  }
}