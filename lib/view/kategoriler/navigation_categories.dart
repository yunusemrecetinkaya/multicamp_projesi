import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/model/news_item_model.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/news_home/news_detail.dart';
import 'package:multicamp_haberler_projesi/widget/category_button.dart';
import 'package:multicamp_haberler_projesi/widget/category_news_container.dart';
import 'package:multicamp_haberler_projesi/widget/loading_image.dart';
import 'package:provider/provider.dart';

class NavigationCategories extends StatefulWidget {
  NavigationCategories({Key key}) : super(key: key);

  @override
  NavigationCategoriesState createState() => NavigationCategoriesState();
}

class NavigationCategoriesState extends State<NavigationCategories> {
  String currenCategory = 'Tüm Haberler';
  @override
  Widget build(BuildContext context) {
    var newsItem = Provider.of<NewsItemModel>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          buildCategoryArea(newsItem),

          // CATEGORY NAME AREA
          buildCategoryHeaderArea(),

          // SELECTED LİST CATEGORY
          newsItem.categoryFeed == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildCategoryNewsArea(newsItem),
        ],
      ),
    );
  }

  //category news area
  GridView buildCategoryNewsArea(NewsItemModel newsItem) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: newsItem.categoryFeed.items.length,
      itemBuilder: (BuildContext context, int index) {
        var item = newsItem.categoryFeed.items[index];
        return InkWell(
          onTap: () {
            print('YONLENDİRME ===>>> ${item.link}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NewsDetail(item)));
          },
          /* child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: LoadingImage(item),
              ),
              footer: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  item.title.replaceAll('&#39;', '\''),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ), */
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

// current category name
  Padding buildCategoryHeaderArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Card(
        elevation: 10,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ),
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
