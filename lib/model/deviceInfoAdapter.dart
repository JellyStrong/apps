import 'package:hive/hive.dart';
import 'package:siiimple/model/deviceInfo.dart';

/// Hive Box 사용하기
Future<void> openBox() async {
  Box<DeviceInfoData> box = await Hive.openBox<DeviceInfoData>('deviceInfoBox');
}

/// 디바이스 정보 가져오기
Future<DeviceInfoData?> getDeviceInfo() async {
  var box = await Hive.openBox<DeviceInfoData>('deviceInfoBox');
  return box.get('device1'); // device1이라는 키로 데이터 가져오기
}

/// 디바이스 정보 저장하기
Future<void> saveDeviceInfo() async {
  var box = await Hive.openBox<DeviceInfoData>('deviceInfoBox');

  // 데이터 저장
  // await box.put('device1', DeviceInfoData(name: 'iPhone', version: 14));
}
