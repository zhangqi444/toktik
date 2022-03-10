import 'package:flutter/services.dart';
import 'package:toktik/common/configs.dart';

class ReceiveSharingIntent {
  static const _mChannel =
      const MethodChannel(RECEIVE_SHARING_INTENT_METHOD_CHANNEL);
  static const _eChannel =
      const EventChannel(RECEIVE_SHARING_INTENT_EVENT_CHANNEL);

  static Stream<String>? _streamLink;

  /// Returns a [Future], which completes to one of the following:
  ///
  ///   * the initially stored link (possibly null), on successful invocation;
  ///   * a [PlatformException], if the invocation failed in the platform plugin.
  static Future<String?> getInitialText() async {
    return await _mChannel.invokeMethod('getInitialText');
  }

  static Stream<String> getTextStream() {
    if (_streamLink == null) {
      _streamLink = _eChannel.receiveBroadcastStream().cast<String>();
    }
    return _streamLink!;
  }
}
