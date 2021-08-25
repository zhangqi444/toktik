import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/data/video.dart';
import 'package:toktik/page/home_tab_recommend_page.dart';
import 'package:toktik/screens/feed_viewmodel.dart';
import 'package:toktik/page/message_page.dart';
import 'package:toktik/screens/profile_screen.dart';
import 'package:toktik/screens/search_screen.dart';
import 'package:toktik/widgets/actions_toolbar.dart';
import 'package:toktik/widgets/bottom_bar.dart';
import 'package:toktik/widgets/video_description.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// Generated in previous step
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class FeedScreen extends StatefulWidget {
  PageController _scrollPageController;

  FeedScreen({Key key, PageController pageController}){
    this._scrollPageController = pageController;
  }

  @override
  _FeedScreenState createState() => _FeedScreenState(_scrollPageController);
}

class _FeedScreenState extends State<FeedScreen> {
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();
  final MainPageScrollController mainPageScrollController = Get.put(MainPageScrollController());
  PageController _scrollPageController;

  _FeedScreenState(PageController _scrollPageController);

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {

    final AmplifyDataStore _dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
    final AmplifyAPI _apiPlugin = AmplifyAPI();
    final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();

    await Amplify.addPlugins([
      _dataStorePlugin,
      _apiPlugin,
      _authPlugin
    ]);

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
    try {
      mainPageScrollController.setAmplifyConfigured(true);
      Amplify.DataStore.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        disposeViewModel: false,
        builder: (context, model, child) => videoScreen(),
        viewModelBuilder: () => feedViewModel);
  }

  Widget videoScreen() {
    return Scaffold(
      backgroundColor: feedViewModel.actualScreen == 0
          ? Colors.black
          : Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            itemCount: 2,
            onPageChanged: (value) {
              print(value);
              if (value == 1)
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
              else
                SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light);
            },
            itemBuilder: (context, index) {
              if (index == 0)
                return scrollFeed();
              else
                return profileView();
            },
          )
        ],
      ),
    );
  }

  Widget profileView() {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Container(
              color: Colors.white,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Text(
                        "Charlotte Stone",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg",
                            height: 100.0,
                            width: 100.0,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "@Charlotte21",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "232",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Following",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        Column(
                          children: [
                            Text(
                              "1.3k",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Followers",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1,
                          height: 15,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        Column(
                          children: [
                            Text(
                              "12k",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Likes",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 47,
                          decoration: BoxDecoration(
                            color: Colors.pink[500],
                          ),
                          child: Center(
                            child: Text(
                              "Follow",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 45,
                          height: 47,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Center(child: Icon(Icons.camera_alt)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 35,
                          height: 47,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Center(child: Icon(Icons.arrow_drop_down)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.menu),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                color: Colors.black,
                                height: 2,
                                width: 55,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.black26,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                color: Colors.transparent,
                                height: 2,
                                width: 55,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/tOueglJrk5rS8/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/665IPY24jyWFa/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/chjX2ypYJKkr6/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/sC60eX0OVIH7O/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/NsXhybxnMKsh2/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(
                                    color: Colors.white70, width: .5)),
                            child: FittedBox(
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "https://media.giphy.com/media/HE6hyf47yAX1S/giphy.gif",
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(35.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]))),
    );
  }

  Widget scrollFeed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: currentScreen()),
        BottomBar(),
      ],
    );
  }

  Widget feedVideos() {
    double contentHeight = MediaQuery.of(context).size.height - 48 - MediaQueryData.fromWindow(window).padding.top;

    return Obx(() =>
      mainPageScrollController.amplifyConfigured.value
        ? HomeTabRecommendPage(
            contentHeight: contentHeight,
            pageController: _scrollPageController
        )
        : Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
    );
  }

  Widget currentScreen() {
    switch (feedViewModel.actualScreen) {
      case 0:
        return feedVideos();
      case 1:
        return SearchScreen();
      case 2:
        return MessagePage();
      case 3:
        return ProfileScreen();
      default:
        return feedVideos();
    }
  }

  Widget videoCard(Video video) {

    return Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                onTap: () {
                  if (video.controller.value.isPlaying) {
                    video.controller?.pause();
                  } else {
                    video.controller?.play();
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: video.controller?.value.size.width ?? 0,
                    height: video.controller?.value.size.height ?? 0,
                    child: VideoPlayer(video.controller),
                  ),
                )),
              )
            : Container(
                color: Colors.black,
                child: Center(
                  child: Text("Loading"),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                VideoDescription(video.user, video.videoTitle, video.songName),
                ActionsToolbar(video.likes, video.comments,
                    "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    feedViewModel.controller?.dispose();
    super.dispose();
  }
}
