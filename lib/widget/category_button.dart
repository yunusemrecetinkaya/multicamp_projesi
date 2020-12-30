import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';

class CategoryButton extends StatelessWidget {
  String _currenCategory;
  String _categoryHeader;
  int _index;
  CategoryButton(String currenCategory, String categoryHeader, int index) {
    this._currenCategory = currenCategory;
    this._categoryHeader = categoryHeader;
    this._index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.all(5),
      // dış container
      decoration: BoxDecoration(
        color: _currenCategory == _categoryHeader
            ? Constants().buttonColor
            : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Constants().buttonColor,
        ),
      ),
      child: Center(
        //yazı
        child: Text(
          Constants.Category.keys.elementAt(_index),
          style: TextStyle(
            color: _currenCategory == _categoryHeader
                ? Colors.white
                : Constants().buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
