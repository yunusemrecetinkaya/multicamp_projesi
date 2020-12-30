import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'loading_image.dart';

class CategoryNewsTile extends StatelessWidget {
  RssItem _item;
  CategoryNewsTile(RssItem this._item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: LoadingImage(_item),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                title: Text(
                  _item.title.replaceAll('&#39;', '\''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
