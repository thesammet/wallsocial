import 'dart:async';
import 'dart:io';
import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallSocial/DefaultWidgets/defaultTextfield.dart';

import '../../../config.dart';
import 'upload_photo_preview.dart';

class UploadPhotoAddDetails extends StatefulWidget {
  final File uploadImg;

  const UploadPhotoAddDetails({
    Key key,
    this.uploadImg,
  }) : super(key: key);

  @override
  _UploadPhotoAddDetailsState createState() => _UploadPhotoAddDetailsState();
}

class _UploadPhotoAddDetailsState extends State<UploadPhotoAddDetails> {
  TextEditingController _tagController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();
  String wallpaperImageUrl = "";

  QueryDocumentSnapshot dropdownValueChoose;
  String dropDownSonItem;
  List<DocumentSnapshot> currenciesTagList;
  StreamSubscription<QuerySnapshot> subscription;

  final collectionReference = FirebaseFirestore.instance
      .collection("categories")
      .orderBy('createdAt', descending: true);

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        currenciesTagList = dataSnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Text(
                    "Upload",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Color(0xffffffff),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "Proxima Nova",
                        fontSize: 17,
                        color: Colors.orange,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      print("preview yapıalcak.");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadPhotoPreview(
                                    uploadImg: widget.uploadImg,
                                  )));
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      Stack(alignment: Alignment.center, children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    FileImage(widget.uploadImg), // picked file
                                fit: BoxFit.cover),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.00),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          height: MediaQuery.of(context).size.height / 3,
                          width: double.infinity,
                        )
                      ]),
                      new Text(
                        "Preview",
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Color(0xffffffff),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  DefaultTextfield(
                    controller: _tagController,
                    hintText: "Ex. Dark",
                    textInputType: TextInputType.emailAddress,
                    topicText: "Title",
                  ),
                  SizedBox(height: 15),
                  currenciesTagList != null
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: DropdownButton(
                                underline: SizedBox(),
                                dropdownColor: Colors.black,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                isExpanded: true,
                                style: TextStyle(
                                  fontFamily: "Proxima Nova",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                hint: new Text(
                                  "Select Category",
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                value: dropdownValueChoose,
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownValueChoose = newValue;
                                  });
                                },
                                items: currenciesTagList.map((valueItem) {
                                  return DropdownMenuItem(
                                      onTap: () {
                                        setState(() {
                                          dropDownSonItem =
                                              valueItem['categoryName'];
                                        });
                                      },
                                      value: valueItem,
                                      child: Text(valueItem['categoryName']));
                                }).toList()),
                          ),
                        )
                      : new Container(),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      uploadAndSaveImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Publish",
                          style: TextStyle(
                            fontFamily: 'Proxima Nova',
                            fontSize: 16,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> uploadAndSaveImage() async {
    await uploadToStorage();
  }

  Future<void> uploadToStorage() async {
    /*showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            loadingMessage: "Your account is being created. Please wait...",
          );
        });*/

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

     Reference stroageReference =
        FirebaseStorage.instance.ref().child(imageFileName);

    UploadTask storageUploadTask = stroageReference
        .putFile(/*compressFile(widget.uploadImg)*/ widget.uploadImg);

    TaskSnapshot taskSnapshot = await storageUploadTask;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) async {
      wallpaperImageUrl = urlImage;
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("wallpapers").doc();

      Map<String, dynamic> wallpaperData = {
        "category": dropDownSonItem,
        "tag": _tagController.text.toString().trim(),
        "user": WallShare.sharedPreferences.get(WallShare.userUID),
        "createdAt": Timestamp.now(),
        "url": wallpaperImageUrl
      };
      await documentReference.set(wallpaperData).whenComplete(() {
        Fluttertoast.showToast(
            msg: "Your wallpaper uplaod succesfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    });
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 15,
    );
    return compressedFile;
  }

  
}
