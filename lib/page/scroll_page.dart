import 'package:flutter/material.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/user_page_controller.dart';
import 'package:toktik/event/close_main_drawer_event.dart';
import 'package:toktik/page/main_page.dart';
import 'package:toktik/page/user_page.dart';
import 'package:toktik/page/widget/user_right_menu_widget.dart';
import 'package:get/get.dart';

import 'package:toktik/event/amplify_configured_event.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:toktik/plugins/amplify-flutter-predictions/amplify_predictions.dart';

// Generated in previous step
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

///负责MainPage与UserPage页的滑动
class ScrollPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollPageState();
  }
}

class _ScrollPageState extends State<ScrollPage> {
  final MainPageScrollController mainPageScrollController =
      Get.put(MainPageScrollController());
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  GlobalKey<DrawerControllerState> drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    Application.eventBus.on<CloseMainDrawerEvent>().listen((event) {
      drawerKey.currentState!.close();
    });
  }

  Future<void> _configureAmplify() async {
    if (Amplify.isConfigured) return;

    final AmplifyDataStore _dataStorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    final AmplifyAPI _apiPlugin = AmplifyAPI();
    final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
    final AmplifyAnalyticsPinpoint _analyticsPlugin =
        AmplifyAnalyticsPinpoint();

    await Future.wait([
      Amplify.addPlugins(
          [_dataStorePlugin, _apiPlugin, _authPlugin, _analyticsPlugin]),
      AmplifyPredictions.instance.addPlugin()
    ]);

    // Once Plugins are added, configure Amplify
    try {
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print(e);
    }
    try {
      Amplify.DataStore.clear();
      Application.eventBus.fire(AmplifyConfiguredEvent());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => PageView(
            controller: _pageController,
            physics: mainPageScrollController.scrollPageViewScrollPage.value
                ? new ClampingScrollPhysics()
                : new NeverScrollableScrollPhysics(),
            children: [
              FutureBuilder<void>(
                future: _configureAmplify(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  return MainPage(pageController: _pageController);
                },
              )
              // TODO: disable left swipe to show user page
              // Scaffold(
              //     backgroundColor: Colors.white,
              //     body: UserPage(pageController: _pageController, isLoginUser: false, id: mainPageScrollController.userIdCurrent.value)
              // )
            ],
            onPageChanged: (index) {},
          ),
        ),
        // TODO: remove drawer function for now.
        // Obx(()=>DrawerController(
        //     key: drawerKey,
        //     alignment: DrawerAlignment.end,
        //     isDrawerOpen: _userPageController.showRightMenu.value,
        //     drawerCallback: (isOpened){
        //       _userPageController.toggleRightMenu();
        //     },
        //     child: UserRightMenuWidget()
        // ),
        // ),
      ],
    );
  }
}
