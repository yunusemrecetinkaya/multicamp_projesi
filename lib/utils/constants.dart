import 'package:flutter/material.dart';

class Constants {
  String NEWS_RSS_LINK = 'https://www.cnnturk.com/feed/rss/all/news';

  static String category(category) {
    return 'https://www.cnnturk.com/feed/rss/$category/news';
  }

  static const Map<String, String> Category = {
    'Türkiye': 'turkiye',
    'Dünya': 'dunya',
    'Kültür-Sanat': 'kultur-sanat',
    'Bilim-Teknoloji': 'bilim-teknoloji',
    'Yasam': 'yasam',
    'Magazin': 'magazin',
    'Ekonomi': 'ekonomi',
    'Spor': 'spor',
    'Sağlık': 'saglik',
    'Yazar': 'yazar',
    'Otomobil': 'otomobil',
    'Seyahat': 'seyahat',
  };

  Color buttonColor = Colors.red[800];
  Color mainBackgroundColor = Colors.white;
  Color switchColor = Colors.lightGreen;

  Color homeColor = Color(0xff151A39);
  Color mainColor = Color(0xff151A39);
  Color backgroundColor = Color(0xff151A39);
}
