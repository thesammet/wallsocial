import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
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
                  "About Us",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Align(
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
                new Text(
                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontSize: 16,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Text(
                    "Reach Us",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 14,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Text(
                  "Ankara Turkey\n\ninfo@socialwall.com\n\nwww.socialwall.com",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: new Container(
                    height: 162.00,
                    width: 343.00,
                    decoration: BoxDecoration(
                      color: Color(0xffffc300).withOpacity(0.16),
                      border: Border.all(
                        width: 1.00,
                        color: Color(0xff707070).withOpacity(0.16),
                      ),
                      borderRadius: BorderRadius.circular(6.00),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://maps.zomato.com/php/staticmap?center=39.9281055556,32.8546194444&size=600x400&maptype=zomato&markers=39.9281055556,32.8546194444,pin_res32&sensor=false&scale=2&zoom=14&language=en",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Container(
                        width: 140,
                        height: 50,
                        child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
