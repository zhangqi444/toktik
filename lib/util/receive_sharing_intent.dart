import 'package:flutter/services.dart';

class ReceiveSharingIntent {
  static const _mChannel = const MethodChannel(
      "com.bitom.mobile.breeze/receive-sharing-intent/method");
  static const _eChannel = const EventChannel(
      "com.bitom.mobile.breeze/receive-sharing-intent/event");

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
