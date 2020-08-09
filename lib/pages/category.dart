import 'package:flutter/material.dart';
import 'package:footprint/model/category.dart';
import 'package:footprint/pages/home.dart';
import 'package:footprint/widgets/category/category_title.dart';
import 'package:footprint/widgets/category/category_item.dart';
import 'package:footprint/api/dio_web.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<Widget> _categoryItem(List<CategoryDetail> categoryDetail) => List.generate(categoryDetail.length, (index) {
    return CategoryItem(categoryDetail: categoryDetail[index]);
  });
  
  
  List<CategoryModel> categories = new List<CategoryModel>();

  @override
  void initState() {
    super.initState();
    getCategoryData();
  }

  Future getCategoryData() async {
    DioWeb.getCategoryData()
      .then((data) { 
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
      body: _categoryList(context),
      backgroundColor: Color(0xFF4abdcc),
    );
  }

  Widget _categoryList(context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              CategoryTitle(category: categories[index], callback: (id, key) {
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Home(id: id, name: key);
                  }
                ));
              }),
              Wrap(
                spacing: MediaQuery.of(context).size.width / 16,
                children: _categoryItem(categories[index].categoryDetail)
              )
            ],
          ),
        );
      },
    );
  } 
}


