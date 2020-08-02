import 'dart:ui';
import 'package:flutter/material.dart';

class CodePaint extends CustomPainter {
  final List<Offset> lineOffsets;
  final Color ranColor;
  CodePaint(this.lineOffsets, this.ranColor);

  @override
  void paint(Canvas canvas, Size size) {
    // debugPrint(canvas.runtimeType.toString());
    canvas.save();
    Paint _paint = Paint()
      ..color = ranColor // 画笔颜色
      ..strokeCap = StrokeCap.round // 画笔笔触类型
      ..isAntiAlias = true // 是否启动抗锯齿
      ..blendMode = BlendMode.exclusion // 颜色混合模式
      ..style = PaintingStyle.fill // 绘画风格，默认为填充
      ..colorFilter = ColorFilter.mode(ranColor, BlendMode.exclusion) // 颜色渲染模式，一般是矩阵效果来改变的,但是flutter中只能使用颜色混合模式
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0) // 模糊遮罩效果
      ..filterQuality = FilterQuality.high // 颜色渲染模式的质量
      // ..strokeWidth = randomBetween(1, 3).toDouble(); // 暂时固定
      ..strokeWidth = 1;

    final pointMode = PointMode.lines;
    canvas.drawPoints(pointMode, lineOffsets, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}