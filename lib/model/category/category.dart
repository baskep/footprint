class CategoryModel {
  String id;
  String key;
  String name;
  List<CategoryDetail> categoryDetail;

  CategoryModel(this.id, this.key, this.name, this.categoryDetail);

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    if (json['categoryDetail'] != null) {
      categoryDetail = new List<CategoryDetail>();
      json['categoryDetail'].forEach((v) {
        categoryDetail.add(new CategoryDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    if (this.categoryDetail != null) {
      data['categoryDetail'] =
          this.categoryDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDetail {
  String categoryDetailName;
  String content;
  String created;
  String dateTime;
  String imageUrl;
  String localtion;
  String modified;
  String user;

  CategoryDetail(
    this.categoryDetailName,
    this.content,
    this.created,
    this.dateTime,
    this.imageUrl,
    this.localtion,
    this.modified,
    this.user);

  CategoryDetail.fromJson(Map<String, dynamic> json) {
    categoryDetailName = json['categoryDetailName'];
    content = json['content'];
    created = json['created'];
    dateTime = json['dateTime'];
    imageUrl = json['imageUrl'];
    localtion = json['localtion'];
    modified = json['modified'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryDetailName'] = this.categoryDetailName;
    data['content'] = this.content;
    data['created'] = this.created;
    data['dateTime'] = this.dateTime;
    data['imageUrl'] = this.imageUrl;
    data['localtion'] = this.localtion;
    data['modified'] = this.modified;
    data['user'] = this.user;
    return data;
  }
}
