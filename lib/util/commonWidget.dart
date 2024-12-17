import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common.dart';

class WindowControlsBtn {
  Widget windowControlsBtn({
    required BuildContext context,
    required ValueKey valueKey,
    required WindowControls provider,
    required IconData icons,
    required Color color,
    required String str,
    required OverlayEntry overlay,
  }) {
    return InkWell(
      onTap: () {
        // 클릭 이벤트
        context.read<WindowControls>().btnClick(
              key: valueKey,
              context: context,
              overlay: overlay,
              str: str,
            );
      },
      onHover: (hover) {
        print('22222');
        Future.delayed(
          const Duration(milliseconds: 1500),
          () {
            //메뉴 띄우기
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
                icons,
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

  Widget buttons(OverlayEntry overlay) {
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
                print('1111111');
                context.read<WindowControls>().btnHover(
                      context: context,
                      hover: hover,
                    );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  windowControlsBtn(context: context, valueKey: const ValueKey(100), provider: provider, icons: Icons.close_rounded, color: Colors.red, str: 'close', overlay: overlay),
                  windowControlsBtn(context: context, valueKey: const ValueKey(101), provider: provider, icons: Icons.remove_rounded, color: Colors.yellow, str: 'minimize', overlay: overlay),
                  windowControlsBtn(context: context, valueKey: const ValueKey(102), provider: provider, icons: Icons.add_rounded, color: Colors.green, str: 'maximize', overlay: overlay),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class IconWidget {
  Widget iconWidget({
    required BuildContext context,
    required Widget child,
    required String iconPath,
    required String iconName,
    Color? backGround,
    double? maxWidth,
    double? maxHeight,
    List<Widget>? entry,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            OverlayEntry? overlayEntry;
            overlayEntry = OverlayEntry(builder: (BuildContext context) {
              return Positioned(
                top: (WindowControls().getLayoutRandomOffset(context)).dx,
                left: (WindowControls().getLayoutRandomOffset(context)).dy,
                child: Material(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: maxWidth ??= double.infinity, maxHeight: maxHeight ??= double.infinity),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(13),
                        ),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black.withOpacity(0.5),
                            color: Colors.black.withAlpha(5),
                            blurRadius: 30.0,
                            spreadRadius: 5.0,
                            offset: const Offset(0, 12),
                          ),
                        ],
                        color: backGround ??= Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 공통 윈도우 컨트롤
                        WindowControlsBtn().buttons(overlayEntry!),
                        child,
                      ],
                    ),
                  ),
                ),
              );
            });
            Overlay.of(context).insert(overlayEntry);
            // openWidget(context: context, maxWidth: 233, maxHeight: 333, child: child, backGround: Colors.blue);
          },
          child: Image.asset(
            // 'assets/images/calculatorIcon.png',
            iconPath,
            width: 70,
            height: 70,
          ),
        ),
        Text(iconName),
      ],
    );
  }
}
