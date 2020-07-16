library is_lock_screen;

import 'package:flutter/services.dart';

Future<bool> isLockScreen() async {
  const channel = MethodChannel('is_lock_screen');
  return await channel.invokeMethod('isLockScreen') as bool;
}
