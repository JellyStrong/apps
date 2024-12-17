import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:siiimple/util/commonWidget.dart';
import 'package:siiimple/util/regExp.dart';

import '../provider/calculatorViewProvider.dart';
import '../util/common.dart';

class CalculatorView_1 extends StatelessWidget {
  const CalculatorView_1({super.key, required BuildContext context, required OverlayEntry overlay});

  Widget btnPad(Key btnKey, Color btnColor, String str, BuildContext context) {
    return GestureDetector(
      //키보드 입력
      onTapDown: (_) {
        /// 화면 숫자 노출 이벤트 & 화면 계산 관련 함수
        context.read<CalculatorViewProvider>().clickButton(str);

        /// 화면 숫자 버튼에 색상 이벤트
        context.read<CalculatorViewProvider>().clickBtnChangeColor(btnKey);

        /// 화면 연산자 버튼에 테두리 이벤트
        if (str.isOperator) context.read<CalculatorViewProvider>().clickBtnChangeBorder(btnKey);
        if (str.isReturn) context.read<CalculatorViewProvider>().clickBtnChangeBorder(const ValueKey(0));
      }, //키보드 입력 종료
      onTapUp: (_) {
        /// 화면 숫자판 색상에 이벤트
        context.read<CalculatorViewProvider>().clickBtnChangeColor(const ValueKey(0));
      },
      //키보드 입력 취소
      onTapCancel: () {
        /// 화면 숫자판 색상에 이벤트
        context.read<CalculatorViewProvider>().clickBtnChangeColor(const ValueKey(0));
      },
      child: Consumer<CalculatorViewProvider>(
        builder: (context, provider, child) {
          return Container(
            key: btnKey,
            alignment: Alignment.center,
            //TODO: 추후 테마 적용..
            decoration: BoxDecoration(
              border: btnKey == provider.ooKey ? Border.all(width: 1.5, color: Colors.blueGrey) : Border.all(width: 0.5, color: Colors.blue),
              color: btnKey == provider.eventKey ? const Color(0x99FFFFFF) : btnColor,
            ),
            child: Text(
              str,
              style: TextStyle(color: Colors.white, fontSize: str.isNumber ? 24 : 26, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 255, maxHeight: 355),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: const BorderRadius.all(
                Radius.circular(13),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 30.0,
                  spreadRadius: 5.0,
                  offset: const Offset(0, 12),
                ),
              ],
              color: Colors.blue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 공통 윈도우 컨트롤
            //  WindowControlsBtn().buttons(),

              /// Text
              Container(
                alignment: Alignment.bottomRight,
                height: 65,
                padding: const EdgeInsets.only(left: 15.0, right: 13.0),
                child: Consumer<CalculatorViewProvider>(
                  builder: (BuildContext context, CalculatorViewProvider provider, Widget? child) {
                    return AutoSizeText(
                      provider.screenStr,
                      maxLines: 1,
                      style: const TextStyle(height: 1.2, color: Colors.white, fontSize: 55, fontWeight: FontWeight.w300),
                    );
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Row(
                  children: [
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(1), Colors.indigo, 'AC', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(2), Colors.indigo, '⁺⧸₋', context)), //±
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(3), Colors.indigo, '%', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(4), Colors.orangeAccent, '÷', context)),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(5), Colors.lightBlueAccent, '7', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(6), Colors.lightBlueAccent, '8', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(7), Colors.lightBlueAccent, '9', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(8), Colors.orangeAccent, '×', context)),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(9), Colors.lightBlueAccent, '4', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(10), Colors.lightBlueAccent, '5', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(11), Colors.lightBlueAccent, '6', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(12), Colors.orangeAccent, '−', context)),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(13), Colors.lightBlueAccent, '1', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(14), Colors.lightBlueAccent, '2', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(15), Colors.lightBlueAccent, '3', context)),
                    Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(16), Colors.orangeAccent, '+', context)),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(13),
                      bottomRight: Radius.circular(13),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(fit: FlexFit.tight, flex: 2, child: btnPad(ValueKey(17), Colors.lightBlueAccent, '0', context)),
                      Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(18), Colors.lightBlueAccent, '.', context)),
                      Flexible(fit: FlexFit.tight, flex: 1, child: btnPad(ValueKey(19), Colors.orangeAccent, '=', context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
