import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
              Scaffold.of(context).openDrawer();
            }
          );
        }),
        actions: <Widget>[
          Builder(builder: (context){
            return IconButton(
              icon: Image.asset('assets/img/edit-publish.png', width: 18.0, height: 18.0),
              onPressed: () {
                print('发布');
              },
            );
          })
        ],
      ),
      body: SingleChildScrollView(
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
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Center(
                    child: IconButton(
                      icon: Image.asset('assets/img/add-icon.png'),
                      onPressed: () {
                        print('点击');
                      }
                    ),
                  )
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
                                child: Text(
                                  '故事发生的时间',
                                  style: TextStyle(color: Color(0xFFCCCCCC), fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            print('点击选择时间');
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
      backgroundColor: Color(0xFFfbf7ed),
    );
  }
}