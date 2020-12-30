import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:multicamp_haberler_projesi/view/home_view/home_view.dart';
import 'package:multicamp_haberler_projesi/widget/bottom_navigation_bar.dart';

class OnBoardView extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Tarafsızlık İlkemiz",
          body: "Doğru ve tarafsız haberlerimiz ile gerçeği gör.",
          image: Image.asset(
            'asset/images/3.png',
            width: 350.0,
            alignment: Alignment.center,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Haber Ağımız",
          body: "Gelişmiş haber ağımız ile dünyadan anında haberiniz olsun.",
          image: Image.asset('asset/images/2.png', width: 350.0),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Gündemi Kaçırma",
          body: "Bizi sosyal medyada takip edin. Güncel kalın.",
          image: Image.asset('asset/images/1.png', width: 350.0),
          decoration: pageDecoration,
        ),
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeView()));
      },
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
