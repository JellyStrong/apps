import 'package:flutter/material.dart';
import 'dart:math';

const int closeKey = 100;
const int minimizeKey = 101;
const int maximizeKey = 102;

/// DEVICE INFO
class DeviceInfo {
  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

/// WINDOW CONTROL (WC)
class WindowControls with ChangeNotifier {
  // 1. 윈더우 컨트롤 마우스 호버시 메뉴 아이콘 노출
  // 2. 윈도우 컨트롤 마우스 1.5초 호버시 메뉴 노툴
  // 3. 윈도우 컨트롤 빨간버튼 노란버튼 초록버튼 관련 이벤트

  Key key = const ValueKey(0);
  bool hover = false;

  //초기화
  void initialization() {
    key = const ValueKey(0);
    hover = false;
  }

  getLayoutRandomOffset(BuildContext context) {
    Random random = Random();
    Offset randomOffset = Offset.zero; // 기본값으로 (0, 0)
    double x = random.nextDouble() * DeviceInfo().getWidth(context);
    double y = random.nextDouble() * DeviceInfo().getHeight(context);
    randomOffset = Offset(x, y);
    return randomOffset;
  }

  // 좌표
  getMenuOffset(BuildContext context) {
    RenderBox renderBox;
    Offset position = const Offset(0, 0); //초기화

    WidgetsBinding.instance.addPostFrameCallback((_) {
      renderBox = context.findRenderObject() as RenderBox;
      position = renderBox.localToGlobal(Offset.zero); // (0, 0)은 위젯의 좌측 상단
    });
    return position + const Offset(0, 5);
  }

  // hover 1.5ms 후 menu
  btnHoverMenu({
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

  // hover
  btnHover({
    required BuildContext context,
    required bool hover,
  }) {
    this.hover = hover;
    notifyListeners();
  }

  // click
  btnClick({
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
