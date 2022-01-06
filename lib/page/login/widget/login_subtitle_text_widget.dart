import 'package:flutter/material.dart';

class LoginSubtitleTextWidget extends StatefulWidget {
  String text;
  LoginSubtitleTextWidget({this.text});

  @override
  _LoginSubtitleTextWidgetState createState() {
    return _LoginSubtitleTextWidgetState();
  }
}

class _LoginSubtitleTextWidgetState extends State<LoginSubtitleTextWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Text(
        widget.text,
        style: TextStyle(color: Color(0xff888888), fontSize: 12),
        maxLines: 2,
      ),
    );
  }
}