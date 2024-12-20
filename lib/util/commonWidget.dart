import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import 'util.dart';

/* WINDOW CONTROL BUTTON (WCB)
 * windowControlsBtn()
 * buttons()
 *
 * */
class WindowControlsBtn {
  /// window control 버튼 이벤트 관련 (공통)
  Widget windowControlsBtn({
    required BuildContext context,
    required ValueKey valueKey,
    required WindowControls provider,
    required String iconName,
    Map<String, dynamic>? overlayEntry,
    required IconData icon,
    required Color color,
    required String str,
    required OverlayEntry overlay,
  }) {
    return InkWell(
      onTap: () {
        context.read<WindowControls>().btnClick(
              key: valueKey,
              context: context,
              iconName: iconName,
              // overlay: overlay,
              // overlayEntries: overlayEntry,
              str: str,
            );
      },
      onHover: (hover) {
        Future.delayed(
          const Duration(milliseconds: 1500),
          () {
            if (context.mounted) {
              context.read<WindowControls>().btnHoverMenu(
                    key: valueKey,
                    context: context,
                  );
            }
          },
        );
      },
      child: Stack(
        key: valueKey,
        children: [
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(7)), color: color),
            child: Visibility(
              visible: provider.hover,
              child: Icon(
                icon,
                size: 12,
              ),
            ),
          ),

          // menu
          Transform.translate(
            offset: WindowControls().getMenuOffset(context),
            child: Visibility(
              visible: valueKey == provider.key,
              child: Container(
                height: 20,
                width: 3,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// window control 버튼 그리기 (빨,노,초) (공통)
  Widget buttons(OverlayEntry overlay, String iconName) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: SizedBox(
        height: 15,
        width: 60,
        child: Consumer<WindowControls>(
          builder: (context, provider, child) {
            return InkWell(
              onTap: () {},
              onHover: (hover) {
                context.read<WindowControls>().btnHover(
                      context: context,
                      hover: hover,
                    );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  windowControlsBtn(
                      context: context,
                      valueKey: const ValueKey(100),
                      provider: provider,
                      iconName: iconName,
                      // overlayEntry: overlayEntry,
                      icon: Icons.close_rounded,
                      color: Colors.red,
                      str: 'close',
                      overlay: overlay),
                  windowControlsBtn(
                      context: context,
                      valueKey: const ValueKey(101),
                      provider: provider,
                      iconName: iconName,
                      // overlayEntry: overlayEntry,
                      icon: Icons.remove_rounded,
                      color: Colors.yellow,
                      str: 'minimize',
                      overlay: overlay),
                  windowControlsBtn(
                      context: context,
                      valueKey: const ValueKey(102),
                      provider: provider,
                      iconName: iconName,
                      // overlayEntry: overlayEntry,
                      icon: Icons.add_rounded,
                      color: Colors.green,
                      str: 'maximize',
                      overlay: overlay),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/* ICON WIDGET
 * myApp
 *
 * */

Model model = Model();

class IconWidget {
  Widget myApp({
    required BuildContext context,
    required Widget child,
    required String iconPath,
    required String iconName,
    Color? backGround,
    required double maxWidth,
    required double maxHeight,
    List<Widget>? entry,
  }) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              OverlayEntry? overlayEntry;

              overlayEntry = OverlayEntry(builder: (BuildContext context) {
                return Positioned(
                  left: (WindowControls().getLayoutRandomOffset(context, maxWidth, maxHeight)).dx,
                  top: (WindowControls().getLayoutRandomOffset(context, maxWidth, maxHeight)).dy,
                  child: Material(
                    color: Colors.transparent, //뒷배경투명하게
                    child: Container(
                      /// 앱 틀
                      constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(13),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              blurRadius: 20.0,
                              spreadRadius: 5.0,
                              offset: const Offset(0, 10),
                            ),
                          ],
                          color: backGround ??= Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 공통 윈도우 컨트롤
                          WindowControlsBtn().buttons(overlayEntry!, iconName),
                          // 컨텐츠
                          child,
                        ],
                      ),
                    ),
                  ),
                );
              });

              if (!model.getEntries.containsKey(iconName)) {
                // 새로운 값이 들어갈 때 setEntries 사용하여 업데이트
                model.addEntry(iconName, overlayEntry);
                Overlay.of(context).insert(overlayEntry);
              }
            },
            child: SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            iconName,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white, shadows: [
              Shadow(
                color: Colors.black.withAlpha(100),
                blurRadius: 2.0,
                offset: const Offset(0, 2),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
