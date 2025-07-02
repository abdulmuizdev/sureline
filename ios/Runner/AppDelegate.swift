import UIKit
import Flutter
import FacebookShare
import AVFoundation
import UniformTypeIdentifiers
import PhotosUI
import AVKit
import MessageUI
import TikTokOpenSDKCore
import TikTokOpenShareSDK
import WidgetKit

@main
@objc class AppDelegate: FlutterAppDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
//                            UIResponder, UIApplicationDelegate

{
    private var channel: FlutterMethodChannel?
    private var channel2: FlutterMethodChannel?
    private let videoRenderer = VideoRenderer()
    private var eventSink: FlutterEventSink?
    private var request: TikTokShareRequest?

    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        if TikTokURLHandler.handleOpenURL(url) {
            return true
        }
        return false
    }

    override func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        if (TikTokURLHandler.handleOpenURL(userActivity.webpageURL)) {
            return true
        }
        return false
    }


  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)



      let controller = window?.rootViewController as! FlutterViewController
      channel2 = FlutterMethodChannel(name: "com.abdulmuiz.sureline/render", binaryMessenger: controller.binaryMessenger)

      channel = FlutterMethodChannel(name: "com.abdulmuiz.sureline/share", binaryMessenger: controller.binaryMessenger)
      let widgetChannel = FlutterMethodChannel(name: "com.abdulmuiz.sureline.quoteWidget", binaryMessenger: controller.binaryMessenger)
            // Handle the method call to refresh the widget
            widgetChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
              if call.method == "triggerWidgetUpdate" {
                  WidgetCenter.shared.reloadAllTimelines()
                  result("Widget updated successfully")
              }else if call.method == "updateWidgetBg" {
                  guard let args = call.arguments as? [String: Any],
                                let path = args["path"] as? String
                   else {
                            result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                            return
                  }
                  self.copyImageToAppGroup(path: path);
                  if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.abdulmuiz.sureline.quoteWidget") {
                      let testImageURL = containerURL.appendingPathComponent("widget_background.jpg")
//                      result("Path exists:" + FileManager.default.fileExists(atPath: testImageURL.path).description)
                      if let image = UIImage(contentsOfFile: testImageURL.path) {
                          result("✅ UIImage loaded successfully")
                      } else {
                          result("❌ Failed to load UIImage")
                      }
                  }

                  result(true);
              }
                else {
                result(FlutterMethodNotImplemented)
              }
            }

          channel?.setMethodCallHandler { (call, result) in
            if call.method == "share" {
                guard let args = call.arguments as? [String: Any],
                              let path = args["path"] as? String,
                              let schema = args["schema"] as? String,
                              let targetAppIdentifier = args["targetAppIdentifier"] as? String,
                              let isImage = args["isImage"] as? Bool,
                              let appID = args["appID"] as? String else {
                          result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                          return
                }

                self.shareLink(isImage: isImage, targetAppIdentifier: targetAppIdentifier, schema: schema, videoURL: "file://"+path, appID: appID)
                result(true)
            } else if call.method == "shareMessage" {
                guard let args = call.arguments as? [String: Any],
                      let path = args["path"] as? String else
                               {
                          result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                          return
                }
                self.presentMessageCompose(with: path, from: controller, result: result)
                return
            } else if call.method == "shareTikTok" {
                guard let args = call.arguments as? [String: Any],
                      let path = args["path"] as? String,
                      let isImage = args["isImage"] as? Bool
                else
                               {
                          result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                          return
                }
                let fileURL = URL(fileURLWithPath: path)
                var placeholderIdentifier: String?

                PHPhotoLibrary.shared().performChanges({
                    let request: PHAssetChangeRequest?;
                    if (isImage) {
                        request = PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: fileURL)
                    }else {
                        request = PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
                    }

                    placeholderIdentifier = request?.placeholderForCreatedAsset?.localIdentifier
                }) { success, error in
                    if success, let identifier = placeholderIdentifier {
                        let shareRequest = TikTokShareRequest(localIdentifiers: [identifier],
                                                              mediaType: (isImage) ? .image : .video,
                                                              redirectURI: "")

                        DispatchQueue.main.async {
                            shareRequest.send()
//                            shareRequest.send { response in
//
//                                guard let shareResponse = response as? TikTokShareResponse else { return }
//                                if shareResponse.errorCode == .noError {
//                                    print("Share succeeded!")
//                                } else {
//                                    print("Share Failed!")
//                                           print("Error Code: \(shareResponse.errorCode.rawValue)")
//                                    print("Error Message: \(shareResponse.errorDescription ?? "")")
//                                    print("Share State: \(shareResponse.shareState)")
//
//                                }
//                            }
                        }
                    }else {
                        print("failed to save video")
                        print(error)
                    }
                }


            } else if call.method == "shareInstagram" {
                guard let args = call.arguments as? [String: Any],
                      let path = args["path"] as? String,
                      let isImage = args["isImage"] as? Bool
                else
                               {
                          result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                          return
                }

                self.postToFeed(isImage: isImage, path: path, caption: "from Sureline", bounds: controller.view.bounds, view: controller.view)


//                guard FileManager.default.fileExists(atPath: path) else {
//                    print("File does not exist")
//                    return
//                }
//                let documentController = UIDocumentInteractionController(url: videoURL)
//
//                documentController.uti = "com.instagram.photo"
//                documentController.delegate = nil
//                DispatchQueue.main.async {
//                    documentController.presentOptionsMenu(from: controller.view.bounds, in: controller.view, animated: true)
//                }


            }else if call.method == "shareFacebook" {

                guard let args = call.arguments as? [String: Any],
                      let path = args["path"] as? String
                else
                               {
                          result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                          return
                }

                guard let image = UIImage(contentsOfFile: path) else {
                    return
                }
                let photo = SharePhoto(image: image, isUserGenerated: true)
                let content = SharePhotoContent()
                content.photos = [photo]

                content.hashtag = Hashtag("#sureline")

            self.dialog(controller: controller, withContent: content).show()


            }
              else {
              result(FlutterMethodNotImplemented)
            }
          }

      channel2?.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
                  if call.method == "addTextOverlay",
                     let args = call.arguments as? [String: Any],
                     let videoPath = args["videoPath"] as? String,
                     let textImageURL = args["textImageURL"] as? String {

                      self.videoRenderer.makeVideoPlayerItem(videoURL: videoPath, textImageURL: textImageURL) { url, progress in
                          if let sink = self.eventSink {
                              if let url = url {
                                  sink(["status": "completed", "filePath": url.path])
                              } else {
                                  sink(["status": "progress", "value": progress])
                              }
                          }
                      }
                      result(nil) // Acknowledge the method call; responses will be via eventSink


                  } else {
                      result(FlutterMethodNotImplemented)
                  }
              }
      // Event channel to send progress updates
              let eventChannel = FlutterEventChannel(name: "com.abdulmuiz.sureline/facebook_events", binaryMessenger: controller.binaryMessenger)
              eventChannel.setStreamHandler(self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    func copyImageToAppGroup(path: String) {
        let imagePath = path;

        let fileManager = FileManager.default
        guard let appGroupURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.abdulmuiz.sureline.quoteWidget") else {
            print("❌ Failed to get app group container")
            return
        }

        let destinationURL = appGroupURL.appendingPathComponent("widget_background.jpg")

        do {
            // Remove old file if exists
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            try fileManager.copyItem(atPath: imagePath, toPath: destinationURL.path)
            print("✅ Image copied to App Group container at \(destinationURL.path)")
        } catch {
            print("❌ Error copying image: \(error)")
        }
    }
    func dialog(controller: UIViewController , withContent content: SharingContent) -> ShareDialog {
        print("calling dialog")
        return ShareDialog(
            viewController: controller,
            content: content,
            delegate: nil
        )
    }
    func postToFeed(isImage: Bool, path: String, caption: String, bounds: CGRect, view: UIView) {

            PHPhotoLibrary.shared().performChanges({
                if (!isImage){
                    guard let url = URL(string: "file://"+path) else {
                        print("invalid video url")
                        return
                    }
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                }else {
                    PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: URL(string: path)!)
                }

            }, completionHandler: { [weak self] success, error in
                if success {
                    let fetchOptions = PHFetchOptions()
                    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                    let fetchResult : PHFetchResult<PHAsset>
                    if (!isImage) {
                        fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions)
                    }else {
                        fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                    }

                    if let lastAsset = fetchResult.firstObject {
                        let localIdentifier = lastAsset.localIdentifier
                        let urlFeed = "instagram://library?LocalIdentifier=" + localIdentifier

                        guard let url = URL(string: urlFeed) else {
                            print("Could not open url")
                            return
                        }
                        DispatchQueue.main.async {
                            if UIApplication.shared.canOpenURL(url) {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
//                                        self?.delegate?.success()
                                        print("success")
                                    })
                                } else {
                                    UIApplication.shared.openURL(url)
//                                    self?.delegate?.success()
                                    print("success")

                                }
                            } else {
//                                self?.delegate?.error(message: "Instagram not found")
                                print("Instagram not found")
                            }
                        }
                    }
                } else if let error = error {
//                    self?.delegate?.error(message: error.localizedDescription)
                    print(error.localizedDescription)
                }
                else {
//                    self?.delegate?.error(message: "Could not save the photo")
                    print("Could not save the photo")
                }
            })
        }

    func shareLink(isImage: Bool, targetAppIdentifier: String, schema: String, videoURL: String?, appID: String) {
        print(videoURL ?? "videoURL")
        guard let url = URL(string: videoURL!) else { return }
        let data = try? Data.init(contentsOf: url) as Data

        let finalSchema: String

        if (schema == "instagram-stories") {
            finalSchema = schema+"://share?source_application="+appID;
        }else {
            finalSchema = schema+"://share"
        }



        if let urlSchema = URL(string: finalSchema){
            if UIApplication.shared.canOpenURL(urlSchema) {
                let pasteboardItems: [[String: Any]]
                if (isImage) {
                    pasteboardItems = [
                        ["com."+targetAppIdentifier+".sharedSticker.backgroundImage": data as Any],
                        ["com."+targetAppIdentifier+".sharedSticker.appID" : appID]
                    ];
                }else {
                    pasteboardItems = [
                        ["com."+targetAppIdentifier+".sharedSticker.backgroundVideo": data as Any],
                        ["com."+targetAppIdentifier+".sharedSticker.appID" : appID]
                    ];
                }

                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60 * 5)];

                UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
                DispatchQueue.main.async {
                    UIApplication.shared.open(urlSchema)
                }
            }
        }
    }

    private func presentMessageCompose(with path: String, from controller: UIViewController, result: @escaping FlutterResult) {
        guard MFMessageComposeViewController.canSendAttachments() else {
            result(FlutterError(code: "UNAVAILABLE", message: "Messages app not available", details: nil))
            return
        }

        let messageVC = MFMessageComposeViewController()
        messageVC.messageComposeDelegate = self
        messageVC.body = "Check this quote!"

        let videoURL = URL(fileURLWithPath: path)
        if FileManager.default.fileExists(atPath: path) {
            messageVC.addAttachmentURL(videoURL, withAlternateFilename: "video.mp4")
        } else {
            result(FlutterError(code: "FILE_NOT_FOUND", message: "Video file not found", details: nil))
            return
        }

        controller.present(messageVC, animated: true, completion: nil)
        result(nil)
    }

    // Function to trigger widget update
    private func triggerWidgetUpdate() {
      // Reload all timelines of the widgets
      WidgetCenter.shared.reloadAllTimelines()
    }


}
extension AppDelegate : MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith resultStatus: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - FlutterStreamHandler for EventChannel
extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}
