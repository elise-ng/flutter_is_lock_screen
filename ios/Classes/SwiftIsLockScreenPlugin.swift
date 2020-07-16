import Flutter
import UIKit

public class SwiftIsLockScreenPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "is_lock_screen", binaryMessenger: registrar.messenger())
        let instance = SwiftIsLockScreenPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "isLockScreen":
//            DispatchQueue.main.async {
//                // ref: https://stackoverflow.com/a/46002893
//                let prev = UIScreen.main.brightness
//                UIScreen.main.brightness = prev + (prev <= 0.01 ? 0.01 : -0.01)
//                let new = UIScreen.main.brightness
//                print("1prev \(prev) new \(new)")
//                return result(prev != new)
//            }
            return result(UIScreen.main.brightness == 0.0)
        default:
            return result(FlutterMethodNotImplemented)
        }
    }
}
