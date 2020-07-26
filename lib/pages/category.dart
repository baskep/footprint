import "package:flutter/material.dart";
import "package:footprint/widgets/category/category_title.dart";
import "package:footprint/widgets/category/category_item.dart";

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List<Widget> _categoryItem() => List.generate(10, (index) {
    return CategoryItem();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _categoryList(context),
      backgroundColor: Color(0xFF4abdcc),
    );
  }

  Widget _categoryList(context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              CategoryTitle(),
              Wrap(
                spacing: MediaQuery.of(context).size.width / 16,
                children: _categoryItem()
              )
            ],
          ),
        );
      },
    );
  } 
}


