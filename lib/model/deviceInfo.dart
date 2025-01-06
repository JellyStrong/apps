import 'package:hive/hive.dart';

part 'deviceInfo.g.dart';

@HiveType(typeId: 1)
class DeviceInfoData {
  @HiveField(0)
  final String model;

  DeviceInfoData({required this.model});
}
