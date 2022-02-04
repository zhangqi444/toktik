import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var receiveSharingIntentEventChannel: FlutterEventChannel?
    private let receiveSharingIntentLinkStreamHandler = ReceiveSharingIntentLinkStreamHandler()
    private var initialSharedText: String?
    private var latestSharedText: String?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    receiveSharingIntentEventChannel = FlutterEventChannel(name: "com.bitom.mobile.breeze/receive-sharing-intent/event", binaryMessenger: controller.binaryMessenger)
    receiveSharingIntentEventChannel?.setStreamHandler(receiveSharingIntentLinkStreamHandler)
    
    let receiveSharingIntentChannel = FlutterMethodChannel(name: "com.bitom.mobile.breeze/receive-sharing-intent/method",
                                                           binaryMessenger: controller.binaryMessenger)
    receiveSharingIntentChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        switch call.method {
        case "getInitialText":
            result(self.initialSharedText)
        default:
            result(FlutterMethodNotImplemented);
        }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    
    if let url = launchOptions?[UIApplication.LaunchOptionsKey.url] as? URL, isSharingUrlScheme(url: url) && handleUrl(url: url, setInitialData: true) {
        return true
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        receiveSharingIntentEventChannel?.setStreamHandler(receiveSharingIntentLinkStreamHandler)
        if isSharingUrlScheme(url: url) && handleUrl(url: url, setInitialData: false) {
            return true
        }
        
        return super.application(app, open: url, options: options)
      }
    
    public func isSharingUrlScheme(url: URL) -> Bool {
        return url.absoluteString.hasPrefix("BreezeShare")
    }
    
    private func handleUrl(url: URL, setInitialData: Bool) -> Bool {
        let appGroupId = "group.\(Bundle.main.bundleIdentifier!)"
        let userDefaults = UserDefaults(suiteName: appGroupId)
        
        if let key = url.host?.components(separatedBy: "=").last,
            let sharedArray = userDefaults?.object(forKey: key) as? [String] {
            latestSharedText =  sharedArray.joined(separator: ",")
            if (setInitialData) {
                initialSharedText = latestSharedText
            }
            if let latestSharedText = latestSharedText {
                let _ = receiveSharingIntentLinkStreamHandler.handleLink(latestSharedText)
            }
            return true
        }
        
        return false
    }
}

class ReceiveSharingIntentLinkStreamHandler: NSObject, FlutterStreamHandler {
  
  var eventSink: FlutterEventSink?
  
  // links will be added to this queue until the sink is ready to process them
  var queuedLinks = [String]()
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    queuedLinks.forEach({ events($0) })
    queuedLinks.removeAll()
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }
  
  func handleLink(_ link: String) -> Bool {
    guard let eventSink = eventSink else {
      queuedLinks.append(link)
      return false
    }
    eventSink(link)
    return true
  }
}
