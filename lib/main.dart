import 'package:flutter/material.dart';
import 'package:footprint/pages/category.dart';

import 'package:footprint/api/http.dart';
import 'package:footprint/pages/home.dart';

void main() {
  dio.options.connectTimeout = 12000;
  dio.options.receiveTimeout = 12000;
  dio.options.baseUrl = 'http://192.168.0.100:3002/api';
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
        home: Home(id: '', name: '全部'),
      ),
    );
  }
}