import 'package:flutter/material.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/util/constants.dart';
import 'package:marquee/marquee.dart';

class VideoBottomBarWidget extends StatefulWidget {
  FeedListList video;
  VideoBottomBarWidget({this.video});


  @override
  _VideoBottomBarWidgetState createState() {
    return _VideoBottomBarWidgetState();
  }
}

class _VideoBottomBarWidgetState extends State<VideoBottomBarWidget> {

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width - kVinylDiskContainerWidth;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('@${widget.video.user.username}',style: _getTextStyle(),),
          SizedBox(height: 8,),
          Text('${widget.video.content.text}',style: _getTextStyle(),),
          SizedBox(height: 10,),
          Row(
            children: [
              // TODO: remove the tiktok icon for now
              // Image.asset('assets/images/tiktok_white.webp',width: 25,height: 25,),
              Container(
                width: 200,
                height: 25,
                child: Marquee(
                  text: 'original sound - ${widget.video.user.username}  ',
                  style: TextStyle(fontSize: 15,color: Colors.white),),
              )
            ],
          ),

        ],
      ),

    );
  }

  _getTextStyle(){
    return TextStyle(
        color: Colors.white,
    );
  }
}