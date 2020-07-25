import "package:flutter/material.dart";

class ListEmptyText extends StatelessWidget {
  const ListEmptyText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          height: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text("恋上不一样的春天", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              )
            ],
          )
        )
      )
    );
  }
}