import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

class LoadingImage extends StatelessWidget {
  final RssItem _item;
  LoadingImage(this._item);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
      imageUrl: _item.imageUrl,
      fit: BoxFit.fill,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )),
        );
      },
    );
  }
}
