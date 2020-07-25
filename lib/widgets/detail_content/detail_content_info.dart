import "package:flutter/material.dart";

class DetailContentInfo extends StatelessWidget {
  const DetailContentInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5.0),
                child: Image(image: AssetImage("assets/img/time.png"), fit: BoxFit.contain, width: 12.0, height: 12.0),
              ),
              Container(
                child: Text("2018.5.2 00:03:00", style: TextStyle(fontSize: 12.0, color: Color(0xFF999999)))
              ),
            ]
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 2.0, bottom: 3.0),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 3.0),
                    child: Image(image: AssetImage("assets/img/location.png"), width: 12.0, height: 12.0)
                  ),
                  Container(
                    child: Text("美国 旧金山", style: TextStyle(fontSize: 12.0, color: Color(0xFF4abdcc)))
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFf2f2f2),
              borderRadius: BorderRadius.circular(20)
            )
          )
        ],
      )
    );
  }
}