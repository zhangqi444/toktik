import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:toktik/controller/app_controller.dart';
import 'package:toktik/controller/event_controller.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/navigation_argument.dart';
import 'package:toktik/util/receive_sharing_intent.dart';

import 'common/router_manager.dart';
import 'transition/custom_transition.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentDataStreamSubscription;

  AppController _appController = Get.put(AppController());
  MainPageScrollController _mainPageScrollController = Get.put(MainPageScrollController());
  SelfController _selfController = Get.put(SelfController());
  EventController _eventController = Get.put(EventController());

  @override
  void initState() {
    super.initState();

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      handleSharedPodcastUrl(value);
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      if (value != null) {
        handleSharedPodcastUrl(value);
      }
    });
  }

  Future<void> init() async {
    await _appController.load();
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  void handleSharedPodcastUrl(String url) {
    Get.toNamed(Routers.feedPublish,
        arguments: {NavigationArgument.PODCAST_URL: url});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // defaultTransition: Transition
          //     .rightToLeft, // https://github.com/jonataslaw/getx/issues/317
          customTransition: SlideLeftTransitions(),
          getPages: RouterManager.routes,
          // TODO: switch to splash page whenever we have the requirement
          initialRoute: Routers.scroll,
          builder: EasyLoading.init(),
        );
      },
    );
    
  }
}
