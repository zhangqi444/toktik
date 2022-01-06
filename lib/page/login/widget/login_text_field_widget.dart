import 'package:flutter/material.dart';
import 'package:toktik/res/colors.dart';

class LoginTextFieldWidget extends StatefulWidget {
  String text;
  String initText;
  Function onChanged;
  String hintText;
  bool obscureText;
  LoginTextFieldWidget({this.text, this.initText, this.onChanged, this.hintText, this.obscureText = false});

  @override
  _LoginTextFieldWidgetState createState() {
    return _LoginTextFieldWidgetState();
  }
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
          Border(bottom: BorderSide(width: 0.3, color: Color(0xff2A2A2A)))),
      child: TextField(
        cursorColor: ColorRes.color_1,
        cursorWidth: 2,
        obscureText: widget.obscureText,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: widget.hintText),
        onChanged: (text) { widget.onChanged(text); },
      ),
    );
  }
}