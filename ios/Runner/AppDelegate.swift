import FirebaseCore
import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }

        let shareChannelName = "pxQuotes/share"
        let controller: FlutterViewController = self.window?.rootViewController as! FlutterViewController
        let shareChannel = FlutterMethodChannel(name: shareChannelName, binaryMessenger: controller as! FlutterBinaryMessenger)
        shareChannel.setMethodCallHandler {
            (call: FlutterMethodCall, _: FlutterResult) in
            if call.method == "shareFile" {
                guard let resultNew = call.arguments! as? [String: Any] else { return }
                let imageValue = resultNew["imagePath"] as! String
                let color1Value = resultNew["topColor"] as! String
                let color2Value = resultNew["bottomColor"] as! String

                self.shareFile(imgPath: imageValue, color1: color1Value, color2: color2Value, controller: controller)
            }
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        signal(SIGPIPE, SIG_IGN)
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        signal(SIGPIPE, SIG_IGN)
    }

    private func shareFile(imgPath: String, color1: String, color2: String, controller: UIViewController) {
        if let urlScheme = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                let filePath = NSMutableString(string: imgPath)
                let docsPath: NSString = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
                let imagePath = docsPath.appendingPathComponent(filePath as String)
                let imageUrl = URL(fileURLWithPath: imagePath, relativeTo: nil)
                do {
                    let imageData = try Data(contentsOf: imageUrl)
                    let uiImage = UIImage(data: imageData)
                    let items = [[
                        "com.instagram.sharedSticker.stickerImage": uiImage,
                        "com.instagram.sharedSticker.backgroundTopColor": color1,
                        "com.instagram.sharedSticker.backgroundBottomColor": color2,
                    ]]
                    UIPasteboard.general.setItems(items)
                    UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)

                } catch {
                    print("ERROR")
                }
            }
        }
//        do {
//            let activityViewController = UIActivityViewController(activityItems: [imageUrl], applicationActivities: nil)
//            controller.present(activityViewController, animated: true, completion: nil)
//            print("DONE")
//        }
    }
}

struct Wand {
    let name: String
    let stickerAsset: String
}
