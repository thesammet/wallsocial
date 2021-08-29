import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallSocial/DefaultWidgets/defaultButton.dart';

import 'upload_photo_add_details.dart';

class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _image != null
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: "Proxima Nova",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _image == null
                ? GestureDetector(
                    onTap: getImage,
                    child: Container(
                      height: 308.00,
                      width: 319.00,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.download_outlined,
                            color: Colors.white.withOpacity(0.7),
                            size: 100,
                          ),
                          new Text(
                            "Choose a file",
                            style: TextStyle(
                              fontFamily: "Proxima Nova",
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Color(0xffffffff),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          width: 2.00,
                          color: Color(0xffffffff),
                        ),
                        borderRadius: BorderRadius.circular(15.00),
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.orange.withOpacity(0.7),
                        size: 100,
                      ),
                      new Text(
                        "Wallpaper upload completed.",
                        style: TextStyle(
                          fontFamily: "Proxima Nova",
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Color(0xffffffff),
                        ),
                      )
                    ],
                  ),
            SizedBox(height: 15),
            _image == null
                ? new Text(
                    "PNG, JPG formats are only supported ",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 14,
                      color: Color(0xffffffff).withOpacity(0.50),
                    ),
                  )
                : Container(),
            SizedBox(height: 30),
            _image != null
                ? GestureDetector(
                    onTap: () {
                      print("continue butonu");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadPhotoAddDetails(
                                    uploadImg: _image,
                                  )));
                    },
                    child: DefaultButton(text: "Continue"))
                : Container()
          ],
        ),
      ),
    );
  }
}
