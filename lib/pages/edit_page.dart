import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:footprint/pages/edit_map_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cool_ui/cool_ui.dart';

import 'package:footprint/pages/home.dart';

import 'package:footprint/model/category.dart';
import 'package:footprint/model/list_form_data.dart';

import 'package:footprint/api/dio_web.dart';

class EditPage extends StatefulWidget {

  final CategoryDetail listItem;
  final String homeId;
  final String homeName;

  EditPage({this.listItem, this.homeId, this.homeName});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  String imageUrl = '';
  String localtion = '中国';
  String dateTimeStr = '';

  @override
  void initState() {
    super.initState();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    dateTimeStr = dateFormat.format(DateTime.now()); 
    if (widget.listItem != null) {
      var listItem = widget.listItem;
      if (listItem.categoryDetailName != null && listItem.categoryDetailName != '') {
        titleController.text = listItem.categoryDetailName;
      }
      if (listItem.content != null && listItem.content != '') {
        contentController.text = listItem.content;
      }
      if (listItem.imageUrl != null && listItem.imageUrl != '') {
        imageUrl = listItem.imageUrl;
      }
      if (listItem.localtion != null && listItem.localtion != '') {
        localtion = listItem.localtion;
      }
      if (listItem.dateTime != null && listItem.dateTime != '') {
        dateTimeStr = listItem.dateTime;
      }
    }
  }

  void pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      var image = await picker.getImage(source: ImageSource.gallery);
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
                if (titleController.text == '' || titleController.text.length == 0) {
                  Fluttertoast.showToast(
                    msg: '标题不能为空哦',
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                  );
                } else {
                  showModel(context, 'publish', widget.homeId, widget.homeName);
                }
              },
            );
          })
        ],
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      enabled: false,
                      controller: titleController,
                      style: TextStyle(color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
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
                      controller: contentController,
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
                        onPressed: () {
                          pickImage();
                        }
                      ),
                    ) : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: GestureDetector(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
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
                        onTap: () {
                          pickImage();
                        },
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
                                  child: localtion == null || localtion == '' || localtion == '中国' ? 
                                    Text(
                                      '故事发生在哪里',
                                      style: TextStyle(color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                                    ) : Row(
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2 - 90,
                                        child: Text(    
                                          localtion,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Image.asset('assets/img/clear-icon.png', width: 14.0,),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            localtion = '';
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              showAddressDialog(context, (address) {
                                setState(() {
                                  localtion = address;
                                });
                              });
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
                                  child: dateTimeStr == null || dateTimeStr == '' ? 
                                  Text(
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
                              showModel(context, 'date', '', '');
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
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
      backgroundColor: Color(0xFFfbf7ed),
    );
  }

  void showAddressDialog(preContext, addressCallback) {
    showDialog(
      context: preContext,
      builder: (context) {
        return Container(
          height: MediaQuery.of(preContext).size.height,
          child: EditMapPage(callback: (addressName) {
            Navigator.of(preContext).pop();
            addressCallback(addressName);
          }),
        );
      } 
    );
  }
  
  void showModel(preContext, type, id, name) {
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
                  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                  dateTimeStr = dateFormat.format(dateTime); 
                });
              }
            );
          }
        );
        break;
      case 'publish':
        showDialog(
          context: preContext, 
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('确定发布或修改内容？'),
              actions:<Widget>[
                CupertinoDialogAction(
                  child: Text('确定'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final voidCallback = showWeuiLoadingToast(context: context, message: Text('发布中'));
                    ListFormData listFormData = new ListFormData(contentController.text, imageUrl, localtion, dateTimeStr);
                    bool result = await DioWeb.editCategoryDetail(listFormData, widget.listItem);
                    voidCallback();
                    if (result) {
                      showWeuiSuccessToast(context: context, message: Text('发布成功'), closeDuration: Duration(milliseconds: 1000));
                      Future.delayed(Duration(milliseconds: 1200), (){
                        Navigator.of(preContext).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Home(id: id, name: name);
                          }
                        )); 
                      });
                    }
                  },
                ),
                CupertinoDialogAction(
                  child: Text('取消'),
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