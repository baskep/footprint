import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TestRoute extends StatefulWidget {

  var arguments;

  TestRoute({this.arguments});

  @override
  _TestRouteState createState() => _TestRouteState();
}

class _TestRouteState extends State<TestRoute> {

  @override
  void initState() {
    super.initState();
    var a = widget.arguments;
    var b = 2;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('data'),
    );
  }
}