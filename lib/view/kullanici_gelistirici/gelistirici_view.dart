import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class GelistiriView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gelistirici'.tr().toString()),
        centerTitle: true,
        leading: Center(
            child: InkWell(
          onTap: () => Navigator.pop(context),
          child: FaIcon(
            FontAwesomeIcons.times,
          ),
        )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Constants().buttonColor,
                          radius: 80,
                          child: ClipOval(
                            child: Image.network(
                              'https://avatars0.githubusercontent.com/u/44640038?s=460&u=04a99b6b7a4e2ce34072a7472865b16eef97351d&v=4',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Yunus Emre ÇETİNKAYA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'FLUTTER DEVELOPER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  tileColor: Colors.black,
                  title: Text(
                    'yunusemrecetinkaya',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.github,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    await launch('https://github.com/yunusemrecetinkaya');
                  },
                ),
              ),
              SizedBox(height: 10),
              uygulamalarim(
                  title: 'KBU Genç',
                  image:
                      'https://play-lh.googleusercontent.com/jgOrnu95mFV_6WaLe4dkl3KapxBDpYkQe2DcDsU7qy3H29s381Xlubx4BKCDAfyPBgI=s360',
                  url:
                      'https://play.google.com/store/apps/details?id=com.kbu.kbuapplication&hl=tr'),
              SizedBox(height: 10),
              uygulamalarim(
                  title: 'Flutter Widget Gallery',
                  image:
                      'https://play-lh.googleusercontent.com/WV4dTJSVwLBW0zzKBq7yYVAT_as92GC-beDhbQwCeLx4cvOODgIfXzmlPw5vESSzleI=s360',
                  url:
                      'https://play.google.com/store/apps/details?id=com.flutter.flutteruiapp&hl=tr'),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  uygulamalarim({String title, String image, String url}) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        tileColor: Colors.green[700],
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        leading: FaIcon(
          FontAwesomeIcons.googlePlay,
          color: Colors.white,
        ),
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(image),
        ),
        onTap: () async {
          await launch(url);
        },
      ),
    );
  }
}
