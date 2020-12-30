import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class KullaniciView extends StatelessWidget {
  User user;
  KullaniciView(User this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        title: Text('profil'.tr().toString()),
        centerTitle: true,
        leading: Center(
            child: InkWell(
          onTap: () => Navigator.pop(context),
          child: FaIcon(
            FontAwesomeIcons.times,
          ),
        )),
        //backgroundColor: Colors.grey.shade200,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            user.photoURL == null
                ? FaIcon(
                    FontAwesomeIcons.solidImage,
                    size: 50,
                    color: Colors.grey.shade400,
                  )
                : ClipOval(
                    child: Image.network(
                      user.photoURL,
                      fit: BoxFit.fill,
                      height: 150,
                    ),
                  ),

            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            ListTile(
              title: user.displayName == null
                  ? Text('E-mail')
                  : Text('adi'.tr().toString()),
              subtitle: user.displayName == null
                  ? Text(user.email)
                  : Text(user.displayName),
              trailing: FaIcon(FontAwesomeIcons.solidEnvelope),
            ),

            Divider(),
            ListTile(
              title: Text('sonOturum'.tr().toString()),
              subtitle: user.metadata != null
                  ? Text(user.metadata.lastSignInTime.toString())
                  : Text(''),
              trailing: FaIcon(FontAwesomeIcons.solidClock),
            ),

            //Spacer()
          ],
        ),
      ),
    );
  }
}
