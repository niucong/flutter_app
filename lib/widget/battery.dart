//Fluter
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NativeSamples extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NativeSamplesState();
  }
}

class NativeSamplesState extends State<NativeSamples> {
  // 创建MethodChannel
  static const platform = const MethodChannel('samples.flutter.io/battery');
  static const EventChannel eventChannel =
      EventChannel('samples.flutter.io/charging');

//  // 定义一个Channel名字,Flutter端要和原生端一致
//  static const EventChannel eventChannels =
//      EventChannel('com.flutter.eventchannel/stream');
//  StreamSubscription _streamSubscription;
  String _eventString = '';

  // 定义电量信息变量
  String _batteryLevel = 'Unknown battery level.';
  String _chargingStatus = 'Battery status: unknown.';
  bool _hasPermission;

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);

//    // 创建EventChannel，并监听数据
//    _streamSubscription = eventChannel
//        .receiveBroadcastStream()
//        .listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object event) {
    setState(() {
      _chargingStatus =
          "Battery status: ${event == 'charging' ? '' : 'dis'}charging.";

      _eventString = "原生发送过来的：$event";
    });
  }

  void _onError(Object error) {
    setState(() {
      _chargingStatus = 'Battery status: unknown.';

      PlatformException exception = error;
      _eventString = exception?.message ?? '错误';
    });
  }

//  // 停止监听接收消息
//  void _disableEvent() {
//    if (_streamSubscription != null) {
//      _streamSubscription.cancel();
//      _streamSubscription = null;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter with Native'),
        primary: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(_chargingStatus),
            // 点击获取电量信息
            RaisedButton(
              child: Text('获取电池电量'),
              onPressed: _getBatteryLevel,
            ),
            // 显示电量信息
            Text(_batteryLevel),
            // 点击获取电量信息
            RaisedButton(
              child: Text('是否有权限'),
              onPressed: _requestPermission,
            ),
            // 显示电量信息
            Text(_hasPermission.toString()),
            RaisedButton(
              child: Text('接收原生发送的消息$_eventString'),
              onPressed: null,
            ),
//            AndroidView(viewType: 'addNativeLayout'),
          ],
        ),
      ),
    );
  }

  // 添加原生布局/控件
  Future<Widget> _addNativeLayout() async {
    try {
      await platform.invokeMethod('addNativeLayout');
    } on PlatformException catch (e) {}
  }

  // 调用原生获取电量信息的方法
  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      // 通过invokeMethod进行反射调用获取电量的原生中定义的方法名，获取返回值
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    // 更新返回结果值
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  // 前面的步骤相同，就不重复，直接写Flutter逻辑
  // 判断是否有权限，无权限就主动申请权限
  Future<Null> _requestPermission() async {
    bool hasPermission;
    try {
      // 传递参数，key-value形式
      hasPermission =
          await platform.invokeMethod('requestPermission', <String, dynamic>{
        'permissionName': 'WRITE_EXTERNAL_STORAGE',
        'permissionId': 0,
      });
    } on PlatformException catch (e) {
      hasPermission = false;
    }

    setState(() {
      _hasPermission = hasPermission;
    });
  }
}
