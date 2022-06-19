import Flutter
import UIKit
//#define UIColorFromRGB(rgbValue)  ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

public class SwiftFlutterJverifyPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_jverify", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterJverifyPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "init":
            let config = JVAuthConfig()
            config.appKey = call.stringValue(key: "appKey")
            if let channel = call.stringValue(key: "channel") {
                config.channel = channel
            }
            if let timeOut = call.intValue(key: "timeOut") {
                config.timeout = TimeInterval(timeOut)
            }
            config.authBlock = { (r) -> Void in
                if let code = r?["code"] {
                    print("极光初始化：\(r) \(code)")
                    result(code as! Int == 8000)
                    
                }else{
                    result(false)
                }
                
                
                
            }
            JVERIFICATIONService.setup(with: config)
            break;
        case "checkVerifyEnable":
            result(JVERIFICATIONService.checkVerifyEnable())
            break
        case "getToken":
            JVERIFICATIONService.getToken { (r) in
                print("极光getToken：\(r) ")
                if let code = r?["code"] {
                    result(code as! Int == 7000)
                }else{
                    result(false)
                }
            }
            break
        case "preLogin":
            JVERIFICATIONService.preLogin(10000) { r in
                if let code = r?["code"] {
                    result(code as! Int == 7000)
                }else{
                    result(false)
                }
            }
            break
        case "clearPreLoginCache":
            JVERIFICATIONService.clearPreLoginCache()
            result(nil)
            break
        case "getAuthorization":
            let arguments = call.arguments as! Dictionary<String,Any?>
            let config = JVUIConfig();
            config.dismissAnimationFlag = arguments.boolValue(key: "dismissAnimationFlag") ?? true
            config.shouldAutorotate = arguments.boolValue(key: "shouldAutorotate") ?? true
            
            
            if let navColor = arguments.intValue(key: "navColor") {
                config.navColor = UIColorFromRGB(rgbValue: navColor)
            }
            if let navCustom = arguments.boolValue(key: "navCustom") {
                config.navCustom = navCustom
            }
            if let navText = arguments.stringValue(key: "navText") {
                config.navText = NSAttributedString(string: navText)
            }
            if let navReturnImg = arguments.stringValue(key: "navReturnImg") {
                config.navReturnImg = UIImage.init(named: navReturnImg)
            }
            if let navTransparent = arguments.boolValue(key: "navTransparent") {
                config.navTransparent = navTransparent
            }
            if let navReturnHidden = arguments.boolValue(key: "navReturnHidden") {
                config.navReturnHidden=navReturnHidden
            }
            if let navDividingLineHidden = arguments.boolValue(key: "navDividingLineHidden") {
                config.navDividingLineHidden = navDividingLineHidden
            }
            if let navBarBackGroundImage = arguments.stringValue(key: "navBarBackGroundImage") {
                config.navBarBackGroundImage = UIImage(named: navBarBackGroundImage)
            }
            if let statusBarStyle = arguments.stringValue(key: "statusBarStyle") {
                if(statusBarStyle == "light"){
                    config.preferredStatusBarStyle = UIStatusBarStyle.lightContent
                }else if #available(iOS 13.0, *){
                    print("极光 Config：\(arguments)")
                    config.preferredStatusBarStyle = UIStatusBarStyle.darkContent
                }
            }
            
     
            
            JVERIFICATIONService.customUI(with: config) { view in
                
            }
            
            
            JVERIFICATIONService.getAuthorizationWith(UIApplication.shared.keyWindow?.rootViewController, hide: call.boolValue(key: "autoHidden") ?? true,animated: call.boolValue(key: "animated") ?? true, timeout: TimeInterval(call.intValue(key: "timeout") ?? 10000)) { r in
                print("极光getAuthorization：\(r) ")
            } actionBlock: { code, msg in
                print("极光getAuthorization：\(code) \(msg) ")
            }
            
            break
        case "dismissLogin":
            JVERIFICATIONService.dismissLoginController(animated: call.boolValue(key: "animated") ?? true) {
                result(nil)
            }
            break
        default:
            result("Not Support Method")
        }
    }
    
    func UIColorFromRGB(rgbValue:Int) -> UIColor {
        return UIColor.init(red: CGFloat(Double(((rgbValue & 0xFF0000) >> 16))/255.0), green: CGFloat(Double(((rgbValue & 0xFF00) >> 8))/255.0), blue: CGFloat(Double((rgbValue & 0xFF))/255.0), alpha: 1.0)
    }
}
extension FlutterMethodCall{
    func stringValue(key:String) -> String? {
        return (arguments as? Dictionary<String,Any?>)?[key] as? String
    }
    
    func intValue(key:String) -> Int? {
        return ((arguments as? Dictionary<String,Any?>)?[key] as? Int)
    }
    func boolValue(key:String) -> Bool? {
        return ((arguments as? Dictionary<String,Any?>)?[key] as? Bool)
    }
}

extension Dictionary{
    func stringValue(key:String) -> String? {
        return( self as! Dictionary<String,Any?>)[key] as? String
    }
    func boolValue(key:String) -> Bool? {
        return( self as! Dictionary<String,Any?>)[key] as? Bool
    }
    func intValue(key:String) -> Int? {
        return( self as! Dictionary<String,Any?>)[key] as? Int
    }
}
