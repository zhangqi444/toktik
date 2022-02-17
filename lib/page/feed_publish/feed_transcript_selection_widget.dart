import 'package:flutter/material.dart';
import 'package:toktik/res/colors.dart';

class FeedTranscriptSelectionWidget extends StatelessWidget {
  final Function onNext;

  FeedTranscriptSelectionWidget({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _topLayout(context),
        _bottomLayout(context),
      ],
    );
  }

  Widget _topLayout(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Transcript goes here",
                style: TextStyle(
                    fontSize: 16,
                    color: ColorRes.light_foreground_color,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }

  _bottomLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 18, 15, 18),
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "1:15min selected (2min max)",
            textAlign: TextAlign.center,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(
                "Complete",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                this.onNext();
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff39CBE3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
