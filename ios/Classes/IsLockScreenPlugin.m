#import "IsLockScreenPlugin.h"
#if __has_include(<is_lock_screen/is_lock_screen-Swift.h>)
#import <is_lock_screen/is_lock_screen-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "is_lock_screen-Swift.h"
#endif

@implementation IsLockScreenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIsLockScreenPlugin registerWithRegistrar:registrar];
}
@end
