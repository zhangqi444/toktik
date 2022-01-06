import 'package:flutter/material.dart';

class LoginTitleTextWidget extends StatefulWidget {
  String text;
  LoginTitleTextWidget({this.text});

  @override
  _LoginTitleTextWidgetState createState() {
    return _LoginTitleTextWidgetState();
  }
}

class _LoginTitleTextWidgetState extends State<LoginTitleTextWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Text(
        widget.text,
        style: TextStyle(color: Color(0xff2A2A2A), fontSize: 19, fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }
}