import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatelessWidget {
  final RssItem item;
  NewsDetail(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
            item.title.replaceAll('&#39;', '\'').replaceAll('&quot;', '"'),
            maxLines: 2),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              final RenderBox box = context.findRenderObject();
              await Share.share(item.title + '\n\n' + item.link,
                  subject: item.link,
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: item.link,
      ),
    );
  }
}
