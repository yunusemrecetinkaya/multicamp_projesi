import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multicamp_haberler_projesi/widget/bottom_navigation_bar.dart';

class LoginWithEmail {
  loginWithEmail(
      {String email,
      String password,
      BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    HomeScreenView(userCredential.user)));
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          final snackBar = SnackBar(
            content: Text('Bu e-posta için kullanıcı bulunamadı.'),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
          break;
        case 'wrong-password':
          final snackBar = SnackBar(
            content: Text('Yanlış şifre girildi.'),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
          break;
      }
    } catch (e) {
      print('HATA ===>> $e');
    }
  }
}
