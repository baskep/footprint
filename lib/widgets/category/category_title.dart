import "package:flutter/material.dart";

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset("assets/img/category.png", width: 18.0, height: 18.0),
            ),
            Container(
              margin: EdgeInsets.only(left: 4.0),
              child: Text("生活", style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w300))
            ),
            Container(
              margin: EdgeInsets.only(left: 12.0),
              child: Image.asset("assets/img/right.png", width: 12.0, height: 12.0)
            ),
          ],
        ),
      ),
    );
  }
}