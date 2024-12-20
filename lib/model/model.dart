import 'package:flutter/cupertino.dart';

class Model {
  static final Model _instance = Model._internal();

  // 외부에서 직접 인스턴스를 생성할 수 없도록 private 생성자 사용
  Model._internal();

  factory Model() {
    return _instance;
  }

  Map<String, dynamic> deviceData = <String, dynamic>{};
  Map<String, OverlayEntry> entries = <String, OverlayEntry>{};

  /// getter ///

  Map<String, dynamic> get getDeviceData => deviceData;

  Map<String, OverlayEntry> get getEntries => entries;

  /// setter ///

  set setDeviceData(Map<String, dynamic> v) => deviceData = v;

  set setEntries(Map<String, OverlayEntry> v) => entries = v;

  void addEntry(String key, OverlayEntry overlayEntry) {
    setEntries = {...getEntries, key: overlayEntry};
    print('overlayEntry : $entries');
  }
}
