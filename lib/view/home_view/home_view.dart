import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/auth/login_view.dart';
import 'package:multicamp_haberler_projesi/view/auth/register.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildImage(),
          buildContent(context),
        ],
      ),
    );
  }

  Expanded buildImage() {
    return Expanded(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          child: SvgPicture.asset('asset/login_images/home_img.svg'),
        ),
      ),
    );
  }

  Expanded buildContent(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Constants().homeColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(150, 50),
            topRight: Radius.elliptical(150, 50),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            AutoSizeText(
              'Geçmişten Geleceğe',
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Spacer(),
            AutoSizeText(
              "Tarafsız ve doğru haberler anında cebinde.",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            AutoSizeText(
              "Henüz kayıt olmadıysan ücretsiz kayıt olabilirsin.",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: Constants().buttonColor,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RegisterView())),
                child: Text('Kayıt Ol'),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                color: Constants().buttonColor,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginView())),
                child: Text('Giriş Yap'),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
