import 'package:flutter/services.dart';

class AppServiceChannel {
  static const channelName = "Syncreve/ServiceChannel";
  static const _channel = MethodChannel(channelName);

  static Future<String> startService(String confPath) async {
    return await _channel.invokeMethod("startService", {"confPath": confPath});
  }

  static Future<void> stopService() async {
    return await _channel.invokeMethod("stopService");
  }
}
