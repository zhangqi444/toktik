import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:flutter/material.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/user_page_controller.dart';
import 'package:toktik/event/amplify_configured_event.dart';
import 'package:toktik/event/close_main_drawer_event.dart';
import 'package:toktik/page/main_page.dart';
import 'package:toktik/page/user_page.dart';
import 'package:toktik/page/widget/user_right_menu_widget.dart';
import 'package:get/get.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
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
  final MainPageScrollController mainPageScrollController = Get.put(MainPageScrollController());
  UserPageController _userPageController = Get.put(UserPageController());
  PageController _pageController = PageController(initialPage: 0, keepPage: true);
  GlobalKey<DrawerControllerState> drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Application.eventBus.on<CloseMainDrawerEvent>().listen((event) {
      drawerKey.currentState.close();
    });
    if(!Amplify.isConfigured) {
      _configureAmplify();
    }
  }

  void _configureAmplify() async {

    final AmplifyDataStore _dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
    final AmplifyAPI _apiPlugin = AmplifyAPI();
    final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
    final AmplifyAnalyticsPinpoint _analyticsPlugin = AmplifyAnalyticsPinpoint();

    await Amplify.addPlugins([
      _dataStorePlugin,
      _apiPlugin,
      _authPlugin,
      _analyticsPlugin
    ]);

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
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
        Obx(() => PageView(
          controller: _pageController,
          physics: mainPageScrollController.scrollPageViewScrollPage.value ? new ClampingScrollPhysics() : new NeverScrollableScrollPhysics(),
          children: [
            MainPage(pageController:_pageController),
            Scaffold(
                backgroundColor: Colors.white,
                body: UserPage(pageController: _pageController, isLoginUser: false, id: mainPageScrollController.userIdCurrent.value)
            )
          ],
          onPageChanged: (index){
          },
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
