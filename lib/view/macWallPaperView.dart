import 'package:flutter/material.dart';
import 'package:siiimple/util/commonWidget.dart';
import 'calculatorView.dart';

class MacWallPaperView extends StatelessWidget {
  const MacWallPaperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Row(
          children: [
            Column(
              children: [
                IconWidget().iconWidget(
                  context: context,
                  child: calculatorView(context),
                  iconName: '계산기',
                  iconPath: 'assets/images/calculatorIcon.png',
                  maxWidth: 233,
                  maxHeight: 333,
                  backGround: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
