import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:footprint/api/http.dart';
import 'package:footprint/model/category.dart';
import 'package:footprint/model/login_form_data.dart';

import 'package:footprint/utils/md5.dart';


class DioWeb {
  static void formatError(msg) {
    Fluttertoast.showToast(
      msg: 'msg',
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1
    );
  }

  static Future<List<CategoryModel>> getCategoryData() async {
    List < CategoryModel > categories = new List < CategoryModel > ();
    var res = await dio.get('/category');
    if (res.statusCode == 200 && res.data['status'] == 200) {
      var categoryData = res.data['data'];
      for (var item in categoryData) {
        List < CategoryDetail > categoryDetail = new List < CategoryDetail > ();
        for (var detail in item['categoryDetail']) {
          CategoryDetail categoryDetailItem = new CategoryDetail(
            detail['categoryDetailName'],
            detail['content'],
            detail['created'],
            detail['dateTime'],
            detail['imageUrl'],
            detail['localtion'],
            detail['modified'],
            detail['user']
          );
          categoryDetail.add(categoryDetailItem);
        }
        CategoryModel category = new CategoryModel(item['id'], item['name'], item['key'], categoryDetail);
        categories.add(category);
      }
    }
    return categories;
  }

  static Future<String> getVerifyCode() async {
    try {
      var response = await dio.get('/verify-code');
      if (response.data['status']['code'] == 200 && response.data['data']['code'] != null) {
        return response.data['data']['code'];
      } else {
        formatError('网络错误');
        return '';
      }
    } catch (e) {
      formatError('网络错误');
      return '';
    }
  }

  static Future<bool> login(LoginFormDataModel loginFormData) async {
    dio.options.headers['authorization'] = MD5.generateMd5(loginFormData.password);
    try {
      var response = await dio.post('/login', data: {
        'mobile': loginFormData.mobile,
        'verifyCode': loginFormData.verifyCode,
        'invitionCode': loginFormData.invitionCode,
      });
      EasyLoading.dismiss();
      if (response.data['status']['code'] == 200) {
        // cookie
        // String cookiePath = await Util.getCookiePath();
        // PersistCookieJar cookieJar = new PersistCookieJar(dir: cookiePath);
        // cookieJar.deleteAll();

        // List<Cookie> cookies = new List();
        // cookies.add(new Cookie('token', response.data['data']['token']));
        // cookies.add(new Cookie('userName', response.data['data']['userName']));
        // cookies.add(new Cookie('mobile', response.data['data']['mobile']));
        // cookies.add(new Cookie('avatar', response.data['data']['avatar']));

        // cookieJar.saveFromResponse(Uri.parse('http://192.168.0.102/'), cookies);
        // var b = cookieJar.loadForRequest(Uri.parse('http://192.168.0.102/'));

        // 本地化存储
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['data']['token']);
        prefs.setString('userName', response.data['data']['userName']);
        prefs.setString('mobile', response.data['data']['mobile']);
        prefs.setString('avatar', response.data['data']['avatar']);
  
        return true;
      } else {
        formatError(response.data['status']['message']);
        return false;
      }
    } catch (e) {
      formatError('网络错误');
      return false;
    }
  }
}