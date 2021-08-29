import 'dart:async';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

import '../../config.dart';
import 'other_user_profile_detail.dart';

class WallpaperDetail extends StatefulWidget {
  final String wallpaperUrl, wallpaperUser;
  final List<String> wallpaperTagList;

  const WallpaperDetail({
    Key key,
    this.wallpaperUrl,
    this.wallpaperTagList,
    this.wallpaperUser,
  }) : super(key: key);

  @override
  _WallpaperDetailState createState() => _WallpaperDetailState();
}

class _WallpaperDetailState extends State<WallpaperDetail> {
  WallpaperDetail walDetail;
  String _wallpaperFile = 'Unknown';
  List<DocumentSnapshot> userDetailList;
  StreamSubscription<QuerySnapshot> subscription;
  String _userUid;

  @override
  void initState() {
    _userUid = widget.wallpaperUser;
    final collectionReference = FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: _userUid);
    if (_userUid == null)
      print("editorial");
    else {
      print("user:" + _userUid);
    }

    super.initState();

    print(widget.wallpaperTagList[0]);
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        userDetailList = dataSnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(alignment: Alignment.topLeft, children: [
              CachedNetworkImage(
                imageUrl: widget.wallpaperUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Container(
                  width: 140,
                  height: 50,
                  child: Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: setWallpaperFromFile,
                          icon: Icon(
                            Icons.file_download,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _getHttp(widget.wallpaperUrl);
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ]),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userDetailList != null
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(
                                    "Ediörse tıklanmayacak değilse başka userın profiline gidilecek.");
                                if (_userUid == "Editorial") {
                                } else if (_userUid ==
                                    WallShare.sharedPreferences
                                        .getString(WallShare.userUID)) {
                                  print(
                                      "Kullanıcı kendi profil kısmına gidecek.");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserProfileDetail(
                                                uid: userDetailList[0]
                                                    .data()['uid'],
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserProfileDetail(
                                                uid: userDetailList[0]
                                                    .data()['uid'],
                                              )));
                                }
                              },
                              child: CircleAvatar(
                                backgroundImage: _userUid == "Editorial"
                                    ? NetworkImage(
                                        "https://play-lh.googleusercontent.com/6LLoG-ddq3qWbZiVjkuvce51LO8OJbzJLP0c2SXu6izpTiriK5ojB5bh4OlHXLTzF4Y")
                                    : userDetailList[0].data()['url'] != null
                                        ? NetworkImage(
                                            userDetailList[0].data()['url'])
                                        : NetworkImage(
                                            "https://cdn2.iconfinder.com/data/icons/users-6/100/USER10-512.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            _userUid == "Editorial"
                                ? Text(
                                    "Social Wall",
                                    style: TextStyle(
                                      fontFamily: "Proxima Nova",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[900],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      print(
                                          "Başka userın profiline gidiliyor.");
                                      if (_userUid ==
                                          WallShare.sharedPreferences
                                              .getString(WallShare.userUID)) {
                                        print(
                                            "Kullanıcı kendi profil kısmına gidecek.");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfileDetail(
                                                      uid: userDetailList[0]
                                                          .data()['uid'],
                                                    )));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfileDetail(
                                                      uid: userDetailList[0]
                                                          .data()['uid'],
                                                    )));
                                      }
                                    },
                                    child: Text(
                                      userDetailList[0].data()['username'],
                                      style: TextStyle(
                                        fontFamily: "Proxima Nova",
                                        fontSize: 17,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  )
                            /*Text(widget.wallpaperTag,
                          style: TextStyle(color: Colors.white, fontSize: 25)),*/
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print("kalbe tıklandı.");
                        },
                      ),
                      Text(
                        "1112",
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontSize: 17,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setWallpaperFromFile() async {
    setState(() {
      _wallpaperFile = "Loading";
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(widget.wallpaperUrl);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperFile = result;
    });
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  _getHttp(String imgUrl) async {
    await _requestPermission();
    var response = await Dio().get(widget.wallpaperUrl,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    print(result);
  }
}
