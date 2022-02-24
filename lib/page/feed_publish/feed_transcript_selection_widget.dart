import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toktik/res/colors.dart';

class FeedTranscriptSelectionWidget extends StatefulWidget {
  final Function onNext;
  final String subtitleFileUri;

  FeedTranscriptSelectionWidget(
      {required this.onNext, required this.subtitleFileUri});

  @override
  _FeedTranscriptSelectionWidgetState createState() {
    // TODO: implement createState
    return _FeedTranscriptSelectionWidgetState();
  }
}

class _FeedTranscriptSelectionWidgetState
    extends State<FeedTranscriptSelectionWidget> {
  String? subtitle;
  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.get<String>(widget.subtitleFileUri).then((response) {
      setState(() {
        subtitle = response.data;
      });
    }).catchError((error) {});
  }

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
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              subtitle ?? "",
              style: TextStyle(
                  fontSize: 16,
                  color: ColorRes.light_foreground_color,
                  fontWeight: FontWeight.w500),
            ),
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
                widget.onNext();
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
