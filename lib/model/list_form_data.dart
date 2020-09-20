class ListFormData {
  String content = '';
  String imageUrl = '';
  String locationStr = '';
  String dateTimeStr = '';

  ListFormData(this.content, this.imageUrl, this.locationStr, this.dateTimeStr);

  @override
  String toString() {
    return '\n$content:$content,\n$imageUrl:$imageUrl,\n$locationStr:$locationStr,\n$dateTimeStr:$dateTimeStr\nnext:/';
  }

}
