import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/services.dart';

const _channel = MethodChannel('com.amazonaws.amplify/predictions');

class AmplifyPredictionsMethodChannel {
  Future<void> addPlugin() async {
    try {
      await _channel.invokeMethod<bool>('addPlugin');
    } on PlatformException catch (e) {
      if (e.code == "AmplifyAlreadyConfiguredException") {
        throw AmplifyAlreadyConfiguredException(
            AmplifyExceptionMessages.alreadyConfiguredDefaultMessage,
            recoverySuggestion:
                AmplifyExceptionMessages.alreadyConfiguredDefaultSuggestion);
      } else {
        throw AmplifyException.fromMap(Map<String, String>.from(e.details));
      }
    } catch (e) {
      print('hmm $e');
    }
  }
}
