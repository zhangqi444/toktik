import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  String title;
  List<Widget>? actions;
  AppBarWidget({Key? key, this.title = "", this.actions})
      : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  _AppBarWidgetState createState() {
    return _AppBarWidgetState();
  }

  @override
  final Size preferredSize;
}

class _AppBarWidgetState extends State<AppBarWidget> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Text(widget.title, style: TextStyle(color: Color(0xff2A2A2A), fontSize: 16, fontWeight: FontWeight.bold)),
      elevation: 0,
      centerTitle: true,
      actions: widget.actions != null ? widget.actions : <Widget>[],
      leading: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Image.asset('assets/images/login/nav-arrow-left.png',
            color: Color(0xff2A2A2A), width: 24, height: 24),
      ),
    );
  }
}