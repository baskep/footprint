import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:footprint/model/category.dart';

class ListText extends StatelessWidget {

  final CategoryDetail categoryDetail;

  const ListText({Key key, this.categoryDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          height: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text(categoryDetail.categoryDetailName, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          categoryDetail.dateTime != '' || categoryDetail.localtion != '' ? 
                            Container(
                              width: 4,
                              height: 28,
                              color: Color(0xFF4abdcc),
                            ) : Container(),
                          Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  categoryDetail.dateTime != '' ? categoryDetail.dateTime : '', 
                                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                                ),
                                Text(
                                  categoryDetail.localtion != '' ? categoryDetail.localtion : '', 
                                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      child: categoryDetail.avatar != null && categoryDetail.avatar != '' ?
                        CachedNetworkImage(
                          imageUrl: categoryDetail.avatar,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )
                            )
                          )
                        ) : Container(
                          child: ClipOval(
                            child: Image.asset(
                              'assets/img/default-avatar.png',
                              width: 59,
                              height: 59,
                              fit: BoxFit.cover,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(30.0)
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'by ' + categoryDetail.user, 
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        )
      )
    );
  }
}