import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_jverify/flutter_jverify.dart';
import 'package:flutter_jverify/flutter_jverify_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    FlutterJverify.init("5ed372559690b17b1c4c4252").then((value) => print("极光初始化成功吗：$value"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Demo(),
        ),
      ),
    );
  }
}
class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {

      _platformVersion = await FlutterJverify.platformVersion ?? 'Unknown platform version';
      setState(() {

      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;


  }
  String _platformVersion = 'Unknown';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    print("Flutter build");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Running on: $_platformVersion\n'),
        CupertinoButton(
            child: Text("open"),
            onPressed: () {

              FlutterJverify.getAuthorization(JVUIConfig()
                ..navColor = Colors.white.value
                ..statusBarStyle = StatusBarStyle.dark

              );
            }),
      ],
    );
  }
}

