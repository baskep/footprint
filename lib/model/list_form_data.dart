class ListFormData {
  String title = '';
  String content = '';
  String imageUrl = '';
  String locationStr = '';
  String dateTimeStr = '';

  ListFormData(this.title, this.content, this.imageUrl, this.locationStr, this.dateTimeStr);

  @override
  String toString() {
    return ' \n$title:$title,\n$content:$content,\n$imageUrl:$imageUrl,\n$locationStr:$locationStr,\n$dateTimeStr:$dateTimeStr\nnext:/';
  }

}
