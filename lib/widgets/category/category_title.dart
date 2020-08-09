import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:footprint/model/category.dart';

class CategoryTitle extends StatelessWidget {
  final CategoryModel category;

  final callback;

  const CategoryTitle({Key key, this.category, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: GestureDetector(
          onTap: () {
            callback(category.id, category.key);
          },
          child: Row(
            children: <Widget>[
              Container(
                child: Image.asset('assets/img/category.png', width: 18.0, height: 18.0),
              ),
              Container(
                margin: EdgeInsets.only(left: 4.0),
                child: Text(category.key, style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w300))
              ),
              Container(
                margin: EdgeInsets.only(left: 12.0),
                child: Image.asset('assets/img/right.png', width: 12.0, height: 12.0)
              ),
            ],
          )
        )
      ),
    );
  }
}