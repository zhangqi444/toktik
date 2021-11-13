import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'common/router_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.rightToLeft,
    getPages: RouterManager.routes,
    // TODO: switch to splash page whenever we have the requirement
    initialRoute: Routers.scroll,
    builder: EasyLoading.init(),
  ));
}
