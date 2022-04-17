import 'package:flutter/material.dart';

class LoginErrorMessageWidget extends StatefulWidget {
  String? text;
  LoginErrorMessageWidget({this.text});

  @override
  _LoginErrorMessageWidgetState createState() {
    return _LoginErrorMessageWidgetState();
  }
}

class _LoginErrorMessageWidgetState extends State<LoginErrorMessageWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            height: 40,
            child: Text(
              widget.text!,
              softWrap: true,
              style: TextStyle(
                  color: Color(0xffff0000),
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              maxLines: 2,
            ),
          ),
          SizedBox(height: 10),
        ]
    );
  }
}