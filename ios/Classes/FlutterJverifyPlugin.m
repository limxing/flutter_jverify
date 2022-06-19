#import "FlutterJverifyPlugin.h"
#if __has_include(<flutter_jverify/flutter_jverify-Swift.h>)
#import <flutter_jverify/flutter_jverify-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_jverify-Swift.h"
#endif

@implementation FlutterJverifyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterJverifyPlugin registerWithRegistrar:registrar];
}
@end
