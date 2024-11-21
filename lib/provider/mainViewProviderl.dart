import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siiimple/util/regExp.dart';

class MainViewProvider with ChangeNotifier {
  Key eventKey = const ValueKey(0);
  Key ooKey = const ValueKey(0);
  String screenStr = '0'; // 화면용
  String a = ''; // 계산식 A
  String b = ''; // 계산식 B
  String o = ''; // 연산자

  void clickButton(String str) {
    if (str.isNumber) {
      if (o.isEmpty) {
        a += str; // A에 값 저장
        //b = ''; // B 값 초기화 (A 의 값을 저장할 때, B의 값은 존재 할 수 없음)
        screenStr = double.parse(a).toString().replaceAll(MyRegExp.delZeros, ''); // A에 저장된 값 화면에 노출
      } else {
        b += str; // B에 값 저장
        screenStr = double.parse(b).toString().replaceAll(MyRegExp.delZeros, ''); // B에 저장된 값 화면에 노출
      }
    } else {
      if (str.isOperator) {
        if (a.isNotEmpty && b.isNotEmpty) {
          // A, B 값이 비어 있지 않다면 값 계산

          calculation(o, double.parse(a), double.parse(b));
        }
        o = str; // 연산자 저장
      } else {
        if (o.isEmpty) {
          screenStr = decorateStr(str, screenStr);
          a = screenStr;
          // a값
        } else {
          screenStr = decorateStr(str, screenStr);
          b = screenStr;
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
        return decoStr = (double.parse(num) * -1).toString().replaceAll(MyRegExp.delZeros, '');
      case '%':
        return decoStr = (double.parse(num) * 0.01).toString().replaceAll(MyRegExp.delZeros, '');
      case '.':
        return decoStr = num + '.'.replaceAll(MyRegExp.delZeros, '');
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

  //중간 계산
  void calculationFormula() {
    // result =
  }

  void calculation(String operator, double a, double b) {
    print(' $a $operator $b ');
    switch (operator) {
      case '+':
        screenStr = (a + b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
      case '−':
        screenStr = (a - b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
      case '×':
        screenStr = (a * b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
      case '÷':
        screenStr = (a / b).toString().replaceAll(MyRegExp.delZeros, '');
        this.a = screenStr; // 계산된 값 A에 저장
        this.b = ''; // B 값 초기화
        break;
    }
    notifyListeners();
  }
}
