import 'package:package_info_plus/package_info_plus.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  PackageInfo? platformInfo;

  Future<void> load() async {
    platformInfo = await PackageInfo.fromPlatform();
  }
}
