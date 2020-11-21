import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_2d_amap/flutter_2d_amap.dart';

class EditMapPage extends StatefulWidget {

  final callback;

  EditMapPage({this.callback});

  @override
  _EditMapPageState createState() => _EditMapPageState();
}

class _EditMapPageState extends State<EditMapPage> {
  String addressName = '';
  final positionIndex = 0;

  final ScrollController scrollController = ScrollController();

  AMap2DController aMap2DController;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    Flutter2dAMap.setApiKey("5fcf326e0d896b48a4334c78726df3d9");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: AMap2DView(
                onPoiSearched: (result) {
                  // scrollController.animateTo(0.0, duration: const Duration(milliseconds: 10), curve: Curves.ease);
                  String detailAddress = '中国';
                  if (result == null || result.length == 0) {
                    Fluttertoast.showToast(
                      msg: '未搜索到地址',
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1
                    );
                  } else {
                    final position = result[positionIndex];
                    if (position != null &&  position.title != '') {
                      detailAddress = position.title;
                    }
                  }
                  setState(() {
                    addressName = detailAddress;
                  });
                },
                onAMap2DViewCreated: (controller) {
                  aMap2DController = controller;
                },
              ),
            ),

          ],
        ),
      ),
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 18.0,
                height: 18.0,
                child: GestureDetector(
                  child: Image.asset('assets/img/back.png', width: 18.0, height: 18.0),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.callback(addressName);
                    // Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                height: 36.0,
                width: 260.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF5ba8b6)),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFF5ba8b6)
                ),
                child: TextFormField(          
                  controller: searchController,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),   
                  decoration: InputDecoration(
                    hintText: '搜索地址',
                    hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFFEFEFE), fontWeight: FontWeight.w300),
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  cursorColor: Color(0xFFFEFEFE)
                ),
              ),
              Container(
                width: 22.0,
                height: 22.0,
                child: GestureDetector(
                  child: Image.asset('assets/img/search-icon.png', width: 22.0, height: 22.0),
                  onTap: () {
                    if (searchController.text != null && searchController.text != '') {
                      FocusScope.of(context).requestFocus(FocusNode());
                      aMap2DController.search(searchController.text);
                    } else {
                      Fluttertoast.showToast(
                        msg: '请输入地址',
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xFF4abdcc),
        elevation: 0.8,
      ),
    );
  }
}