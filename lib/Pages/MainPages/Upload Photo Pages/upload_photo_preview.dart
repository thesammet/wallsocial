import 'dart:io';

import 'package:flutter/material.dart';

class UploadPhotoPreview extends StatefulWidget {
  final File uploadImg;

  const UploadPhotoPreview({
    Key key,
    this.uploadImg,
  }) : super(key: key);
  @override
  _UploadPhotoPreviewState createState() => _UploadPhotoPreviewState();
}

class _UploadPhotoPreviewState extends State<UploadPhotoPreview> {
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
                      "Preview",
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
                        "Close",
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
                height: 5,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("preview yapıalcak.");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(widget.uploadImg), // picked file
                            fit: BoxFit.cover),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
