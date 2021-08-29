import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
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
                  "Terms & Conditions",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren.",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 16,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Text(
                  "Terms 1.0.1",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xffffffff),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: new Text(
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam",
                    style: TextStyle(
                      fontFamily: "Proxima Nova",
                      fontSize: 16,
                      color: Color(0xffffffff),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
