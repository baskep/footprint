import 'package:flutter/material.dart';

import 'package:footprint/api/http.dart';
import 'package:footprint/pages/home.dart';
import 'package:footprint/pages/login.dart';
import 'package:footprint/widgets/verify_code/code_review.dart';
void main() {
  dio.options.connectTimeout = 12000000;
  dio.options.receiveTimeout = 12000000;
  dio.options.baseUrl = 'http://192.168.0.102:3002/api';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Home(id: '5f22efff606088e6aa66764c', name: '生活')
      )
    );
  }
}