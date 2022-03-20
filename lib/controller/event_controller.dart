import 'package:get/get.dart';
import 'package:toktik/net/api.dart';

class EventController extends GetxController {
  void recordEvent(String eventName, Map<String, dynamic> events) {
    Api.recordEvent(eventName, events);
  }
}
