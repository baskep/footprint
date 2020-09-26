import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cool_ui/cool_ui.dart';

import 'package:footprint/pages/home.dart';

import 'package:footprint/model/category.dart';

import 'package:footprint/widgets/category/category_title.dart';
import 'package:footprint/widgets/category/category_item.dart';

import 'package:footprint/api/dio_web.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<Widget> _categoryItem(categoryDetail, homeId, homeName) => List.generate(categoryDetail.length, (index) {
    return CategoryItem(categoryDetail: categoryDetail[index], homeId: homeId, homeName: homeName);
  });
  
  List<CategoryModel> categories = new List<CategoryModel>();

  var contextObj;
  var voidCallBack;

  @override
  void initState() {
    super.initState();
    contextObj = this.context;
    getCategoryData();
  }

  Future getCategoryData() async {
    DioWeb.getCategoryData()
      .then((data) { 
        voidCallBack = showWeuiLoadingToast(context: contextObj, message: Text('加载中'));
        if (mounted) {
          setState(() {
            categories = data;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categoryList(context, () {
        voidCallBack();
      }),
      backgroundColor: Color(0xFF4abdcc),
    );
  }

  Widget _categoryList(context, callback) {
    if (categories.length > 0) {
      callback();
    }
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              CategoryTitle(category: categories[index], callback: (id, key) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Home(id: id, name: key);
                  }
                ));
              }),
              Wrap(
                spacing: MediaQuery.of(context).size.width / 16,
                children: _categoryItem(categories[index].categoryDetail, categories[index].id, categories[index].key)
              )
            ],
          ),
        );
      },
    );
  } 
}


