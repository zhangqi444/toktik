import 'package:flutter/material.dart';
import 'package:toktik/res/colors.dart';

class FeedPostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 17, 16, 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Name your clip",
                  hintStyle: TextStyle(color: Color(0xff888888))),
              style: TextStyle(fontSize: 15),
              maxLines: 3,
            ),
            Container(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                width: 256,
                height: 343,
                child: Text("video template goes here"),
                alignment: Alignment.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Share to:",
                  style: TextStyle(fontSize: 15, color: Color(0xff888888)),
                ),
                Row(
                  children: [
                    _getSocialButton('twitter'),
                    SizedBox(
                      width: 17,
                    ),
                    _getSocialButton('facebook'),
                    SizedBox(
                      width: 17,
                    ),
                    _getSocialButton('instagram'),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      child: Text(
                        "Copy link",
                        style: TextStyle(
                            color: ColorRes.light_foreground_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        // this.onNext();
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Color(0xFFDEDEDE), width: 1)),
                        backgroundColor: Colors.white,
                      ),
                    )),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                        child: TextButton(
                      child: Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        // this.onNext();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff39CBE3),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'Choose another video template',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF888888), fontSize: 13),
                )
              ],
            )
          ]),
    );
  }

  Widget _getSocialButton(String socialName) {
    return SizedBox(
      width: 42,
      height: 42,
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0),
                    side: BorderSide(color: Color(0xFFDDDDDD))))),
        onPressed: () {},
        child: Image.asset('assets/images/feed_publish/ic-$socialName.png',
            color: Color(0xFFB3B3B3), width: 32, height: 32),
      ),
    );
  }
}
