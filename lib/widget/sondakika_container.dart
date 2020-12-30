import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/view/news_view/news_detail.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'loading_image.dart';

class SondakikaNewsTile extends StatelessWidget {
  final List<RssItem> _items;
  SondakikaNewsTile(this._items);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = _items[index];
        return InkWell(
          onTap: () {
            print('YONLENDİRME ===>>> ${item.link}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NewsDetail(item)));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: LoadingImage(item),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: Text(
                      item.title.replaceAll('&#39;', '\''),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
