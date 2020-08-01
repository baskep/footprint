import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:footprint/pages/category.dart';
import 'package:footprint/pages/detail.dart';
import 'package:footprint/widgets/left_drawer/left_drawer_avatar.dart';
import 'package:footprint/widgets/left_drawer/left_drawer_list_item.dart';
import 'package:footprint/widgets/list/list_image.dart';
import 'package:footprint/widgets/list/list_mask.dart';
import 'package:footprint/widgets/list/list_text.dart';
import 'package:footprint/widgets/list/list_empty_image.dart';
import 'package:footprint/widgets/list/list_empty_mask.dart';
import 'package:footprint/widgets/list/list_empty_text.dart';
import 'package:footprint/widgets/common/smart_drawer.dart';

import 'package:footprint/enum/left_drawer_nav.dart';


class Home extends StatefulWidget {

  final String id;

  final String name;

  Home({this.id, this.name});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _isLoading = false;

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
        backgroundColor: Color(0xFF4abdcc),
        elevation: 0.8,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Image.asset('assets/img/menu.png', width: 18.0, height: 18.0),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }
          );
        })
      ),
      drawer: _leftDrawer(context),
      body: _lists(context),
      backgroundColor: Color(0xFFfbf7ed),
    );
  }
}

Widget _leftDrawer(BuildContext context) {
  return SmartDrawer(
    widthPercent: 0.5,
    child: Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            LeftDrawerAvatar(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: LeftDrawerNav.leftDrawerNavList[0].length,
              itemBuilder: (BuildContext context, int index) {
                return LeftDrawerListItem(
                  imgUrl: LeftDrawerNav.leftDrawerNavList[0][index],
                  text: LeftDrawerNav.leftDrawerNavList[1][index],
                  link: LeftDrawerNav.leftDrawerNavList[2][index],
                  callback: (link) {
                    Navigator.pop(context);
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        switch (link) {
                          case 'footprint':
                            return CategoryPage();
                          default:
                            break;
                        }
                      }
                    ));
                  }
                );
              }
            )
          ],
        ),
      ),
      color: Color(0xFF4abdcc),
    ) 
  );
}

Widget _lists(BuildContext context) {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) {
              return Detail();
            }
          ));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
          child: Stack(
            children: <Widget>[
              true ? ListImage() : ListEmptyImage(),
              true ? ListMask() : ListEmptyMask(),
              true ? ListText() : ListEmptyText()
            ],
          )
        )
      );
    },
  );
}