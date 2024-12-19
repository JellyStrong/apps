import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../model/model.dart';

const int closeKey = 100;
const int minimizeKey = 101;
const int maximizeKey = 102;

/* DEVICE INFO
 * getHeight()
 * getWidth()
 * getSize()
 *
 * */
class DeviceInfo {
  /// 화면 세로값 가져 오기
  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// 화면 가로값 가져 오기
  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 화면 가로값 세로값 가져 오기
  Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// 플랫폼 상태 데이터
  Future<void> initPlatformState() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    Model().setDeviceData = deviceInfo.data;
    // deviceData = deviceInfo.data;
    print('ddd1: ${Model().getDeviceData}');
    print(readAndroidBuildData(deviceInfo));
    Model().setDeviceData = readAndroidBuildData(deviceInfo);
    print('ddd2: ${Model().getDeviceData}');
  }

  Map<String, dynamic> readAndroidBuildData(BaseDeviceInfo data) {
    print('dddd4: ${Model().deviceData}');
    Model().setDeviceData = data.data;
    print('ddd3: ${Model().getDeviceData}');
    return <String, dynamic>{
      'model': data.data['model'],
    };
  }

// Map<String, dynamic> info() {
//   initPlatformState();
//   print('deviceData: ${deviceData}');
//   return deviceData;
// }
}

/* WINDOW CONTROL (WC)
 * initialization()
 * getLayoutRandomOffset()
 * getMenuOffset()
 * btnHoverMenu
 * btnHover
 * btnClick
 *
 * */
class WindowControls with ChangeNotifier {
  // 1. 윈더우 컨트롤 마우스 호버시 메뉴 아이콘 노출
  // 2. 윈도우 컨트롤 마우스 1.5초 호버시 메뉴 노툴
  // 3. 윈도우 컨트롤 빨간버튼 노란버튼 초록버튼 관련 이벤트

  Key key = const ValueKey(0);
  bool hover = false;

  /// 초기화
  void initialization() {
    key = const ValueKey(0);
    hover = false;
  }

  /// 랜덤 좌표값 리턴
  Offset getLayoutRandomOffset(BuildContext context, double left, double top) {
    Random random = Random();
    Offset randomOffset = const Offset(0, 0);
    double x = random.nextDouble() * (DeviceInfo().getWidth(context) - left);
    double y = random.nextDouble() * (DeviceInfo().getHeight(context) - top - 40); // 40:상태창
    randomOffset = Offset(x, y + 40); // 40:상태창
    print(randomOffset);
    return randomOffset;
  }

  /// 메뉴 좌표값 리턴
  Offset getMenuOffset(BuildContext context) {
    RenderBox renderBox;
    Offset position = const Offset(0, 0); //초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      renderBox = context.findRenderObject() as RenderBox;
      position = renderBox.localToGlobal(Offset.zero); // (0, 0)은 위젯의 좌측 상단
    });
    return position + const Offset(0, 5);
  }

  /// hover 1.5ms 후 menu 띄우기
  void btnHoverMenu({
    required Key key,
    required BuildContext context,
    String? str,
  }) {
    this.key = key;

    switch ((key as ValueKey).value) {
      case closeKey:
        //close
        break;
      case minimizeKey:
        break;
      case maximizeKey:
        break;
    }

    notifyListeners();
  }

  /// hover
  void btnHover({
    required BuildContext context,
    required bool hover,
  }) {
    this.hover = hover;
    notifyListeners();
  }

  /// click
  void btnClick({
    required Key key,
    required BuildContext context,
    String? str,
    required OverlayEntry overlay,
  }) {
    switch (str) {
      case 'close':
        overlay.remove(); // Overlay 제거
        initialization(); // 초기화
        break;
      case 'minimize':
        break;
      case 'maximize':
        break;
    }
  }
}
