import 'package:flutter/cupertino.dart';

/// device Info
class DeviceInfo {
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  // 생성자
  DeviceInfo({required Map<String, dynamic> deviceData}) : _deviceData = deviceData;

  /// getter
  Map<String, dynamic> get getDeviceData => _deviceData;

  /// setter
  set setDeviceData(Map<String, dynamic> v) => _deviceData = v;
}
