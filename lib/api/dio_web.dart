import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:footprint/api/http.dart';
import 'package:footprint/model/category.dart';
import 'package:footprint/model/login_form_data.dart';

import 'package:footprint/utils/md5.dart';
import 'package:footprint/utils/oss_util.dart';

class DioWeb {

  // 格式化提示信息
  static void formatMsg(msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1
    );
  }

  // 清空本地存储用户信息
  static Future clearUserInfo() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('_id');
    prefs.remove('token');
    prefs.remove('userName');
    prefs.remove('mobile');
    prefs.remove('avatar');
  }

  // 格式化足迹数据
  static List<CategoryDetail> formatFootPrintList (List categoryDetailData) {
    List<CategoryDetail> footprintList = new List<CategoryDetail> ();
    for (var detail in categoryDetailData) {
      CategoryDetail categoryDetailItem = new CategoryDetail(
        detail['_id'],
        detail['category'],
        detail['user']['_id'],
        detail['categoryDetailName'],
        detail['content'],
        detail['created'],
        detail['dateTime'],
        detail['imageUrl'],
        detail['localtion'],
        detail['modified'],
        detail['user']['userName'],
        detail['user']['avatar']
      );
      footprintList.add(categoryDetailItem);
    }
    return footprintList;
  }

  // 获取分类信息
  // todo 优化逻辑，前后台
  static Future<List<CategoryModel>> getCategoryData() async {
    List<CategoryModel> categories = new List<CategoryModel> ();
    var res = await dio.get('/category');
    if (res.statusCode == 200 && res.data['status'] == 200) {
      var categoryData = res.data['data'];
      for (var item in categoryData) {
        List<CategoryDetail> categoryDetail = new List<CategoryDetail> ();
        for (var detail in item['categoryDetail']) {
          CategoryDetail categoryDetailItem = new CategoryDetail(
            detail['_id'],
            detail['category'],
            detail['user']['_id'],
            detail['categoryDetailName'],
            detail['content'],
            detail['created'],
            detail['dateTime'],
            detail['imageUrl'],
            detail['localtion'],
            detail['modified'],
            detail['user']['userName'],
            detail['user']['avatar']
          );
          categoryDetail.add(categoryDetailItem);
        }
        CategoryModel category = new CategoryModel(item['id'], item['name'], item['key'], categoryDetail);
        categories.add(category);
      }
    }
    return categories;
  }

  // 获取验证码
  static Future<String> getVerifyCode() async {
    try {
      var res = await dio.get('/verify-code');
      if (res.data['status']['code'] == 200 && res.data['data']['code'] != null) {
        return res.data['data']['code'];
      } else {
        formatMsg('网络错误');
        return '';
      }
    } catch (e) {
      formatMsg('网络错误');
      return '';
    }
  }

  // 登录
  static Future<bool> login(LoginFormDataModel loginFormData) async {
    dio.options.headers['authorization'] = MD5.generateMd5(loginFormData.password);
    try {
      var res = await dio.post('/login', data: {
        'mobile': loginFormData.mobile,
        'verifyCode': loginFormData.verifyCode,
        'invitionCode': loginFormData.invitionCode,
      });
      if (res.data['status']['code'] == 200) {
        // cookie
        // String cookiePath = await Util.getCookiePath();
        // PersistCookieJar cookieJar = new PersistCookieJar(dir: cookiePath);
        // cookieJar.deleteAll();

        // List<Cookie> cookies = new List();
        // cookies.add(new Cookie('token', res.data['data']['token']));
        // cookies.add(new Cookie('userName', res.data['data']['userName']));
        // cookies.add(new Cookie('mobile', res.data['data']['mobile']));
        // cookies.add(new Cookie('avatar', res.data['data']['avatar']));

        // cookieJar.saveFromResponse(Uri.parse('http://192.168.0.102/'), cookies);
        // var b = cookieJar.loadForRequest(Uri.parse('http://192.168.0.102/'));

        // 本地化存储
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('_id', res.data['data']['_id']);
        prefs.setString('token', res.data['data']['token']);
        prefs.setString('userName', res.data['data']['userName']);
        prefs.setString('mobile', res.data['data']['mobile']);
        prefs.setString('avatar', res.data['data']['avatar']);
        EasyLoading.dismiss();
        return true;
      } else {
        formatMsg(res.data['status']['message']);
        EasyLoading.dismiss();
        return false;
      }
    } catch (e) {
      formatMsg('网络错误');
      return false;
    }
  }

  // 注销登录
  static Future loginOut() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var mobile = prefs.getString('mobile');
      var res = await dio.post('/login-out', data: {
        'mobile': mobile,
      });
      if (res.data['status']['code'] == 200) {
        // 清空本地化存储
        await clearUserInfo();
        formatMsg('注销成功');
      } else {
        formatMsg(res.data['status']['message']);
      }
    } catch (e) {
      formatMsg('网络错误');
    }
  }

  // 获取列表数据
  static Future<List<CategoryDetail>> getFootprintList(String categoryId, bool isUserLogin) async {
    List<CategoryDetail> footprintList = new List<CategoryDetail> ();
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getString('_id');
      dio.options.headers['authorization'] = token;
      var res;
      if (
        userId != null &&
        userId != '' &&
        categoryId != null &&
        categoryId != '' &&
        isUserLogin
      ) {
        res = await dio.get('/footprint', queryParameters: {
          'userId': userId,
          'categoryId': categoryId
        });
      } else {
        res = await dio.get('/empty-footprint');
      }
      var code = res.data['status']['code'];
      if (code == 200) {
        var categoryDetailData = res.data['data'];
        footprintList = formatFootPrintList(categoryDetailData['data']);
      } else {
        if (code == 113) {
          if (userId != '' && userId != null) {
            await clearUserInfo();
            formatMsg(res.data['status']['message']);
          } 
          res = await dio.get('/empty-footprint');
          var code = res.data['status']['code'];
          if (code == 200) {
            var categoryDetailData = res.data['data'];
            footprintList = formatFootPrintList(categoryDetailData['data']);
          }
        }
      }
      return footprintList;
    } catch (e) {
      formatMsg('网络错误');
      return footprintList;
    }
  }


  static Future<String> upload(PickedFile image) async {
    var baseUrl = 'http://footprintpic.oss-cn-hangzhou.aliyuncs.com/';
    var fileName = OssUtil.instance.getImageName(image.path);
    dio.options.responseType = ResponseType.plain;
    FormData formdata = FormData.fromMap({
      'Filename': fileName,
      'key': 'images/' + fileName,
      'policy': OssUtil.policy,
      'OSSAccessKeyId': 'LTAI4GJ8WyjtCFmw17wYdkvS',
      'success_action_status': '200',
      'signature': OssUtil.instance.getSignature('ik8JLWP7jqpV6yGQ3ZOgt1JLyfwxCm'),
      'file': MultipartFile.fromFileSync(image.path, filename:OssUtil.instance.getImageNameByPath(image.path))
      });
    var response = await dio.post(baseUrl, data: formdata);
    if (response.statusCode == 200) {
      return baseUrl + 'images/' + fileName;
    } else {
      formatMsg('上传图片失败，请稍候再试');
      return '';
    }
  }
}