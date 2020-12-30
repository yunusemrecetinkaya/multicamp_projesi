import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

class LoadingImage extends StatelessWidget {
  RssItem _item;
  LoadingImage(RssItem item) {
    this._item = item;
  }

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
