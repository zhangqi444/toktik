import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Function? backCallback;
  LoginAppBarWidget({Key? key, this.title, this.backCallback}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  _LoginAppBarWidgetState createState() {
    return _LoginAppBarWidgetState();
  }

  @override
  final Size preferredSize;
}

class _LoginAppBarWidgetState extends State<LoginAppBarWidget> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Text(widget.title!, style: TextStyle(color: Color(0xff2A2A2A), fontSize: 16, fontWeight: FontWeight.bold)),
      elevation: 0,
      centerTitle: true,
      // todo: disable action button for login/signup pages.
      // actions: <Widget>[
      //   new IconButton(
      //     icon: Image.asset('assets/images/login/question.png',
      //         color: Color(0xff888888), width: 22, height: 22),
      //     onPressed: () {},
      //   )
      // ],
      leading: TextButton(
        onPressed: () {
          Get.back();
          if(widget.backCallback != null) {
            widget.backCallback!();
          }
        },
        child: Image.asset('assets/images/login/nav-arrow-left.png',
            color: Color(0xff2A2A2A), width: 24, height: 24),
      ),
    );
  }
}