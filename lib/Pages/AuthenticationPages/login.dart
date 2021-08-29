
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallSocial/DefaultWidgets/defaultButton.dart';
import 'package:wallSocial/DefaultWidgets/defaultTextfield.dart';
import 'package:wallSocial/DefaultWidgets/dialogWidget.dart';
import 'package:wallSocial/Pages/AuthenticationPages/register.dart';
import 'package:wallSocial/Pages/MainPages/home.dart';

import '../../config.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  IconData passwordIconData = Icons.visibility;
  bool _obscureText = true;
  String _password;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Proxima Nova',
                      fontSize: 16,
                      color: const Color(0xffffffff),
                    ),
                    children: [
                      TextSpan(
                        text: 'Wall',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.blue,
                            fontSize: 52),
                      ),
                      TextSpan(
                        text: 'SHARE',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 52),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DefaultTextfield(
                              controller: _emailController,
                              hintText: "Ex. wallsocial@gmail.com",
                              textInputType: TextInputType.emailAddress,
                              topicText: "Email",
                            ),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    initialValue: null,
                                    controller: _passwordController,
                                    decoration: new InputDecoration(
                                      suffixIcon: IconButton(
                                          color: Colors.white54,
                                          onPressed: () {
                                            _toggle();
                                            _obscureText
                                                ? passwordIconData =
                                                    Icons.visibility_outlined
                                                : passwordIconData = Icons
                                                    .visibility_off_outlined;
                                          },
                                          icon: Icon(passwordIconData)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      labelText: "Password",
                                      hintText: "********",
                                      labelStyle: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontSize: 14,
                                        color: const Color(0xffffffff),
                                      ),
                                      hintStyle: TextStyle(
                                        fontFamily: 'Gotham',
                                        fontSize: 17,
                                        color: const Color(0xffCBC9C9),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(9.0),
                                      ),
                                    ),
                                    validator: (val) => val.length < 6
                                        ? 'Password too short.'
                                        : null,
                                    onSaved: (val) => _password = val,
                                    obscureText: _obscureText,
                                    style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("login tıklandı.");
                        _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty
                            ? loginUser()
                            : showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorAlertDialog(
                                    errorMessage:
                                        "Please write email and password",
                                  );
                                });
                      },
                      child: DefaultButton(
                        text: "Login",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Proxima Nova',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                          ),
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account?',
                            ),
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                        await WallShare.sharedPreferences
                            .setString("uid", null);
                        await WallShare.sharedPreferences
                            .setString(WallShare.userEmail, null);
                        await WallShare.sharedPreferences
                            .setString(WallShare.userName, null);
                        await WallShare.sharedPreferences
                            .setString(WallShare.userAvatarUrl, null);
                      },
                      child: Text(
                        'Continue without login ->',
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            loadingMessage: "Logging into your account...",
          );
        });

    User firebaseUser;

    await _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((onError) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              errorMessage: onError.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(User fUser) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await WallShare.sharedPreferences
          .setString("uid", dataSnapshot.data()[WallShare.userUID]);
      await WallShare.sharedPreferences.setString(
          WallShare.userEmail, dataSnapshot.data()[WallShare.userEmail]);
      await WallShare.sharedPreferences.setString(
          WallShare.userName, dataSnapshot.data()[WallShare.userName]);
      await WallShare.sharedPreferences.setString(WallShare.userAvatarUrl,
          dataSnapshot.data()[WallShare.userAvatarUrl]);
    });
  }
}
