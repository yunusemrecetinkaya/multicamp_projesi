import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/home_view/home_view.dart';
import 'package:multicamp_haberler_projesi/view/kullanici_gelistirici/gelistirici_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String _isSelected = 'light';
  bool _isDark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isDark = AdaptiveTheme.of(context).mode.isDark;
  }

  bool isSwitched = false;

  Future<void> deletePrefs() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setBool("storedIsOpened", false);
    print('SİLME ÇALIŞTI ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ayarlar'.tr().toString()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Container(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title
              SizedBox(
                width: double.infinity,
                child: Text(
                  'detayOzellikler'.tr().toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Constants().buttonColor),
                ),
              ),
              Divider(
                color: Constants().buttonColor,
                thickness: 1,
              ),
              // lisanslar
              ListTile(
                title: Text(
                  'lisanslar'.tr().toString(),
                  style: text(),
                ),
                trailing: FaIcon(FontAwesomeIcons.certificate),
                onTap: () => showLicensePage(
                    applicationVersion: 'Version 1.0',
                    applicationLegalese: '© 2020 Yunus Emre Çetinkaya',
                    context: context,
                    // applicationIcon: Image.asset(name)
                    applicationName: "MultiCamp Haber"
                    // Other parameters
                    ),
              ),
              ListTile(
                title: Text(
                  'gelistirici'.tr().toString(),
                  style: text(),
                ),
                trailing: FaIcon(FontAwesomeIcons.code),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => GelistiriView())),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'tema'.tr().toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Constants().buttonColor),
                ),
              ),
              Divider(
                color: Constants().buttonColor,
                thickness: 1,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'tema'.tr().toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      /* FlatButton(
                        onPressed: () {
                          AdaptiveTheme.of(context).setLight();
                        },
                        child: Text('Light'),
                        color: Colors.red,
                      ), */
                      InkWell(
                        onTap: () => AdaptiveTheme.of(context).setLight(),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Constants().buttonColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Light',
                              style: TextStyle(
                                color: Constants().buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () => AdaptiveTheme.of(context).setDark(),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Constants().buttonColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Dark',
                              style: TextStyle(
                                color: Constants().buttonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      /* RaisedButton(
                        onPressed: () {
                          AdaptiveTheme.of(context).setDark();
                        },
                        child: Text('Dark'),
                      ), */
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'dil'.tr().toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Constants().buttonColor),
                ),
              ),
              Divider(
                color: Constants().buttonColor,
                thickness: 1,
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'dil'.tr().toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      LiteRollingSwitch(
                        value: false,
                        textOn: 'EN',
                        textOff: 'TR',
                        iconOn: FontAwesomeIcons.globeEurope,
                        iconOff: FontAwesomeIcons.globeEurope,
                        colorOn: Colors.red,
                        colorOff: Colors.blue,
                        onChanged: (bool state) {
                          print('turned ${(state) ? 'on' : 'off'}');
                          state == true
                              ? EasyLocalization.of(context).locale =
                                  Locale('tr', 'TR')
                              : EasyLocalization.of(context).locale =
                                  Locale('en', 'EN');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'hesap'.tr().toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Constants().buttonColor),
                ),
              ),
              Divider(
                color: Constants().buttonColor,
                thickness: 1,
              ),

              ListTile(
                  title: Text(
                    'cikisYap'.tr().toString(),
                    style: text(),
                  ),
                  trailing: FaIcon(FontAwesomeIcons.signOutAlt),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeView()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  text() {
    return TextStyle(
      fontSize: 20,
    );
  }
}

class ThemeModelim with ChangeNotifier {
  ThemeMode mode;
  //ThemeMode get mode => _mode;

  ThemeModelim(ThemeMode mode) {
    this.mode = mode;
    notifyListeners();
  }
}
