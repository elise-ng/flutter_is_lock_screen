package com.chihimng.is_lock_screen

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** IsLockScreenPlugin */
public class IsLockScreenPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "is_lock_screen")
    channel.setMethodCallHandler(this);
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "is_lock_screen")
      channel.setMethodCallHandler(IsLockScreenPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    switch (call.method) {
      case "isLockScreen":
      // Ref: https://gist.github.com/Jeevuz/4ec01688083670b1f3f92af64e44c112
      val keyguardManager: KeyguardManager = context.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
      val inKeyguardRestrictedInputMode: Boolean = keyguardManager.inKeyguardRestrictedInputMode()

      val isLocked = if (inKeyguardRestrictedInputMode) {
        true
      } else {
        val powerManager: PowerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT_WATCH) {
          !powerManager.isInteractive()
        } else {
          !powerManager.isScreenOn()
        }
      }
      return result.success(isLocked)
      default:
      return result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
