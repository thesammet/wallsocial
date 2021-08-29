import 'package:flutter/material.dart';

class Faqs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    iconSize: 36,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Text(
                  "FAQs",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color(0xffffffff),
                  ),
                ),
                new Text(
                  "How can I install/upgrade Dummy \nContent?",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                      style: TextStyle(
                        fontFamily: "Proxima Nova",
                        fontSize: 14,
                        color: Color(0xffffffff),
                      ),
                    )),
                new Text(
                  "Under what license are Regular Labs extensions released?",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Text(
                    "All free and paid Regular Labs extensions are released \nunder the Open Source GNU GPL v2.0 license.\n",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 14,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Text(
                  "What is the Regular Labs Library?",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Text(
                    "All free and paid Regular Labs extensions are released \nunder the Open Source GNU GPL v3.0 license.\n",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 14,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
