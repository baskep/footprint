import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:footprint/api/http.dart';

import 'package:footprint/pages/edit_page.dart';
import 'package:footprint/pages/home.dart';
import 'package:footprint/pages/login.dart';
import 'package:footprint/pages/user_edit.dart';

import 'package:footprint/widgets/verify_code/code_review.dart';
void main() {
  dio.options.connectTimeout = 12000000;
  dio.options.receiveTimeout = 12000000;
  dio.options.baseUrl = 'http://192.168.0.104:3002/api';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        routes: {
          '/login': (context) => Login()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Home(id: '', name: '生活'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', ''),
        ],
      )
    );
  }
}