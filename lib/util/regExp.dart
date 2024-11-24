class MyRegExp {
  MyRegExp._();

  //이메일 정규식
  static RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); //email

  //비밀번호 정규식
  static RegExp passwordRegex = RegExp(r'^.{5,}$'); //최소 5글자 이상

  //사칙연산, 나누기, 나머지 정규식 (사용중) r'[+\-*]'
  //RegExp(r'[+\u2212\u00D7\u00F7]')
  static RegExp operators = RegExp(r'[+\−×\÷]'); //calculation code
  //사칙연산, 나누기, 나머지 정규식 (사용중)
  // = (사용중)
  static RegExp result = RegExp(r'[=]$');

  //숫자 (사용중)
  static RegExp num = RegExp(r'[0-9]$');
  static RegExp delZeros = RegExp(r'\.?0+$'); //소수점 뒤에 불필요한 0을 제거
//screenStr += str.replaceFirst(RegExp(r'^0+'), '').replaceAll(MyRegExp.delZeros, '');
}

extension StringExtension on String {
  bool get isOperator {
    return MyRegExp.operators.hasMatch(this); // String
  }

  bool get isNumber {
    return MyRegExp.num.hasMatch(this); // String
  }

  bool get isReturn {
    return MyRegExp.result.hasMatch(this); // String
  }

  String get isEmail {
    return MyRegExp.emailRegex.hasMatch(this).toString(); // String
  }
// double get isDelZeros {
//   return MyRegExp.delZeros.hasMatch(this); // String
// }
}
