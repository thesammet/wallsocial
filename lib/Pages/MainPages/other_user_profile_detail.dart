import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../config.dart';
import 'home.dart';
import 'wallpaper_detail.dart';

class UserProfileDetail extends StatefulWidget {
  final String uid;

  const UserProfileDetail({
    Key key,
    this.uid,
  }) : super(key: key);
  @override
  _UserProfileDetailState createState() => _UserProfileDetailState();
}

class _UserProfileDetailState extends State<UserProfileDetail> {
  List<DocumentSnapshot> userWallpapersList;
  StreamSubscription<QuerySnapshot> subscription;

  //USER PROFILE DETAIL
  List<DocumentSnapshot> userDetailList;

  @override
  void initState() {
    super.initState();
    final collectionReference = FirebaseFirestore.instance
        .collection("wallpapers")
        .where("user", isEqualTo: widget.uid)
        .orderBy('createdAt', descending: true);
    //Date'e göre sıralama
    //.orderBy('createdAt',descending: true)
    final userCollectionReference = FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: widget.uid);
    print("Ziyaret edilen profil uidsi: " + widget.uid);
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        userWallpapersList = dataSnapshot.docs;
      });
    });
    subscription = userCollectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        userDetailList = dataSnapshot.docs;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                            new Text(
                              "Back",
                              style: TextStyle(
                                fontFamily: "Proxima Nova",
                                fontSize: 21,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                      userDetailList != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userDetailList[0].data()['url']),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      Text(
                        "Settings",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontSize: 18,
                          color: Color(0xffffffff),
                        ),
                      )
                    ],
                  ),
                ),
                userDetailList != null
                    ? Text(
                        userDetailList[0].data()['username'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Color(0xffffffff),
                        ),
                      )
                    : Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: Color(0xffffffff),
                        ),
                      ),
                /*Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consetetur \nsadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 16,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.white.withOpacity(0.1),
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        "Uploads",
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Text(
                        "122k Likes",
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xffffffff).withOpacity(0.50),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                userWallpapersList != null
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height - 219,
                            child: new StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemBuilder: (context, index) {
                                String imgPath =
                                    userWallpapersList[index].data()['url'];
                                String tag =
                                    userWallpapersList[index].data()['tag'];
                                String category = userWallpapersList[index]
                                    .data()['category'];

                                return new Material(
                                  color: Colors.black,
                                  elevation: 0.0,
                                  child: InkWell(
                                    onTap: () {
                                      //TAG PARÇALAMA
                                      print("Kategorim: " +
                                          category +
                                          ", Taglerim: " +
                                          tag);

                                      List<String> result = tag.split(".");

                                      print("tag sayısı: " +
                                          result.length.toString());
                                      //EasyLoading.showSuccess('Great Success!');

                                      for (int i = 0; i < result.length; i++) {
                                        print("$i" + ". eleman: " + result[i]);
                                      }

                                      //DETAİLE YÖNLENDİRME

                                      userWallpapersList[index]
                                                  .data()['user'] !=
                                              null
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WallpaperDetail(
                                                        wallpaperUrl:
                                                            userWallpapersList[
                                                                    index]
                                                                .data()['url'],
                                                        wallpaperTagList:
                                                            result,
                                                        wallpaperUser:
                                                            userWallpapersList[
                                                                    index]
                                                                .data()['user'],
                                                      )))
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WallpaperDetail(
                                                          wallpaperUrl:
                                                              userWallpapersList[
                                                                          index]
                                                                      .data()[
                                                                  'url'],
                                                          wallpaperTagList:
                                                              result,
                                                          wallpaperUser:
                                                              "Editorial")));
                                    },
                                    child:
                                        //HERO ANİMASYON SAĞLAR.
                                        new Hero(
                                      tag: imgPath,
                                      child: new FadeInImage(
                                        placeholder: new AssetImage(
                                            "lib/assets/cvfoto.png"),
                                        image: NetworkImage(imgPath),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              staggeredTileBuilder: (index) =>
                                  new StaggeredTile.count(
                                      2, index.isEven ? 3 : 2),
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              itemCount: userWallpapersList.length,
                            ),
                          ),
                        ),
                      )
                    : new Center(child: new CircularProgressIndicator()),
              ],
            ),
          ),
          /*
          //LOGOUT BUTTON
              InkWell(
            onTap: () async {
              if (WallShare.sharedPreferences.getString("uid") == null) {
                Route route = MaterialPageRoute(builder: (c) => Login());
                Navigator.pushReplacement(context, route);
              } else {
                //signOutGoogle();
                await WallShare.sharedPreferences.setString("uid", null);
                await WallShare.sharedPreferences
                    .setString(WallShare.userEmail, null);
                await WallShare.sharedPreferences
                    .setString(WallShare.userName, null);
                await WallShare.sharedPreferences
                    .setString(WallShare.userAvatarUrl, null);
                WallShare.auth.signOut().then((c) {
                  Route route = MaterialPageRoute(builder: (c) => Login());
                  Navigator.pushReplacement(context, route);
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 50.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultButton(
                    text: WallShare.sharedPreferences.getString("uid") == null
                        ? 'Register or Login'
                        : 'Logout',
                  )
                ],
              ),
            ),
          ),*/
        ),
      ),
    );
  }
}
