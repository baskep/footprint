import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListImage extends StatelessWidget {

  final String imageUrl;

  const ListImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
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
        height: 200.0,
      ),
      alignment: Alignment.topCenter,
    );
  }
}