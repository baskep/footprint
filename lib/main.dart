import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:footprint/api/http.dart';
import 'package:footprint/pages/home.dart';
import 'package:footprint/pages/login.dart';
import 'package:footprint/widgets/verify_code/code_review.dart';
import 'package:random_string/random_string.dart';

void main() {
  dio.options.connectTimeout = 12000;
  dio.options.receiveTimeout = 12000;
  dio.options.baseUrl = 'http://192.168.0.105:3002/api';
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
        builder: (BuildContext context, Widget child) {
        return Material(
          type: MaterialType.transparency,
          child: FlutterEasyLoading(
              child: Login(),
            ),
          );
        }
      )
    );
  }
}