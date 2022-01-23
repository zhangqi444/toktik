import 'package:flutter/material.dart';

class LoginPrimaryButtonWidget extends StatefulWidget {
  String? text;
  Function? onPressed;
  bool? buttonEnabled;
  LoginPrimaryButtonWidget({this.text, this.onPressed, this.buttonEnabled});

  @override
  _LoginPrimaryButtonWidgetState createState() {
    return _LoginPrimaryButtonWidgetState();
  }
}

class _LoginPrimaryButtonWidgetState extends State<LoginPrimaryButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: !widget.buttonEnabled! ? () {} : () async {
          await widget.onPressed!();
        },
        child: Text(
          widget.text ?? 'Next',
          style: widget.buttonEnabled!
              ? TextStyle(color: Color(0xffFFFFFF), fontSize: 14)
              : TextStyle(color: Color(0xffAAAAAA), fontSize: 14),
        ),
        color: widget.buttonEnabled! ? Color(0xff39CBE3) : Color(0xffEEEEEE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}