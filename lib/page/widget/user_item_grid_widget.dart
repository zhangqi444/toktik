import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toktik/util/string_util.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UserItemGridWidget extends StatefulWidget {
  String? url;
  Function? onTap;
  UserItemGridWidget({String? url,Function? onTap}){
    this.url = url;
    this.onTap = onTap;
  }
  @override
  _UserItemGridWidgetState createState() {
    return _UserItemGridWidgetState();
  }
}



class _UserItemGridWidgetState extends State<UserItemGridWidget> {

  Image? thumbnailImage;
  final Completer<Map<String, dynamic>> completer = Completer();

  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<Map<String, dynamic>> _loadThumbnail() async {
    String? thumbnailFileName = await VideoThumbnail.thumbnailFile(
      video: widget.url!,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 190, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 100,
    );

    if(isStringNullOrEmpty(thumbnailFileName)) return {};

    final file = File(thumbnailFileName!);
    final bytes = file.readAsBytesSync();
    int imageDataSize = bytes.length;
    final image = Image.memory(bytes, fit: BoxFit.cover);
    image.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
          completer.complete({
            "image": image,
            "dataSize": imageDataSize,
            "height": info.image.height,
            "width": info.image.width,
          });
      }));
      return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    if(isStringNullOrEmpty(widget.url)) return Container();

    return InkWell(
      onTap: (){
        widget.onTap?.call();
      },
      child: Stack(
          children: [
            FutureBuilder<void>(
              future: _loadThumbnail(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final _image = snapshot.data["image"];
                  final _width = snapshot.data["width"];
                  final _height = snapshot.data["height"];
                  final _dataSize = snapshot.data["dataSize"];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _image,
                    ],
                  );
                }
                return Container();
              }
            ),
            Positioned(
              right: 8,
              bottom: 14,
              child: Row(
                children: [
                  Image.asset('assets/images/hollow_heart.webp',width: 15,height: 15,),
                  Text(' ${Random().nextInt(600)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
          ],
      ),
    );
  }
}