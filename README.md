# is_lock_screen

Detects if device is locked. Useful for determining whether app entered background due to locking screen or leaving app.

## Usage

Import library and call the following method.

Note that this only works on physical device for iOS.

```dart
bool result = await isLockScreen();
```

You will probably observe the app lifecycle state and call this when app is in background:

```dart
// Extend class with WidgetsBindingObserver
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print('app inactive, is lock screen: ${await isLockScreen()}');
    }
  }
```

## Why this plugin?

An alternative to this plugin is [hardware_buttons](https://pub.dev/packages/hardware_buttons), which uses non-public API (`com.apple.springboard.lockcomplete`) on iOS to detect lock button usage and violates App Store requirements.

To circumvent this issue, this plugin detects whether iOS device is in lock screen by checking if screen brightness is 0.0 (the user-adjustable minimum is >0.01).

On android, this plugin uses `KeyguardManager` and `PowerManager` API to check if device is secured or display is off as suggested [in this gist](https://gist.github.com/Jeevuz/4ec01688083670b1f3f92af64e44c112). A similar flow was tested on iOS with `LocalAuthentication` and `UIApplication.shared.isProtectedDataAvailable` but failed due to long grace period of the system lock down. The flag always return true the moment screen is locked.