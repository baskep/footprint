import "package:flutter/material.dart";
import "package:footprint/pages/home.dart";
import "package:footprint/pages/login.dart";
import "package:footprint/pages/category.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        home: Category(),
      ),
    );
  }
}