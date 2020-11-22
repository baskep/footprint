import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_ui/cool_ui.dart';

import 'package:footprint/pages/category.dart';
import 'package:footprint/pages/detail.dart';
import 'package:footprint/pages/edit_page.dart';
import 'package:footprint/pages/user_edit.dart';
import 'package:footprint/pages/more_info.dart';

import 'package:footprint/widgets/left_drawer/left_drawer_avatar.dart';
import 'package:footprint/widgets/left_drawer/left_drawer_list_item.dart';
import 'package:footprint/widgets/list/list_image.dart';
import 'package:footprint/widgets/list/list_mask.dart';
import 'package:footprint/widgets/list/list_text.dart';
import 'package:footprint/widgets/list/list_empty_image.dart';
import 'package:footprint/widgets/list/list_empty_mask.dart';
import 'package:footprint/widgets/list/list_empty_text.dart';
import 'package:footprint/widgets/common/smart_drawer.dart'; 

import 'package:footprint/api/dio_web.dart';
import 'package:footprint/model/category.dart';

import 'package:footprint/enum/left_drawer_nav.dart';


class Home extends StatefulWidget {

  final String id;
  final String name;

  Home({this.id, this.name});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey easyRefreshKey = GlobalKey();
  List<CategoryDetail> footprintList = new List<CategoryDetail>();

  bool isLoadEnd = false;

  String token = '';
  String userName = '';
  String avatar = '';
  String userId = '';

  int pageNum = 0;

  @override
  void initState() { 
    super.initState();
    getFootprintList();
  }

  void getFootprintUserInfo() async {
    final sp = await SharedPreferences.getInstance();
    final tokenData = sp.getString('token');
    final userNameData = sp.getString('userName');    
    final avatarData = sp.getString('avatar');
    final userIdData = sp.getString('_id');
    setState(() {
      token = tokenData;
      userName = userNameData;
      avatar = avatarData;
      userId = userIdData;
    });
  }

  Future getFootprintList() async {
    DioWeb.getFootprintList(widget.id, pageNum, true)
      .then((data) { 
        if (data != null && data.length != 0) {
          setState(() {
            isLoadEnd = false;
            footprintList.addAll(data);
          });
          getFootprintUserInfo();
        } else {
          setState(() {
            isLoadEnd = true;
          });
        }
      });
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
      drawer: SmartDrawer(
        widthPercent: 0.5,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    LeftDrawerAvatar(token: token, userName: userName, avatar: avatar),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: LeftDrawerNav.leftDrawerNavList[0].length,
                      itemBuilder: (BuildContext context, int index) {
                        return LeftDrawerListItem(
                          imgUrl: LeftDrawerNav.leftDrawerNavList[0][index],
                          text: LeftDrawerNav.leftDrawerNavList[1][index],
                          link: LeftDrawerNav.leftDrawerNavList[2][index],
                          callback: (link) {
                            if (link == 'userEdit' && (userId == null || userId == '')) {
                              Fluttertoast.showToast(
                                msg: '请先登录后在操作',
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1
                              );
                              return;
                            } else {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                                  switch (link) {
                                    case 'footprint':
                                      return CategoryPage();
                                    case 'userEdit':
                                      return UserEdit(id: widget.id, name: widget.name);
                                    case 'moreInfo':
                                      return MoreInfo();
                                    default:
                                      return CategoryPage();
                                      break;
                                  }
                                }
                              ));
                            }
                          }
                        );
                      }
                    )
                  ],
                ),
                token != '' && token != null ? Container(
                  margin: EdgeInsets.only(bottom: 44.0),
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 60.0),
                      width: 164.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF4abdcc),
                        border: Border.all(
                          color: Colors.white,
                        )
                      ),
                      child: Text('注销登录', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16.0)),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      final voidCallback = showWeuiLoadingToast(context: context, message: Text('加载中'));
                      final flag = await DioWeb.loginOut();
                      if (flag) {
                        showWeuiSuccessToast(context: context, message: Text('注销成功'), closeDuration: Duration(milliseconds: 1000));
                        Future.delayed(Duration(milliseconds: 1000), () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home(id: '', name: '生活')),
                            (route) => false,
                          );
                        });
                      }
                      voidCallback();
                    },
                  )
                ) : Container()
              ],
            )  
          ),
          color: Color(0xFF4abdcc),
        )
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: EasyRefresh(
          header: ClassicalHeader(  
            refreshingText: '刷新中...',
            refreshedText: '刷新完成',
            refreshText: '下拉刷新....',
            refreshReadyText: '下拉刷新',
            noMoreText: '',
            showInfo: false,
            textColor: Color(0xFF999999),
            bgColor: Color(0xFFfbf7ed),
          ),
          footer: ClassicalFooter(
            loadReadyText: '加载更多',
            loadingText: '加载中...',
            loadedText: isLoadEnd ? '没有更多数据啦' : '加载完成',
            noMoreText: '',
            showInfo: false,
            textColor: Color(0xFF999999),
            bgColor: Color(0xFFfbf7ed),
          ),
          key: easyRefreshKey,
          onRefresh: () async {
            setState(() {
              pageNum = 0;
              footprintList = [];
              getFootprintList();
            });
          },
          onLoad: () async {
            setState(() {
              pageNum = pageNum + 1;
              getFootprintList();
            });
          },
          child: ListView.builder(
            itemCount: footprintList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (token != '' && token != null && userName != '' && userName != null) {
                    showCupertinoModalPopup (
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text('编辑'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return EditPage(listItem: footprintList[index], homeId: widget.id, homeName: widget.name);
                                  }
                                ));
                              },
                              isDefaultAction: false,
                            ),
                            CupertinoActionSheetAction(
                              child: Text('查看详情'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return Detail(listItem: footprintList[index]);
                                  }
                                ));
                              },
                              isDestructiveAction: false,
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      }
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: '请先登录后再操作',
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  child: Stack(
                    children: <Widget>[
                      footprintList.length != 0 && footprintList[index].imageUrl != '' ? 
                      ListImage(imageUrl: footprintList[index].imageUrl) : 
                      ListEmptyImage(),
                      footprintList.length != 0 && footprintList[index].imageUrl != '' ? 
                      ListMask() : 
                      ListEmptyMask(),
                      footprintList.length != 0 ? 
                      ListText(categoryDetail: footprintList[index]) : 
                      ListEmptyText()
                    ],
                  )
                )
              );
            }),
        ),
      ),
      backgroundColor: Color(0xFFfbf7ed),
    );
  }
}