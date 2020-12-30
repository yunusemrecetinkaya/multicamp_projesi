import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/model/news_item_model.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/widget/news_slider.dart';
import 'package:multicamp_haberler_projesi/widget/sondakika_container.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';
import 'package:easy_localization/easy_localization.dart';

class NavigatorHome extends StatefulWidget {
  @override
  _NavigatorHomeState createState() => _NavigatorHomeState();
}

class _NavigatorHomeState extends State<NavigatorHome>
    with SingleTickerProviderStateMixin {
  RssFeed deneme;
  var controller = TextEditingController();
  List<RssItem> searchList;
  AnimationController _animationController;

  String currenCategory = 'Tüm Haberler';
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.addListener(() {
      setState(() {});
    });

    animation = ColorTween(
      begin: Colors.red,
      end: Colors.white,
    ).animate(_animationController);

    _animationController.forward().orCancel;

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var newsItem = Provider.of<NewsItemModel>(context);
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // NEWS SLİDER AREA
          Container(
              height: size.height * .4,
              width: double.infinity,
              child: newsItem.feed == null
                  ? Center(child: CircularProgressIndicator())
                  : NewsSlider(newsItem.feed.items)),
          SizedBox(height: 10),
          BorderedText(
            strokeWidth: 0.5,
            child: Text(
              'sondakika'.tr().toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: animation.value,
              ),
            ),
          ),

          //Search Area
          buildSearchArea(newsItem),

          // search list yazdırma
          controller.text.isNotEmpty
              ? Column(
                  children: [
                    SondakikaNewsTile(searchList),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '${searchList.length} ' + 'sonuc'.tr().toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  ],
                )
              : newsItem.feed == null
                  ? Center(child: CircularProgressIndicator())
                  : SondakikaNewsTile(newsItem.feed.items)
        ],
      ),
    );
  }

  Padding buildSearchArea(NewsItemModel newsItem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        elevation: 10,
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'haberAra'.tr().toString(), border: InputBorder.none),
            onChanged: (value) => onSearch(newsItem, value),
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              searchList.clear();
              onSearch(newsItem, '');
            },
          ),
        ),
      ),
    );
  }

  onSearch(NewsItemModel newsItem, String value) {
    return setState(() {
      searchList = newsItem.feed.items
          .where((element) => element.title.toLowerCase().contains(value))
          .toList();

      print('LİSTE ==>>> ${searchList.length}');
    });
  }
}
