import 'package:get/get.dart';
import 'package:toktik/common/events.dart';
import 'package:toktik/net/api.dart';

import 'self_controller.dart';

class EventController extends GetxController {

  final SelfController _selfController = Get.put(SelfController());

  void recordEvent(String eventName, {Map<String, dynamic>? event}) {
    if(event == null) {
      event = {};
    }

    if(_selfController.loginUserId.value != "") {
      event[EventKey.SELF_USER_ID] = _selfController.loginUserId.value;
    }

    Api.recordEvent(eventName, event: event);
  }
}
