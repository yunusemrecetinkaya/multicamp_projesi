import 'dart:convert' show utf8;

import 'package:flutter/cupertino.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

enum PageStatus {
  loading,
  complated,
  empty,
}

class NewsItemModel with ChangeNotifier {
  PageStatus pageStatus1 = PageStatus.empty;
  PageStatus pageStatus2 = PageStatus.empty;
  RssFeed feed;
  RssFeed categoryFeed;
  RssFeed searchItem;

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Constants().NEWS_RSS_LINK);
      //final result = RssFeed.parse(utf8.decode(response.bodyBytes));

      return RssFeed.parse(utf8.decode(response.bodyBytes));
    } catch (e) {
      //
    }
    return null;
  }

  Future<RssFeed> loadCategoryFeed(category) async {
    try {
      final client = http.Client();
      final response = await client.get(Constants.category(category));
      return RssFeed.parse(utf8.decode(response.bodyBytes));
      //return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  haberleriAl() async {
    await loadFeed().then((value) {
      pageStatus1 = PageStatus.loading;
      feed = value;
      notifyListeners();
    });

    if (feed == null) {
      pageStatus1 = PageStatus.empty;
    } else {
      pageStatus1 = PageStatus.complated;
    }
  }

  categoryHaberleriAl(category) async {
    await loadCategoryFeed(category).then((value) {
      pageStatus2 = PageStatus.loading;
      categoryFeed = value;
      notifyListeners();
    });
    notifyListeners();

    if (categoryFeed == null) {
      pageStatus2 = PageStatus.empty;
    } else {
      pageStatus2 = PageStatus.complated;
    }
  }
}
