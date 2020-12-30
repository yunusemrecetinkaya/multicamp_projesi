import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multicamp_haberler_projesi/utils/constants.dart';
import 'package:multicamp_haberler_projesi/view/auth/login_with_email.dart';
import 'package:multicamp_haberler_projesi/widget/bottom_navigation_bar.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Constants().homeColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeaderAndImage(size),
            buildForm(_scaffoldKey),
          ],
        ),
      ),
    );
  }

  Padding buildHeaderAndImage(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: size.height * .25,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  'Zaten Bir Hesabınız Var Mı?',
                  //maxLines: 3,
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    color: Constants().homeColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Expanded(
                child: SvgPicture.asset('asset/svg/login.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildForm(GlobalKey<ScaffoldState> scaffoldKey) {
    return Form(
      key: _formController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
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
          SizedBox(
            height: 10,
          ),
          // EMAİL GİRİS BUTTON
          buildEmailButton(scaffoldKey),
          // DİVİDER ALANI
          buildDivider(),
          // GOOGLE GİRİŞ BUTTON
          buildGoogleSignInButton(scaffoldKey)
        ],
      ),
    );
  }

  buildEmailButton(GlobalKey<ScaffoldState> scaffoldKey) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CupertinoButton(
          color: Constants().buttonColor,
          onPressed: () async {
            if (_formController.currentState.validate()) {
              LoginWithEmail().loginWithEmail(
                  email: _emailController.text,
                  password: _passwordController.text,
                  scaffoldKey: scaffoldKey,
                  context: context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(FontAwesomeIcons.solidEnvelope),
              Text('Giriş Yap')
            ],
          ),
        ),
      ),
    );
  }

  buildDivider() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Expanded(
              child: new Container(
                  child: Divider(
                color: Colors.black,
                height: 36,
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(" VEYA "),
            ),
            Expanded(
              child: new Container(
                  child: Divider(
                color: Colors.black,
                height: 36,
              )),
            ),
          ],
        ),
      ),
    );
  }

  buildGoogleSignInButton(GlobalKey<ScaffoldState> scaffoldKey) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: CupertinoButton(
          color: Constants().buttonColor,
          onPressed: () async {
            try {
              final GoogleSignInAccount googleUser =
                  await GoogleSignIn().signIn();
              final GoogleSignInAuthentication googleAuth =
                  await googleUser.authentication;

              final GoogleAuthCredential credential =
                  GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              // Once signed in, return the UserCredential
              final UserCredential userCredential =
                  await FirebaseAuth.instance.signInWithCredential(credential);

              if (userCredential.user != null) {
                /* Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          NewsView(userCredential.user))); */
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HomeScreenView(userCredential.user)));
              }
              print('HOSGELDIN ${userCredential.user.displayName}');
            } on FirebaseAuthException catch (e) {
              print('ERROR ===>> $e');
            } catch (e) {
              print('ERROR ===>> $e');
            }
          },
          //child: Text('Google Giriş Yap'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(FontAwesomeIcons.google),
              Text('Google ile Giriş Yap')
            ],
          ),
        ),
      ),
    );
  }
}
