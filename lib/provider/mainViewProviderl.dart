import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siiimple/util/regExp.dart';

class MainViewProvider with ChangeNotifier {
  Key eventKey = const ValueKey(0);
  Key ooKey = const ValueKey(0);
  String screenStr = '0'; // 화면용
  String a = ''; // 계산식 A
  String b = ''; // 계산식 B
  String result = ''; //합
  String o = ''; // 연산자

  void clickButton(String str) {
    print(str + '아무거나');
    if (str.isNumber) {
      print(str);
      if (o.isEmpty) {
        print('6.');
        a += str; // A에 값 저장
        screenStr = double.parse(a).toString().replaceAll(MyRegExp.delZeros, ''); // A에 저장된 값 화면에 노출
      } else if (o.isNotEmpty) {
        print('7.');
        b += str; // B에 값 저장
        screenStr = double.parse(b).toString().replaceAll(MyRegExp.delZeros, ''); // B에 저장된 값 화면에 노출
      }
    } else {
      print(str);
      if (str.isReturn) {
        print('1.');
        if (a.isNotEmpty && b.isNotEmpty) {
          print('2.');
          calculation(o, double.parse(a), double.parse(b));
          if (str.isReturn) ooKey = const ValueKey(0);
        } else if (a.isNotEmpty && b.isEmpty) {
          print('3.');
          calculation(o, double.parse(a), double.parse(a), true);
          if (str.isReturn) ooKey = const ValueKey(0);
        } else {
          print('----');
          print(o);
          print(a);
          print(b);
        }
      } else if (str.isOperator) {
        print('4.');

        if (a.isNotEmpty && b.isNotEmpty) {
          print('5.');
          calculation(o, double.parse(a), double.parse(b));
        }
        print('aaaaa $o');
        o = str; // 연산자 저장
      } else {
        if (o.isEmpty) {
          screenStr = decorateStr(str, screenStr);
          a = screenStr;
          print(a);
          // a값
        } else {
          screenStr = decorateStr(str, screenStr);
          b = screenStr;
          print(b);
        }
      }
    }

    notifyListeners();
  }

  String decorateStr(String deco, String num) {
    String decoStr = '0'; // return

    switch (deco) {
      case 'AC':
        cleanBtn();
        break;
      case '⁺⧸₋':
        decoStr = (double.parse(num) * -1).toString().replaceAll(MyRegExp.delZeros, '');
        break;
      case '%':
        print(789 * 0.01);
        decoStr = (double.parse(num) * 0.01).toString().replaceAll(MyRegExp.delZeros, '');
        print(decoStr);
        break;
      case '.':
        decoStr = num + '.'.replaceAll(MyRegExp.delZeros, '');
        break;
    }
    print(decoStr);
    return decoStr;
  }

//basics
  //default
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
    screenStr = '0';
    a = '';
    b = '';
    o = '';
    ooKey = const ValueKey(0);
    notifyListeners();
  }

  void calculation(String operator, double a, double b, [bool same = false]) {
    print(' $a $operator $b ');
    switch (operator) {
      case '+':
        screenStr = same ? (double.parse(screenStr) + a).toString().replaceAll(MyRegExp.delZeros, '') : (a + b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
      case '−':
        screenStr = same ? (double.parse(screenStr) - a).toString().replaceAll(MyRegExp.delZeros, '') : (a - b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
      case '×':
        screenStr = same ? (double.parse(screenStr) * a).toString().replaceAll(MyRegExp.delZeros, '') : (a * b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
      case '÷':
        screenStr = same ? (double.parse(screenStr) / a).toString().replaceAll(MyRegExp.delZeros, '') : (a / b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = same ? a.toString() : screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
      // case '=':
      //   screenStr = same ? (double.parse(screenStr) + a).toString().replaceAll(MyRegExp.delZeros, '') : (a + b).toString().replaceAll(MyRegExp.delZeros, '');
      //   this.a = same ? a.toString() : screenStr; // 계산된 값 A에 저장
      //   this.b = ''; // B 값 초기화
      //   break;
    }
    notifyListeners();
  }
}
