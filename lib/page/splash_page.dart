import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/router_manager.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  Timer _timer;
  int count = 3;

  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    new Timer(_duration, () {
      // 空等1秒之后再计时
      _timer = new Timer.periodic(const Duration(milliseconds: 1000), (v) {
        count--;
        if (count == 0) {
          navigationPage();
        } else {
          setState(() {});
        }
      });
      return _timer;
    });
  }

  void navigationPage() {
    _timer.cancel();
    Get.toNamed('/scroll');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }


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
