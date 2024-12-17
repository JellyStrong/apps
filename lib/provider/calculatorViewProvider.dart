import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siiimple/util/regExp.dart';

class CalculatorViewProvider with ChangeNotifier {
  Key eventKey = const ValueKey(0);
  Key ooKey = const ValueKey(0);
  String screenStr = '0'; // 화면용
  String numA = ''; // 계산식 A
  String numB = ''; // 계산식 B
  String result = ''; //합
  String o = ''; // 연산자

  void initialization() {
    screenStr = '0';
    numA = '';
    numB = '';
    o = '';
    ooKey = const ValueKey(0);
  }

  void clickButton(String str) {
    HapticFeedback.vibrate();
    if (str.isNumber) {
      if (o.isEmpty) {
        print('6.');
        numA += str; // A에 값 저장
        screenStr = numA.replaceAll(MyRegExp.pointLeftDelZeros, '');
      } else if (o.isNotEmpty) {
        print('7.');
        numB += str; // B에 값 저장
        screenStr = numB.replaceAll(MyRegExp.pointLeftDelZeros, '');
      }
    } else {
      if (str.isReturn) {
        print('1.');
        if (numA.isNotEmpty && numB.isNotEmpty) {
          print('2.');
          calculation(o, double.parse(numA), double.parse(numB));
          if (str.isReturn) ooKey = const ValueKey(0);
        } else if (numA.isNotEmpty && numB.isEmpty) {
          print('3.');
          calculation(o, double.parse(numA), double.parse(numA), true);
          if (str.isReturn) ooKey = const ValueKey(0);
        }
      } else if (str.isOperator) {
        print('4.');

        if (numA.isNotEmpty && numB.isNotEmpty) {
          print('5.');
          calculation(o, double.parse(numA), double.parse(numB));
        }
        print('aaaaa $o');
        o = str; // 연산자 저장
      } else {
        if (o.isEmpty) {
          screenStr = decorateStr(str, screenStr);
          numA = screenStr;
          print(numA);
          // a값
        } else {
          screenStr = decorateStr(str, screenStr);
          numB = screenStr;
          print(numB);
        }
      }
    }

    notifyListeners();
  }

  String decorateStr(String deco, String num) {
    String decoStr = '0'; // return
    print(num);

    switch (deco) {
      case 'AC':
        cleanBtn();
        break;
      case '⁺⧸₋':
        decoStr = (double.parse(num) * -1).toString().replaceAll(MyRegExp.pointRightDelZero, '');
        break;
      case '%':
        decoStr = (double.parse(num) * 0.01).toString().replaceAll(MyRegExp.pointRightDelZero, '');
        print(decoStr);
        break;
      case '.':
        //noMorePoint
        //RegExp(r'(?<=\.\d*)\.', ''
        decoStr = (num + '.').replaceAll(MyRegExp.noMorePoint, '');
        break;
    }
    print(decoStr);
    return decoStr;
  }

  void clickBtnChangeColor(Key key) {
    // 클릭한 key의 값을 가지고 있음
    eventKey = key;
    notifyListeners();
  }

  void clickBtnChangeBorder(Key key) {
    // 클릭한 key의 값을 가지고 있음
    ooKey = key;
    notifyListeners();
  }

  void cleanBtn() {
    initialization();
    notifyListeners();
  }

  void calculation(String operator, double a, double b, [bool same = false]) {
    print(' $a $operator $b ');
    switch (operator) {
      case '+':
        screenStr = same ? (double.parse(screenStr) + a).toString().replaceAll(MyRegExp.pointRightDelZero, '') : (a + b).toString().replaceAll(MyRegExp.pointRightDelZero, '');
        numA = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        numB = ''; // B 값 초기화
        break;
      case '−':
        screenStr = same ? (double.parse(screenStr) - a).toString().replaceAll(MyRegExp.pointRightDelZero, '') : (a - b).toString().replaceAll(MyRegExp.pointRightDelZero, '');
        numA = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        numB = ''; // B 값 초기화
        break;
      case '×':
        screenStr = same ? (double.parse(screenStr) * a).toString().replaceAll(MyRegExp.pointRightDelZero, '') : (a * b).toString().replaceAll(MyRegExp.pointRightDelZero, '');
        numA = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        numB = ''; // B 값 초기화
        break;
      case '÷':
        screenStr = same ? (double.parse(screenStr) / a).toString().replaceAll(MyRegExp.pointRightDelZero, '') : (a / b).toString().replaceAll(MyRegExp.pointRightDelZero, '');
        numA = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        numB = ''; // B 값 초기화
        break;
    }
    notifyListeners();
  }
}
