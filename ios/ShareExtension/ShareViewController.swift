//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by LAP14187 on 29/01/2022.
//

import MobileCoreServices
import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    let hostAppBundleIdentifier = "com.bitom.mobile.breeze"
    let sharedKey = "ShareKey"
    var sharedText: [String] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let urlTypeIdentifier = kUTTypeURL as String
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = item.attachments?.first, itemProvider.hasItemConformingToTypeIdentifier(urlTypeIdentifier) {
                itemProvider.loadItem(forTypeIdentifier: urlTypeIdentifier, options: nil) { [weak self] url, error in
                    if let podcastUrl = url as? URL {
                        self?.handleUrl(url: podcastUrl)
                        return
                    }
                    
                    self?.dismissWithError()
                }
                
                return
            }
        }
        
        self.dismissWithError()
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {}

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

    private func handleUrl(url: URL) {
        self.sharedText.append(url.absoluteString)
        
        let userDefaults = UserDefaults(suiteName: "group.\(self.hostAppBundleIdentifier)")
        userDefaults?.set(self.sharedText, forKey: self.sharedKey)
        userDefaults?.synchronize()
        
        let appUrl = URL(string: "BreezeShare://dataUrl=\(sharedKey)#text")!
        var responder = self as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")
        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                let _ = responder?.perform(selectorOpenURL, with: appUrl)
            }
            responder = responder!.next
        }
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    private func dismissWithError() {
        let alert = UIAlertController(title: "Error", message: "Error loading data", preferredStyle: .alert)

        let action = UIAlertAction(title: "Error", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

}
