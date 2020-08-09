import 'dart:async';
import 'package:footprint/api/http.dart';
import 'package:footprint/model/category.dart';
import 'package:footprint/model/login_form_data.dart';

import 'package:footprint/utils/md5.dart';

class DioWeb {
  static Future<List<CategoryModel>> getCategoryData() async {
    List<CategoryModel> categories = new List<CategoryModel>();
    var res = await dio.get('/category');
    if (res.statusCode == 200 && res.data['status'] == 200) {
      var categoryData = res.data['data'];
      for (var item in categoryData) {
        List<CategoryDetail> categoryDetail = new List<CategoryDetail>();
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

  static Future<String> login(LoginFormDataModel loginFormData) async {
    print('登录');
    dio.options.headers['authorization'] = MD5.generateMd5(loginFormData.password);
    var response = await dio.post('/login', data: {
      'mobile': loginFormData.mobile,
      'verifyCode': loginFormData.verifyCode,
      'invitionCode': loginFormData.invitionCode,
    });
    var a = 1;
    return 'true';
  }
}