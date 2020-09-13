import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import 'package:footprint/model/list_form_data.dart';

import 'package:footprint/api/dio_web.dart';

class EditPage extends StatefulWidget {

  final String id;
  final String categoryId;
  final String userId;

  EditPage({this.id, this.categoryId, this.userId});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  String imageUrl = '';
  String locationStr = '';
  String dateTimeStr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4abdcc),
        elevation: 0.8,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Image.asset('assets/img/back.png', width: 18.0, height: 18.0),
            onPressed: () {
              Navigator.of(context).pop();
            }
          );
        }),
        actions: <Widget>[
          Builder(builder: (context){
            return IconButton(
              icon: Image.asset('assets/img/edit-publish.png', width: 18.0, height: 18.0),
              onPressed: () {
                if (
                  _titleController.text == '' || 
                  _titleController.text.length == 0
                ) {
                  EasyLoading.showError('标题不能为哦');
                } else {
                  showModel(context, 'publish');
                }
              },
            );
          })
        ],
      ),
      body: FlutterEasyLoading(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      controller: _titleController,
                      style: TextStyle(color: Color(0xFF5c5c5c), fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        hintText: '故事的标题',
                        hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      cursorColor: Color(0xFFCCCCCC),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Color(0xFFe7e7e7), width: 1.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      controller: _contentController,
                      maxLines: 10,
                      style: TextStyle(color: Color(0xFF5c5c5c), fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                        hintText: '故事的开头...',
                        hintStyle: TextStyle(fontSize: 15.0, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      cursorColor: Color(0xFFCCCCCC),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Color(0xFFe7e7e7), width: 1.0),
                  ),
                ),
                Container(           
                  margin: EdgeInsets.only(top: 10.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: imageUrl == '' ? Center(
                      child: IconButton(
                        icon: Image.asset('assets/img/add-icon.png'),
                        onPressed: () async {
                          try {
                            final ImagePicker _picker = ImagePicker();
                            var image = await _picker.getImage(source: ImageSource.gallery);
                            var url = await DioWeb.upload(image);
                            if (url != '') {
                              setState(() {
                                imageUrl = url;
                              });
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: '请获取相机权限',
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1
                            );
                          }
                        }
                      ),
                    ) : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl + '?x-oss-process=image/resize,h_170',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )
                          )
                        )
                      ),
                      height: 170.0,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 0.5, 
                        color: Color(0xFFCCCCCC), 
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 0.5, 
                                color: Color(0xFFCCCCCC), 
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/img/edit-localtion.png'),
                                Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '故事发生在哪里',
                                    style: TextStyle(color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              print('点击选择地点');
                            },
                          )
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Image.asset('assets/img/edit-time.png'),
                                Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: dateTimeStr == '' || dateTimeStr == null ? Text(
                                    '故事发生的时间',
                                    style: TextStyle(color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                                  ) : Row(
                                    children: <Widget>[
                                      Text(    
                                        dateTimeStr,
                                        style: TextStyle(color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                                      ),
                                      GestureDetector(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Image.asset('assets/img/clear-icon.png', width: 14.0,),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            dateTimeStr = '';
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              showModel(context, 'date');
                            },
                          )
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFfbf7ed),
    );
  }
  
  void showModel(context, type) {
    switch (type) {
      case 'date':
        showModalBottomSheet(
          context: context,
          builder: (context) {
          return CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              maximumYear: 2040,
              minimumYear: 2000,
              onDateTimeChanged: (dateTime) {
                setState(() {
                  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                  dateTimeStr = dateFormat.format(dateTime); 
                });
              }
            );
          }
        );
        break;
      case 'publish':
        showDialog(
          context: context, 
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('确定发布或修改内容？', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300)),
              actions:<Widget>[
                CupertinoDialogAction(
                  child: Text('确定', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)),
                  onPressed: (){
                    ListFormData listFormData = new ListFormData(_titleController.text, _contentController.text, imageUrl, locationStr, dateTimeStr);
                    print(listFormData);
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text('取消', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        break;
      default:
    }
  }
}