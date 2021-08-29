import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallSocial/DefaultWidgets/defaultButton.dart';
import 'package:wallSocial/Pages/AuthenticationPages/login.dart';

import '../../../config.dart';
import 'about_us.dart';
import 'faqs.dart';
import 'terms_conditions.dart';

class SettingsMain extends StatefulWidget {
  final String userProfilePhotoUrl, username;

  const SettingsMain({Key key, this.userProfilePhotoUrl, this.username})
      : super(key: key);

  @override
  _SettingsMainState createState() => _SettingsMainState();
}

class _SettingsMainState extends State<SettingsMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cancel",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(widget.userProfilePhotoUrl),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: "Proxima Nova",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.username,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consetetur \nsadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 16,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ),
                Expanded(
                    child: Stack(children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://images.wallpapersden.com/image/wxl-mixed-color-art_61329.jpg",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          border: Border.all(
                            width: 3,
                            style: BorderStyle.solid,
                          ),
                          color: Colors.black,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        color: Colors.black,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              new Text(
                                "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "remixicon",
                                  fontSize: 32,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23.0),
                                child: new Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              new Text(
                                "",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "remixicon",
                                  fontSize: 32,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23.0),
                                child: new Text(
                                  "Notification Settings",
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              if (WallShare.sharedPreferences
                                      .getString("uid") ==
                                  null) {
                                Route route =
                                    MaterialPageRoute(builder: (c) => Login());
                                Navigator.pushReplacement(context, route);
                              } else {
                                //signOutGoogle();
                                await WallShare.sharedPreferences
                                    .setString("uid", null);
                                await WallShare.sharedPreferences
                                    .setString(WallShare.userEmail, null);
                                await WallShare.sharedPreferences
                                    .setString(WallShare.userName, null);
                                await WallShare.sharedPreferences
                                    .setString(WallShare.userAvatarUrl, null);
                                WallShare.auth.signOut().then((c) {
                                  Route route = MaterialPageRoute(
                                      builder: (c) => Login());
                                  Navigator.pushReplacement(context, route);
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DefaultButton(
                                  text: WallShare.sharedPreferences
                                              .getString("uid") ==
                                          null
                                      ? 'Register or Login'
                                      : 'Logout',
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutUs()));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23.0),
                                child: new Text(
                                  "About Us",
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontSize: 14,
                                    color: Color(0xffffffff).withOpacity(0.70),
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TermsConditions()));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23.0),
                                child: new Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontSize: 14,
                                    color: Color(0xffffffff).withOpacity(0.70),
                                  ),
                                )),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 23.0),
                              child: new Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  fontFamily: "Proxima Nova",
                                  fontSize: 14,
                                  color: Color(0xffffffff).withOpacity(0.70),
                                ),
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Faqs()));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23.0),
                                child: new Text(
                                  "Faq & Support",
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontSize: 14,
                                    color: Color(0xffffffff).withOpacity(0.70),
                                  ),
                                )),
                          ),
                        ]),
                  ),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
