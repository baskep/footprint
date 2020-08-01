import 'dart:async';
import 'package:footprint/api/http.dart';
import 'package:footprint/model/category/category.dart';

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
}