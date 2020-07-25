import "package:flutter/material.dart";

class ListEmptyMask extends StatelessWidget {
  const ListEmptyMask({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Opacity(
        opacity: .2,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
            colors: [ Color(0xFF000000), Colors.transparent ]),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          height: 200
        ),
      ),
      alignment: Alignment.topLeft,
    );
  }
}