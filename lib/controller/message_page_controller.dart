import 'package:toktik/model/message_model.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class MessagePageController extends GetxController{
  List<MessageModel> list = [];

  MessagePageController(){
    list.addAll(messageList);
  }
}