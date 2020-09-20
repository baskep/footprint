import 'package:flutter/material.dart';
import 'package:footprint/model/category.dart';

class DetailContentInfo extends StatelessWidget {
  final CategoryDetail listItem;

  const DetailContentInfo({Key key, this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          listItem.dateTime != null && listItem.dateTime != '' ? Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5.0),
                child: Image(image: AssetImage('assets/img/time.png'), fit: BoxFit.contain, width: 12.0, height: 12.0),
              ),
              Container(
                child: Text(listItem.dateTime, style: TextStyle(fontSize: 12.0, color: Color(0xFF999999)))
              ),
            ]
          ) : Row(),
          listItem.localtion != null && listItem.localtion != '' ? Container(
            child: Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 2.0, bottom: 3.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 3.0),
                    child: Image(image: AssetImage('assets/img/location.png'), width: 12.0, height: 12.0)
                  ),
                  Container(
                    child: Text(listItem.localtion, style: TextStyle(fontSize: 12.0, color: Color(0xFF4abdcc)))
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFf2f2f2),
              borderRadius: BorderRadius.circular(20)
            )
          ) : Container()
        ],
      )
    );
  }
}