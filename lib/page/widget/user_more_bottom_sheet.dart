import 'package:flutter/material.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/model/user_model.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class UserMoreBottomSheet extends StatefulWidget {
  var user;
  Function onNotInterested = () => {};
  Function onReport = () => {};
  UserMoreBottomSheet({Key? key, this.user, required this.onNotInterested, required this.onReport}) : super(key: key);

  @override
  _UserMoreBottomSheetState createState() {
    return _UserMoreBottomSheetState();
  }
}

class _UserMoreBottomSheetState extends State<UserMoreBottomSheet> {
  MainPageScrollController _mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text(widget.user.username!,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 2,),
          Text('ID: '+widget.user.id!, style: TextStyle(fontSize: 11, color: Colors.grey)),
          SizedBox(height: 20,),
          // _renderItem('分享'),
          // _renderItem('发私信'),
          // _renderItem('不让TA看'),
          _renderItem('Report', () { widget.onReport(); }),
          _renderItem('Block', () { widget.onNotInterested(); }),
          Container(height: 8, color: Colors.grey.withAlpha(100)),
          InkWell(
            onTap: () { Get.back(); },
            child: _renderTextBox('Cancel')
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _renderTextBox(text) {
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Text(text, style: TextStyle(fontSize: 14, color: Colors.black))
    );
  }

  _renderItem(text, onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(color: Colors.grey.withAlpha(100), height: 0.05,),
          _renderTextBox(text)
        ]
      )
    );
  }
}