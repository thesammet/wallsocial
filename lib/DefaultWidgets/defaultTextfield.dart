import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';

class DefaultTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final String topicText;
  //final String validatorText;
  //final bool statement;

  const DefaultTextfield({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.textInputType,
    @required this.topicText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      initialValue: null,
      controller: controller,
      decoration: new InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: topicText,
        hintText: hintText,
        labelStyle: TextStyle(
          fontFamily: 'Proxima Nova',
          fontSize: 14,
          color: const Color(0xffffffff),
        ),
        hintStyle: TextStyle(
          fontFamily: 'Gotham',
          fontSize: 17,
          color: const Color(0xffCBC9C9),
          fontWeight: FontWeight.w300,
        ),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(9.0),
        ),
      ),
      style: TextStyle(
        fontFamily: 'Gotham',
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class EditorSubTitleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  //final String validatorText;
  //final bool statement;

  const EditorSubTitleTextField({
    Key key,
    @required this.controller,
    @required this.hintText,
    @required this.textInputType,
    // @required this.validatorText,
    //@required this.statement
  }) : super(key: key);

  final maxLines = 5;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285.0,
      height: maxLines * 24.0,
      decoration: BoxDecoration(
        color: const Color(0xff707070),
        borderRadius: new BorderRadius.circular(9.0),
      ),
      child: TextFormField(
        maxLines: maxLines,
        cursorColor: Colors.white,
        controller: controller,
        decoration: new InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xff707070),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xff707070),
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xff707070),
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Gotham',
            fontSize: 17,
            color: const Color(0xffCBC9C9),
            fontWeight: FontWeight.w300,
          ),
        ),
        keyboardType: textInputType,
        style: TextStyle(
          fontFamily: 'Gotham',
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
