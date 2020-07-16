# is_lock_screen

Detects if device is in lock screen. Useful for determining whether app entered background due to locking screen or leaving app.

## Usage

Import library and call the following method.

```dart
await isLockScreen(); // Returns bool. Null when exception occurs.
```

You will probably observe the app lifecycle state and call this when app is in background:

```dart
// Extend class with WidgetsBindingObserver
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

An alternative to this plugin is [hardware_buttons](https://pub.dev/packages/hardware_buttons), which uses non-public API (`com.apple.springboard.lockcomplete`) to detect lock button usage and violates App Store requirements.

To circumvent this issue, this plugin detects whether device is in lock screen by attempting to adjust screen brightness as suggested [in this stack overflow answer](https://stackoverflow.com/a/46002893). For android, this plugin uses KeyguardManager and PowerManager API as outlined [in this gist](https://gist.github.com/Jeevuz/4ec01688083670b1f3f92af64e44c112).
