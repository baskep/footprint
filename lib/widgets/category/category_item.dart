import 'package:flutter/material.dart';
import 'package:footprint/model/category.dart';

class CategoryItem extends StatelessWidget {

  final CategoryDetail categoryDetail;

  const CategoryItem({Key key, this.categoryDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: MediaQuery.of(context).size.width / 5.5,
      height: MediaQuery.of(context).size.width / 5.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFb2b2b2),
            blurRadius: 4.0,
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Image.asset(
              categoryDetail.imageUrl != "" ? categoryDetail.imageUrl : 'assets/img/pic.png', 
              width: 24.0, 
              height: 24.0
            ),
          ),
          Text(categoryDetail.categoryDetailName, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 12.0, color: Color(0xFF999999)))
        ],
      ),
    );
  }
}