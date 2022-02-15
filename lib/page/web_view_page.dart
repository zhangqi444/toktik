import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktik/page/widget/app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../enum/navigation_argument.dart';

class WebViewPage extends StatefulWidget {
  final url;
  WebViewPage({this.url});
  @override
  createState() => _WebViewPageState(this.url);
}

class _WebViewPageState extends State<WebViewPage> {
  var _url;
  final _key = UniqueKey();
  dynamic argumentData = Get.arguments;

  _WebViewPageState(this._url);

  @override
  void initState() {
    super.initState();
    if(argumentData != null) {
      _url = argumentData[NavigationArgument.URL];
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