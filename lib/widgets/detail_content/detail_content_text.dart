import 'package:flutter/material.dart';

class DetailContentText extends StatelessWidget {
  const DetailContentText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('风车、郁金香🌷、古堡🏰、特色建筑🏫，教堂⛪️……荷🇳🇱、比🇧🇪、德🇩🇪三国有数不尽的风情和童话的色彩。', style: TextStyle(fontSize: 14.0, color: Color(0xFF5c5c5c), fontWeight: FontWeight.w300)),
    );
  }
}