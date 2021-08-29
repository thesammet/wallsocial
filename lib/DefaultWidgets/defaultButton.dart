import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;

  const DefaultButton({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: Colors.white,
      ),
      width: 285.0,
      height: 50.0,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Proxima Nova',
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
