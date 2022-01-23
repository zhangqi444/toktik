import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toktik/common/application.dart';
import '../common/router_manager.dart';

import 'package:toktik/event/amplify_configured_event.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';

// Generated in previous step
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();

    if(!Amplify.isConfigured) {
      _configureAmplify();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (v) {
      if(Amplify.isConfigured) {
        navigationPage();
      }
    });
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

  void navigationPage() {
    _timer.cancel();
    Get.offAndToNamed(Routers.scroll);
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      body: _buildBreeze(),
    );
  }
}

Widget _buildBreeze() {
  return Container(
    margin: const EdgeInsets.only(top: 227.0),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Container(
              width: 163.0,
              height: 163.0,
              child: Image.asset("assets/images/splash/breeze_logo.png"),
            ))
          ],
        ),
        Image.asset("assets/images/splash/breeze_text.png")
      ],
    ),
  );
}
