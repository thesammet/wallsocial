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

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<DocumentSnapshot> wallpapersList, categoryList;
  StreamSubscription<QuerySnapshot> subscription;

  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.cyan
  ];

  Random random = new Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }

// whereIn: ["3D", "Nature", "Popular"] herhangi birini içeren sorgu
  final collectionReference = FirebaseFirestore.instance
      .collection("wallpapers")
      .where("category", isEqualTo: "Editorial")
      .orderBy('createdAt', descending: true);
  //Date'e göre sıralama
  //.orderBy('createdAt',descending: true)

  final collectionCategoryReference = FirebaseFirestore.instance
      .collection("categories")
      .orderBy('createdAt', descending: false);

  @override
  void initState() {
    super.initState();

    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        wallpapersList = dataSnapshot.docs;
      });
    });
    subscription =
        collectionCategoryReference.snapshots().listen((dataSnapshot) {
      setState(() {
        categoryList = dataSnapshot.docs;
      });
    });
    print(WallShare.sharedPreferences.getString(WallShare.userUID));
    changeIndex();
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
              // OLAY BURDA BAŞLIYOR. ALL IMAGES ARE BEING LISTED.
              categoryList != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 4.0, right: 4.0, top: 5.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryList.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            print(
                                                "Category Card kategori değiştirildi.");
                                            setState(() {
                                              final collectionReference =
                                                  FirebaseFirestore.instance
                                                      .collection("wallpapers")
                                                      .where("category",
                                                          isEqualTo: categoryList[
                                                                      i]
                                                                  .data()[
                                                              'categoryName']);
                                              print(categoryList[i]
                                                  .data()['categoryName']);
                                              subscription = collectionReference
                                                  .snapshots()
                                                  .listen((dataSnapshot) {
                                                setState(() {
                                                  wallpapersList =
                                                      dataSnapshot.docs;
                                                });
                                              });
                                            });
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                child: CachedNetworkImage(
                                                  imageUrl: categoryList[i]
                                                      .data()['categoryImage'],
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    height: 50,
                                                    width: 140,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  colors[index]
                                                                      .withOpacity(
                                                                          0.3),
                                                                  BlendMode
                                                                      .colorBurn)),
                                                    ),
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Container(
                                                    width: 140,
                                                    height: 50,
                                                    child: Center(
                                                        child: CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                              new Text(
                                                categoryList[i]
                                                    .data()['categoryName'],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "Proxima Nova",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Color(0xffffffff),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                      ),
                    )
                  : new Center(child: new CircularProgressIndicator()),
              Divider(
                color: Colors.orange[400],
              ),
              wallpapersList != null
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Container(
                          child: new StaggeredGridView.countBuilder(
                            crossAxisCount: 6,
                            itemBuilder: (context, index) {
                              String imgPath =
                                  wallpapersList[index].data()['url'];
                              String tag = wallpapersList[index].data()['tag'];
                              String category =
                                  wallpapersList[index].data()['category'];

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
                            staggeredTileBuilder: (index) =>
                                new StaggeredTile.count(
                                    2, index.isEven ? 3 : 3),
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                            itemCount: wallpapersList.length,
                          ),
                        ),
                      ),
                    )
                  : new Center(child: new CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
