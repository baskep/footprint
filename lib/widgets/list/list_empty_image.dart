import "package:flutter/material.dart";

class ListEmptyImage extends StatelessWidget {
  const ListEmptyImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Color(0xFFe7ddc6)
        ),
        height: 200,
      ),
      alignment: Alignment.topCenter,
    );
  }
}