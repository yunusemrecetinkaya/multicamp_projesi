import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/view/home_view/home_view.dart';
import 'package:your_splash/your_splash.dart';
import 'package:multicamp_haberler_projesi/widget/bottom_navigation_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen.timed(
      seconds: 5,
      route: MaterialPageRoute(
        builder: (_) => _auth.currentUser != null
            ? HomeScreenView(_auth.currentUser)
            : HomeView(),
      ),
      body: Scaffold(
        body: Center(
          child: InkWell(
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                child: FlareActor(
                  'asset/animation/news_animation.flr',
                  alignment: Alignment.center,
                  animation: 'loading_news',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
