import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_time_screen/first_time_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/auth/splash_view.dart';
import 'package:multicamp_haberler_projesi/view/on_board/on_board_view.dart';
import 'package:provider/provider.dart';

import 'model/news_item_model.dart';
import 'view/setting_view/setting_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsItemModel())],
      child: EasyLocalization(
        path: "resources/langs",
        saveLocale: true,
        supportedLocales: [
          Locale('tr', 'TR'),
          Locale('en', 'EN'),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      initial: AdaptiveThemeMode.light,
      light: ThemeData(
          textTheme: GoogleFonts.mondaTextTheme(
            Theme.of(context).textTheme,
          ),
          brightness: Brightness.light,
          primaryColor: Constants().homeColor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Constants().mainColor,
          )),
      dark: ThemeData(
        textTheme: GoogleFonts.mondaTextTheme(
          Theme.of(context).textTheme,
        ),
        brightness: Brightness.dark,
        primarySwatch: Constants().switchColor,
        accentColor: Colors.amber,
      ),
      builder: (light, dark) {
        return MaterialApp(
          title: 'Dolphin News',
          theme: light,
          darkTheme: dark,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          //home: SplashView(),
          //home: OnBoardView(),
          home: FirstTimeScreen(
            loadingScreen: Center(
              child: FlareActor(
                'asset/animation/news_animation.flr',
                alignment: Alignment.center,
                animation: 'loading_news',
                fit: BoxFit.fill,
              ),
            ),
            introScreen: MaterialPageRoute(builder: (context) => OnBoardView()),
            landingScreen:
                MaterialPageRoute(builder: (context) => SplashView()),
          ),
        );
      },
    );
  }
}
