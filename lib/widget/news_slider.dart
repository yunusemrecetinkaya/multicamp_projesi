import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/news_view/news_detail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webfeed/domain/rss_item.dart';

// ignore: must_be_immutable
class NewsSlider extends StatelessWidget {
  final List<RssItem> _item;
  NewsSlider(this._item);

  final _pageController = PageController();
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Positioned.fill(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NewsDetail(_item[index])));
                    },
                    child: Image.network(
                      _item[index].imageUrl,
                      //fit: BoxFit.fill,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      _item[index]
                          .title
                          .replaceAll('&#39;', '\'')
                          .replaceAll('&quot;', '"'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(
              controller: _pageController, // PageController
              count: 10,
              effect: SwapEffect(
                //dotColor:
                activeDotColor: Constants().buttonColor,
                dotHeight: 5,
                dotWidth: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
