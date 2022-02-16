import 'package:toktik/plugins/amplify-flutter-predictions/method_channel_amplify_predictions.dart';

//  * will need to add these line into amplifyconfiguration.dart to make it work
//  * "predictions": {
//         "plugins": {
//             "awsPredictionsPlugin": {
//                 "defaultRegion": "us-west-2",
//                 "convert": {
//                     "transcription": {
//                         "language": "en-US",
//                         "region": "us-west-2",
//                         "defaultNetworkPolicy": "auto"
//                     }
//                 }
//             }
//         }
//     }
class AmplifyPredictions {
  static AmplifyPredictions instance = AmplifyPredictions();
  var _channel = AmplifyPredictionsMethodChannel();

  Future<void> addPlugin() {
    return _channel.addPlugin();
  }

  Future<String> convertSpeechToText() {
    return _channel.convertSpeechToText();
  }
}
