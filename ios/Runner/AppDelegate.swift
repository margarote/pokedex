import Flutter
import UIKit
import FirebaseCore
import FirebaseAnalytics

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.pokedex/analytics"
    private var isFirebaseConfigured = false

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil {
            FirebaseApp.configure()
            isFirebaseConfigured = true
        }

        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { [weak self] call, result in
            self?.handleMethodCall(call: call, result: result)
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "logEvent":
            guard isFirebaseConfigured,
                  let args = call.arguments as? [String: Any],
                  let name = args["name"] as? String else {
                result(nil)
                return
            }
            let params = args["params"] as? [String: Any] ?? [:]
            Analytics.logEvent(name, parameters: params)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
