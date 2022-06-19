import 'dart:async';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter_jverify/flutter_jverify_ui.dart';

class FlutterJverify {
  static const MethodChannel _channel = MethodChannel('flutter_jverify');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///初始化
  static Future init(String appKey, {String? channel, int? timeOut}) {
    return _channel.invokeMethod("init", {'appKey': appKey, 'channel': channel, 'timeOut': timeOut});
  }

  ///检测是否可用
  static Future<bool?> get checkVerifyEnable => _channel.invokeMethod<bool>("checkVerifyEnable");

  ///获取token
  static Future<bool?> get getToken => _channel.invokeMethod<bool>("getToken");

  ///预登录
  static Future<bool?> get preLogin => _channel.invokeMethod('preLogin');

  ///清除预登录缓存
  static Future get clearPreLoginCache => _channel.invokeMethod('clearPreLoginCache');

  ///启动登录页面
  static Future getAuthorization(JVUIConfig uiConfig) {
    return _channel
        .invokeMethod("getAuthorization", uiConfig.json);
  }

  ///关闭登录页面
  static Future dismissLogin({bool? animated}) {
    return _channel.invokeMethod("dismissLogin", {'animated': animated});
  }
}
