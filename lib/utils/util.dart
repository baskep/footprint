import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Util {

  static Future<String> getCookiePath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path + "/footprint_app";
    Directory dir = new Directory(tempPath);
    bool b = await dir.exists();
    if (!b) {
      dir.createSync(recursive: true);
    }
    return tempPath;
  }
}