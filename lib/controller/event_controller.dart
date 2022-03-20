import 'package:get/get.dart';
import 'package:toktik/net/api.dart';

class EventController extends GetxController {
  void recordEvent(String eventName, {Map<String, dynamic>? event}) {
    Api.recordEvent(eventName, event: event);
  }
}
