import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toktik/res/colors.dart';

class FeedDraftWidget extends StatefulWidget {
  final Function onNext;
  final String? podcastName;
  final String? podcastArtistName;
  final int? podcastLengthMillis;
  final String? podcastDescription;
  final String? podcastReleaseDate;
  final String? podcastThumbnail;

  FeedDraftWidget({
    required this.onNext,
    this.podcastName,
    this.podcastArtistName,
    this.podcastLengthMillis,
    this.podcastDescription,
    this.podcastReleaseDate,
    this.podcastThumbnail,
  });

  @override
  _FeedDraftWidgetState createState() {
    return _FeedDraftWidgetState();
  }
}

class _FeedDraftWidgetState extends State<FeedDraftWidget> {
  TextEditingController timeTextEditingController =
      TextEditingController(text: "00:00:00");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _topLayout(context),
        _bottomLayout(context),
      ],
    );
  }

  Widget _topLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Episode added to your draft",
            style: TextStyle(
                fontSize: 16,
                color: ColorRes.light_foreground_color,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 27,
          ),
          Row(
            children: [
              Image.network(
                widget.podcastThumbnail ?? "",
                width: 45,
                height: 45,
                fit: BoxFit.contain,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.podcastName ?? "",
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorRes.light_foreground_color,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.podcastArtistName ?? "",
                    style: TextStyle(fontSize: 16, color: Color(0xff888888)),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
                color: Color(0xfff8f8f8),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.podcastDescription ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(_formatUTCDate(widget.podcastReleaseDate),
                        style:
                            TextStyle(fontSize: 10, color: Color(0xff888888))),
                  ],
                )),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 5, 4),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f4f4),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 4,
                          offset: Offset(0, 0)),
                    ],
                  ),
                  child: Text(
                    "${this._convertMillisToMinutes(widget.podcastLengthMillis ?? 0).toString()} min",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 44,
          ),
          Text(
            "Where were you when you shared the above episode?",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorRes.light_foreground_color),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
            width: 108,
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: timeTextEditingController,
              decoration: InputDecoration.collapsed(hintText: "00:00:00"),
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              // inputFormatters: [FilteringTextInputFormatter.allow(r'[0-9]')],
            ),
          ),
        ],
      ),
    );
  }

  _bottomLayout(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 18, 15, 18),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12))),
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Text(
            "Next",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            int inputTimeSeconds =
                _convertInputTimeToSeconds(timeTextEditingController.text);
            int startTimeSeconds = max(inputTimeSeconds - 180, 0);
            int lengthSeconds = min(startTimeSeconds + 180, inputTimeSeconds);
            widget.onNext(startTimeSeconds, lengthSeconds);
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff39CBE3),
          ),
        ),
      ),
    );
  }

  int _convertMillisToMinutes(int millis) => millis ~/ 1000 ~/ 60;

  String _formatUTCDate(String? isoDate) {
    if (isoDate == null) return "";
    DateTime date = DateTime.parse(isoDate);
    return date.toString();
  }

  int _convertInputTimeToSeconds(String text) {
    List<int> timeSegments = text.split(":").map((s) => int.parse(s)).toList();
    if (timeSegments[1] >= 60 || timeSegments[2] >= 60) {
      throw ArgumentError.value("Invalid time value");
    }
    return timeSegments[0] * 3600 + timeSegments[1] * 60 + timeSegments[2];
  }
}
