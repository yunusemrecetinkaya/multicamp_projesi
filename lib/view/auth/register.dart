import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formController = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants().homeColor,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: size.height * .25,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            'Hemen Bizimle\nİlk Adımını At',
                            //maxLines: 3,
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SvgPicture.asset('asset/svg/register.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Form(
                key: _formController,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            border: InputBorder.none,
                            icon: FaIcon(FontAwesomeIcons.at),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Lütfen mail giriniz';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Şifre',
                            border: InputBorder.none,
                            icon: FaIcon(FontAwesomeIcons.lock),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Lütfen şifre giriniz';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    CupertinoButton(
                      color: Constants().buttonColor,
                      onPressed: () async {
                        if (_formController.currentState.validate()) {
                          createUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                              scaffoldKey: _scaffoldKey);
                        }
                      },
                      child: Text('Kayıt Ol'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createUser(
      {String email,
      String password,
      GlobalKey<ScaffoldState> scaffoldKey}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        Navigator.pop(context);
        final snacBar = SnackBar(
          content: Text('Kayıt Başarılı'),
        );
        return scaffoldKey.currentState.showSnackBar(snacBar);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          final snackBar = SnackBar(
            content: Text('Girilen şifre zayıf.'),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
          break;
        case 'emaıl-already-ın-use':
          final snackBar = SnackBar(
            content: Text('Bu e-posta için hesap zaten var.'),
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
          break;
      }
    } catch (e) {
      print('HATA ===>> $e');
    }
  }
}
