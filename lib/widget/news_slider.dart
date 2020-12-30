import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsSlider extends StatelessWidget {
  List<RssItem> _item;
  NewsSlider(List<RssItem> items) {
    this._item = items;
  }

  //PageController _pageController;

  final _pageController = PageController();
  var currentIndex = 0;

  //TODO: DETAIL SAYFASINA GİDECEK
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
                  child: Image.network(
                    _item[index].imageUrl,
                    //fit: BoxFit.fill,
                    fit: BoxFit.cover,
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

                // your preferred ecffet
                onDotClicked: (index) {
                  print('NEDİR ::::::. $index');
                }),
          ),
        ),
      ],
    );
  }
}
