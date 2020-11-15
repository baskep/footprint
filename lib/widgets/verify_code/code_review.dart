import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:random_string/random_string.dart';

import 'package:footprint/widgets/verify_code/code_print.dart';

import 'package:footprint/utils/tool.dart';

class CodeReview extends StatefulWidget {

  final String text;
  final callback;

  CodeReview({Key key, this.text, this.callback}) : super(key: key);

  _CodeReviewState createState() => _CodeReviewState();

}

class _CodeReviewState extends State<CodeReview> {

  List<Offset> _lineOffsets = <Offset>[];

  int _textLength;
  double _width;
  double _height;

  void _randLines() {
    _lineOffsets.clear();
    for (var i = 0; i < _textLength; i++) {
      double fromX = randomBetween(10, 20).toDouble();
      double fromY = randomBetween(3, 33).toDouble();
      Offset from = Offset(fromX, fromY);
      _lineOffsets.add(from);

      double endX = randomBetween(60, _width.toInt() - 10).toDouble();
      double endY = randomBetween(3, 33).toDouble();
      Offset end = Offset(endX, endY);
      _lineOffsets.add(end);
    }
  }

  @override
  void initState() {
    super.initState();
    _textLength = widget.text.length ?? 4;
    _width = _textLength.toDouble() * 22;
    _height = 36;
    _randLines();
  }

  void _changeCode() {
    setState(() {
      _randLines();
    });
  }

  Container _subString(index) {
    return Container(
      padding: EdgeInsets.only(left: 2, right: 2, top: randomBetween(0, 14).toDouble()),
      child: Transform.rotate(
        angle: pi / randomBetween(3, 30) * randomBetween(0, 1),
        child: Text(widget.text[index], style: TextStyle(fontSize: randomBetween(20, 22).toDouble(), color: Color(0xFF4abdcc))),
      ),
    );
  }

  Container _backLines() {
    return Container(
      width: _width,
      height: _height,
      child: CustomPaint(
        painter: CodePaint(_lineOffsets, Tool.randomColor()),
        foregroundPainter: CodePaint(_lineOffsets, Tool.randomColor()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      color: Colors.grey[200],
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _backLines(),
          _backLines(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _changeCode();
              widget.callback();
            },
            child: Container(
              width: _width,
              height: _height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_textLength, (int index) {
                  return _subString(index);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}