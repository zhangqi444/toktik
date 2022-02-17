import 'package:flutter/material.dart';
import 'package:toktik/res/colors.dart';

class FeedDraftWidget extends StatefulWidget {
  final Function onNext;
  final String? podcastName;
  final String? podcastArtistName;
  final int? podcastLengthMillis;
  final String? podcastDescription;
  final String? podcastReleaseDate;

  FeedDraftWidget({
    required this.onNext,
    this.podcastName,
    this.podcastArtistName,
    this.podcastLengthMillis,
    this.podcastDescription,
    this.podcastReleaseDate,
  });

  @override
  _FeedDraftWidgetState createState() {
    return _FeedDraftWidgetState();
  }
}

class _FeedDraftWidgetState extends State<FeedDraftWidget> {
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
                "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg",
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
            padding: EdgeInsets.fromLTRB(23, 14, 23, 14),
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "00:00:00",
              style: TextStyle(fontSize: 16),
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
            widget.onNext();
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff39CBE3),
          ),
        ),
      ),
      // child: InkWell(
      //   onTap: () async {
      //     VideoPlayerValue videoValue =
      //         await VideoUtil.getVideoValue(videoFile);

      //     print(
      //         '发布视频时长:${videoValue.duration.inSeconds}  width:${videoValue.size.width}  height:${videoValue.size.height}');
      //     bool? videoUpload =
      //         await _uploadController.uploadSingleFile('mp4', videoFile);
      //     String? videoUrl =
      //         _uploadController.uploadResponse.tokens![0]!.effectUrl;
      //     print('发布视频：$videoUpload 地址:$videoUrl');
      //     bool? imgUpload = await _uploadController.uploadSingleFile(
      //         CameraUtil.getImgSuffix(coverPath!), File(coverPath!));
      //     String? coverUrl =
      //         _uploadController.uploadResponse.tokens![0]!.effectUrl;
      //     print('发布封面图：$imgUpload 地址:$coverUrl');
      //     _feedController.publishFeed(
      //         _editingController.text,
      //         videoUrl,
      //         coverUrl,
      //         videoValue.duration.inSeconds.toInt(),
      //         videoValue.size.width.toInt(),
      //         videoValue.size.height.toInt());
      //   },
      //   child: Container(
      //     height: 60,
      //     decoration: BoxDecoration(
      //         color: ColorRes.color_3,
      //         borderRadius: BorderRadius.circular(5)),
      //     alignment: Alignment.center,
      //     child: Text(
      //       '发布',
      //       style: TextStyle(color: Colors.white, fontSize: 18),
      //     ),
      //   ),
      // )
    );
  }

  int _convertMillisToMinutes(int millis) => millis ~/ 1000 ~/ 60;

  String _formatUTCDate(String? isoDate) {
    if (isoDate == null) return "";
    DateTime date = DateTime.parse(isoDate);
    return date.toString();
  }
}
