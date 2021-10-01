import 'dart:ui';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      body: _buildBreeze(),
    );
  }
}

Widget _buildBreeze() {
  return Container(
    margin: const EdgeInsets.only(top: 227.0),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Container(
              width: 163.0,
              height: 163.0,
              child: Image.asset("assets/images/splash/breeze_logo.png"),
            ))
          ],
        ),
        Image.asset("assets/images/splash/breeze_text.png")
      ],
    ),
  );
}
