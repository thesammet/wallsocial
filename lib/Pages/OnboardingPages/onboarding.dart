import 'package:flutter/material.dart';
import 'package:wallSocial/DefaultWidgets/defaultButton.dart';

class OnboardingPage extends StatefulWidget {
  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.black,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: new Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width / 5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/blackback.png"),
                  ),
                  borderRadius: BorderRadius.circular(19.00),
                ),
              ),
            ),
            new Text(
              "HD wallpaper",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Proxima Nova",
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Color(0xffffffff),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: new Text(
                "Discover the best menus from over 100 cuisines and over 1000 restaurants.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Proxima Nova",
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            new Container(
              height: 8.00,
              width: 8.00,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(13.00),
              ),
            ),
            GestureDetector(
                onTap: () {
                  print("next scene giecek.");
                },
                child: DefaultButton(text: "Next")),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: new Text(
                "Skip",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Proxima Nova",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
