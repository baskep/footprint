import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailContentImage extends StatelessWidget {
  final String imageUrl;

  const DetailContentImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: imageUrl != null && imageUrl != '' ? 200.0 : 0,
    );
  }
}