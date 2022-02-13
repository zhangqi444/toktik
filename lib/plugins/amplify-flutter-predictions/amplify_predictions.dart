import 'package:toktik/plugins/amplify-flutter-predictions/method_channel_amplify_predictions.dart';

class AmplifyPredictions {
  static AmplifyPredictions instance = AmplifyPredictions();
  var _channel = AmplifyPredictionsMethodChannel();

  Future<void> addPlugin() {
    return _channel.addPlugin();
  }
}
