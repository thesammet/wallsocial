import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallSocial/Pages/MainPages/wallpaper_detail.dart';

import '../../config.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<DocumentSnapshot> wallpapersList, categoryList;
  StreamSubscription<QuerySnapshot> subscription;

  final collectionReference = FirebaseFirestore.instance
      .collection("wallpapers")
      .orderBy('createdAt', descending: true);

  @override
  void initState() {
    super.initState();

    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        wallpapersList = dataSnapshot.docs;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  TextEditingController searchText = new TextEditingController();
  FocusNode inputNodeMain = FocusNode();
  bool searchState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  final collectionReference = FirebaseFirestore.instance
                      .collection("wallpapers")
                      .where("category", isEqualTo: "Editorial");
                  subscription =
                      collectionReference.snapshots().listen((dataSnapshot) {
                    setState(() {
                      wallpapersList = dataSnapshot.docs;
                    });
                  });
                });
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
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
                      inherit: true,
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: Offset(-1.5, -1.5),
                            color: Colors.yellow[700]),
                        Shadow(
                            // bottomRight
                            offset: Offset(1.5, -1.5),
                            color: Colors.yellow[700]),
                        Shadow(
                            // topRight
                            offset: Offset(1.5, 1.5),
                            color: Colors.yellow[700]),
                        Shadow(
                            // topLeft
                            offset: Offset(-1.5, 1.5),
                            color: Colors.yellow[700]),
                      ],
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 36),
                ),
                TextSpan(
                  text: 'SHARE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 36,
                  ),
                ),
              ],
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                child: TextField(
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      wallpapersList = wallpapersList.where((note) {
                        var tag = wallpapersList[0].data()['tag'].toLowerCase();
                        return tag.contains(text);
                      }).toList();
                    });
                  },
                  cursorColor: Colors.orange[400],
                  cursorWidth: 1,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 22.0, color: Colors.white.withOpacity(0.12)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.12),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 15,
                      color: Color(0xffffffff).withOpacity(0.50),
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.12)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.12)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    child: wallpapersList != null
                        ? StaggeredGridView.countBuilder(
                            staggeredTileBuilder: (index) =>
                                new StaggeredTile.count(
                                    2, index.isEven ? 3 : 3),
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                            itemCount: wallpapersList.length,
                            crossAxisCount: 6,
                            itemBuilder: (context, index) {
                              String imgPath =
                                  wallpapersList[index].data()['url'];
                              String tag = wallpapersList[index].data()['tag'];
                              String category =
                                  wallpapersList[index].data()['category'];

                              return Material(
                                color: Colors.black,
                                elevation: 0.0,
                                child: InkWell(
                                  onTap: () {
                                    print("first tag:" +
                                        wallpapersList[0].data()['tag']);
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

                                    wallpapersList[index].data()['user'] != null
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WallpaperDetail(
                                                      wallpaperUrl:
                                                          wallpapersList[index]
                                                              .data()['url'],
                                                      wallpaperTagList: result,
                                                      wallpaperUser:
                                                          wallpapersList[index]
                                                              .data()['user'],
                                                    )))
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WallpaperDetail(
                                                        wallpaperUrl:
                                                            wallpapersList[
                                                                    index]
                                                                .data()['url'],
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
                                          "lib/assets/blackback.png"),
                                      image: NetworkImage(imgPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : new Text(
                            "Loading...",
                            style: TextStyle(color: Colors.white),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_listItem(index, wallpapersList, context, imgPath, category, tag) {
  Material(
    color: Colors.black,
    elevation: 0.0,
    child: InkWell(
      onTap: () {
        //TAG PARÇALAMA
        print("Kategorim: " + category + ", Taglerim: " + tag);

        List<String> result = tag.split(".");

        print("tag sayısı: " + result.length.toString());
        //EasyLoading.showSuccess('Great Success!');

        for (int i = 0; i < result.length; i++) {
          print("$i" + ". eleman: " + result[i]);
        }

        //DETAİLE YÖNLENDİRME

        wallpapersList[index].data()['user'] != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WallpaperDetail(
                          wallpaperUrl: wallpapersList[index].data()['url'],
                          wallpaperTagList: result,
                          wallpaperUser: wallpapersList[index].data()['user'],
                        )))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WallpaperDetail(
                        wallpaperUrl: wallpapersList[index].data()['url'],
                        wallpaperTagList: result,
                        wallpaperUser: "Editorial")));
      },
      child:
          //HERO ANİMASYON SAĞLAR.
          new Hero(
        tag: imgPath,
        child: new FadeInImage(
          placeholder: new AssetImage("lib/assets/blackback.png"),
          image: NetworkImage(imgPath),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wallSocial/DefaultWidgets/defaultTextfield.dart';

class UserHomeDashboard extends StatefulWidget {
  @override
  _UserHomeDashboardState createState() => _UserHomeDashboardState();
}

TextEditingController _tagController = new TextEditingController();
TextEditingController _urlController = new TextEditingController();

class _UserHomeDashboardState extends State<UserHomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        mini: true,
        onPressed: () async {
          DocumentReference documentReference =
              FirebaseFirestore.instance.collection("wallpapers").doc();

          Map<String, dynamic> wallpaperData = {
            "category": "Editorial",
            "tag": _tagController.text.toString().trim(),
            "url": _urlController.text.toString().trim(),
            "createdAt": Timestamp.now(),
          };
          await documentReference.set(wallpaperData).whenComplete(() {
            print("data gönderildi.");
            _urlController.text = "";
            _tagController.text = "";
          });
        },
        child: Icon(
          Icons.adb,
        ),
      ),
      body: SafeArea(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Editor Upload Photo",
                  style: TextStyle(
                    fontFamily: 'Gotham',
                    fontSize: 17,
                    color: Colors.orange.withOpacity(0.5),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DefaultTextfield(
                controller: _urlController,
                hintText: "Ex. unsplash.com/darktheme.background...",
                textInputType: TextInputType.emailAddress,
                topicText: "Image URL",
              ),
              SizedBox(
                height: 20,
              ),
              DefaultTextfield(
                controller: _tagController,
                hintText: "Ex. Modern.Stylish.Fashion.Simple",
                textInputType: TextInputType.emailAddress,
                topicText: "Tags",
              ),
            ],
          ),
        )),
      ),
    );
  }
}
*/
