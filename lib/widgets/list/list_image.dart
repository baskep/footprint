import "package:flutter/material.dart";

class ListImage extends StatelessWidget {
  const ListImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          image: DecorationImage(
            image: NetworkImage(
              "http://photos.breadtrip.com/photo_2018_06_10_8df1224b51aa2e69bf63f930692a8647.jpg?imageView/1/w/640/h/480/q/85",
            ),
            fit: BoxFit.cover 
          )
        ),
        height: 200,
      ),
      alignment: Alignment.topCenter,
    );
  }
}