import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:footprint/pages/detail.dart';
import 'package:footprint/pages/edit_page.dart';

import 'package:footprint/model/category.dart';

class CategoryItem extends StatelessWidget {

  final CategoryDetail categoryDetail;
  final String homeId;
  final String homeName;

  const CategoryItem({Key key, this.categoryDetail, this.homeId, this.homeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        width: MediaQuery.of(context).size.width / 5.5,
        height: 68.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFb2b2b2),
              blurRadius: 4.0,
            )
          ]
        ),
        child: categoryDetail.imageUrl == null || categoryDetail.imageUrl == '' ?
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Image.asset('assets/img/pic.png', width: 24.0, height: 24.0),
              ),
              Text(
                categoryDetail.categoryDetailName, 
                overflow: TextOverflow.ellipsis, 
                maxLines: 1, 
                style: TextStyle(fontSize: 12.0, color: Color(0xFF999999))
              )
            ],
          ) :
          Container(
            child: Stack(
              children: <Widget>[
                Align(
                  child: Container(
                    height: 68.0,
                    child: CachedNetworkImage(
                    imageUrl: categoryDetail.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )
                      )
                    )
                  )
                ),
                  alignment: Alignment.topCenter,
                ),
                Align(
                  child: Text(
                    categoryDetail.categoryDetailName, 
                    overflow: TextOverflow.ellipsis, 
                    maxLines: 1, 
                    style: TextStyle(fontSize: 12.0, color: Colors.white)
                  ),
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
          )
      ),
      onTap: () {
        showCupertinoModalPopup (
          context: context,
          builder: (BuildContext context) {
            return CupertinoActionSheet(
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text('编辑'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return EditPage(listItem: categoryDetail, homeId: homeId, homeName: homeName);
                      }
                    ));
                  },
                  isDefaultAction: false,
                ),
                CupertinoActionSheetAction(
                  child: Text('查看详情'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Detail(listItem: categoryDetail);
                      }
                    ));
                  },
                  isDestructiveAction: false,
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }
        );
      },
    );
  }
}