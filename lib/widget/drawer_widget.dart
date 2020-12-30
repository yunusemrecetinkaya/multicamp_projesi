import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/home_view/home_view.dart';
import 'package:multicamp_haberler_projesi/view/kullanici_gelistirici/gelistirici_view.dart';
import 'package:multicamp_haberler_projesi/view/kullanici_gelistirici/kullanici_view.dart';
import 'package:multicamp_haberler_projesi/view/setting_view/setting_view.dart';
import 'package:easy_localization/easy_localization.dart';

class DrawerWidget extends StatelessWidget {
  final User user;
  DrawerWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              DrawerHeader(
                  child: Column(
                children: [
                  Container(
                    child: user.photoURL != null
                        ? Expanded(
                            child: Image.network(
                              user.photoURL,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Expanded(
                            child: FaIcon(
                              FontAwesomeIcons.solidImage,
                              size: 50,
                              color: Colors.grey.shade400,
                            ),
                          ),
                  ),
                  SizedBox(height: 10),
                  user.displayName == null
                      ? Expanded(
                          child: AutoSizeText(
                            'hosgeldin'.tr().toString() + ' \n${user.email}',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Expanded(
                          child: AutoSizeText(
                            'hosgeldin'.tr().toString() +
                                ' \n${user.displayName}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                ],
              )),

              ListTile(
                title: Text(
                  'profil'.tr().toString(),
                ),
                leading: FaIcon(
                  FontAwesomeIcons.userAlt,
                  color: Constants().buttonColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              KullaniciView(user)));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'gelistirici'.tr().toString(),
                ),
                leading: FaIcon(
                  FontAwesomeIcons.code,
                  color: Constants().buttonColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => GelistiriView()));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'ayarlar'.tr().toString(),
                ),
                leading: FaIcon(
                  FontAwesomeIcons.cogs,
                  color: Constants().buttonColor,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SettingView()));
                },
              ),
              Spacer(),

              /// ÇIKIŞ YAP
              ListTile(
                title: Text(
                  'cikisYap'.tr().toString(),
                  style: TextStyle(
                    color: Constants().buttonColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                leading: FaIcon(
                  FontAwesomeIcons.signOutAlt,
                  color: Constants().buttonColor,
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeView()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
