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
        let brightness = UIScreen.main.brightness
        UIScreen.main.brightness = brightness + (brightness <= 0.01 ? (0.01) : (-0.01))
        return result(brightness != UIScreen.main.brightness)
    default:
        return result(FlutterMethodNotImplemented)
    }
}
