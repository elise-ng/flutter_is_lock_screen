library is_lock_screen;

import 'package:flutter/services.dart';

final _channel = MethodChannel('is_lock_screen');

Future<bool> isLockScreen() async {
  try {
    return await _channel.invokeMethod('isLockScreen') as bool;
  } catch (e) {
    print(e.toString());
    return null;
  }
}
