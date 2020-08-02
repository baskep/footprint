import 'dart:math';
import 'dart:ui';

class Tool {

  static Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(256) + 0,
      Random().nextInt(256) + 0, Random().nextInt(256) + 0);
  }
}