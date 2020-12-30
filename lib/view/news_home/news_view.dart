/* import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/model/news_item_model.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/setting_view/setting_view.dart';
import 'package:multicamp_haberler_projesi/widget/bottom_navigation_bar.dart';
import 'package:multicamp_haberler_projesi/widget/category_button.dart';
import 'package:multicamp_haberler_projesi/widget/drawer_widget.dart';
import 'package:multicamp_haberler_projesi/widget/news_slider.dart';
import 'package:multicamp_haberler_projesi/widget/category_news_container.dart';
import 'package:multicamp_haberler_projesi/widget/sondakika_container.dart';
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';

class NewsView extends StatefulWidget {
  User user;
  NewsView([User user]) {
    this.user = user;
  }

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  RssFeed deneme;
  var controller = TextEditingController();
  List<RssItem> searchList;

  @override
  void initState() {
    super.initState();
    Provider.of<NewsItemModel>(context, listen: false).haberleriAl();
    Provider.of<NewsItemModel>(context, listen: false)
        .categoryHaberleriAl('all');
  }

  String currenCategory = 'Tüm Haberler';

  @override
  Widget build(BuildContext context) {
    var newsItem = Provider.of<NewsItemModel>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Constants().mainBackgroundColor,
        drawerEnableOpenDragGesture: false,
        drawer: DrawerWidget(widget.user),
        //bottomNavigationBar: BottomNavigationBarWidget(),
        appBar: AppBar(
          title: newsItem.feed == null ? Text('') : Text(newsItem.feed.title),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SettingView()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // NEWS SLİDER AREA
              Container(
                  height: size.height * .4,
                  width: double.infinity,
                  child: newsItem.feed == null
                      ? Center(child: CircularProgressIndicator())
                      : NewsSlider(newsItem.feed.items)),

              // CATEGORY HEADERS AREA
              buildCategoryArea(newsItem),

              // CATEGORY NAME AREA
              buildCategoryHeaderArea(),

              // SELECTED LİST CATEGORY
              newsItem.categoryFeed == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : buildCategoryNewsArea(newsItem),
              Divider(),

              // SON DAKİKA AREA
              Text(
                'Son Dakika',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Constants().buttonColor,
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
                            '${searchList.length} adet sonuç bulundu.',
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
        ));
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
                hintText: 'Haber Ara', border: InputBorder.none),
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

  // search List
  onSearch(NewsItemModel newsItem, String value) {
    return setState(() {
      searchList = newsItem.feed.items
          .where((element) => element.title.contains(value))
          .toList();
      print('LİSTE ==>>> ${searchList.length}');
    });
  }

//category news area
  Container buildCategoryNewsArea(NewsItemModel newsItem) {
    return Container(
      height: 175,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemCount: Constants.Category.length,
        itemBuilder: (BuildContext context, int index) {
          var item = newsItem.categoryFeed.items[index];
          return CategoryNewsTile(item);
        },
      ),
    );
  }

// current category name
  Padding buildCategoryHeaderArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Text(
            'Kategori : ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            currenCategory,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Constants().buttonColor,
            ),
          ),
        ],
      ),
    );
  }

// category container title design
  Container buildCategoryArea(NewsItemModel newsItem) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: ClampingScrollPhysics(),
        itemCount: Constants.Category.length,
        itemBuilder: (BuildContext context, int index) {
          String categoryHeader = Constants.Category.keys.elementAt(index);
          String categoryItem = Constants.Category.keys.elementAt(index);
          return InkWell(
            onTap: () {
              setState(() {
                newsItem.categoryHaberleriAl(
                    Constants.Category.values.elementAt(index));
                currenCategory = categoryHeader;
              });
              debugPrint('KATEGORİ ====>>>> $categoryItem');
            },
            child: CategoryButton(currenCategory, categoryHeader, index),
          );
        },
      ),
    );
  }
}
 */
