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
            // ref: https://stackoverflow.com/a/46002893
            let prev = UIScreen.main.brightness
            UIScreen.main.brightness = prev + (prev <= 0.01 ? (0.01) : (-0.01))
            let new = UIScreen.main.brightness
            print("prev \(prev) new \(new)")
            return result(prev != new)
        default:
            return result(FlutterMethodNotImplemented)
        }
    }
}
