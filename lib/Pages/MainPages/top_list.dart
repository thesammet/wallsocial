import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'other_user_profile_detail.dart';

class Toplist extends StatefulWidget {
  @override
  _ToplistState createState() => _ToplistState();
}

class _ToplistState extends State<Toplist> {
  List<DocumentSnapshot> topList;
  StreamSubscription<QuerySnapshot> subscription;

  final collectionReference = FirebaseFirestore.instance
      .collection("users")
      .orderBy(
        "likeNumber",
      )
      .limit(50)
      .orderBy('createdAt', descending: true);

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        topList = dataSnapshot.docs;
      });
    });

    topList != null ? print(topList[0].data()['url']) : print("toplist null");
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Top 50",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                topList != null
                    ? Center(
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: topList.length,
                              itemBuilder: (context, i) {
                                return i == 2
                                    ? Column(
                                        children: [
                                          TopCard(
                                            likeNumber:
                                                topList[topList.length - i - 1]
                                                    .data()['likeNumber'],
                                            number: i + 1,
                                            profileUrl:
                                                topList[topList.length - i - 1]
                                                    .data()['url'],
                                            username:
                                                topList[topList.length - i - 1]
                                                    .data()['username'],
                                            userUid:
                                                topList[topList.length - i - 1]
                                                    .data()['uid'],
                                          ),
                                          Divider(
                                            color: Colors.white60,
                                          )
                                        ],
                                      )
                                    : TopCard(
                                        likeNumber:
                                            topList[topList.length - i - 1]
                                                .data()['likeNumber'],
                                        number: i + 1,
                                        profileUrl:
                                            topList[topList.length - i - 1]
                                                .data()['url'],
                                        username:
                                            topList[topList.length - i - 1]
                                                .data()['username'],
                                        userUid: topList[topList.length - i - 1]
                                            .data()['uid'],
                                      );
                              }),
                        ),
                      )
                    : new CircularProgressIndicator()
              ],
            ),
          ),
        ));
  }
}

class TopCard extends StatelessWidget {
  int number;
  int likeNumber;
  String profileUrl;
  String username;
  int likeNumberRound;
  String userUid;
  TopCard({
    @required this.number,
    @required this.likeNumber,
    @required this.profileUrl,
    @required this.username,
    @required this.userUid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (number == 1)
                new Text(
                  number.toString(),
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontSize: 20,
                    color: Color(0xffffc300),
                  ),
                ),
              if (number == 2)
                new Text(
                  number.toString(),
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontSize: 20,
                    color: const Color(0xffC0C0C0),
                  ),
                ),
              if (number == 3)
                new Text(
                  number.toString(),
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontSize: 20,
                    color: const Color(0xffCD7F32),
                  ),
                ),
              if (number != 1 && number != 2 && number != 3)
                new Text(
                  number.toString(),
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontSize: 16,
                    color: Color(0xffffffff),
                  ),
                ),
              if (number == 1 || number == 2 || number == 3)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      print(userUid);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileDetail(
                                    uid: userUid,
                                  )));
                    },
                    child: GestureDetector(
                      onTap: () {
                        print(userUid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileDetail(
                                      uid: userUid,
                                    )));
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(profileUrl),
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                 onTap: () {
                        print(userUid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfileDetail(
                                      uid: userUid,
                                    )));
                      },
                              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    username,
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        new Text(
          likeNumber.toString() + " Likes",
          style: TextStyle(
            fontFamily: "Proxima Nova",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xffffffff).withOpacity(0.50),
          ),
        ),
      ],
    );
  }
}
