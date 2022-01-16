import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktik/page/widget/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final url;
  WebViewWidget({this.url});
  @override
  createState() => _WebViewWidgetState(this.url);
}

class _WebViewWidgetState extends State<WebViewWidget> {
  var _url;
  final _key = UniqueKey();
  dynamic argumentData = Get.arguments;

  _WebViewWidgetState(this._url);

  @override
  void initState() {
    super.initState();
    if(argumentData != null) {
      _url = argumentData['url'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}