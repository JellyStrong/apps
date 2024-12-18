class Model {
  double result = 0; //결과값
  double num = 0; // 받는 숫자
  String oo = ''; // 연산자

  Map<String, dynamic> deviceData = <String, dynamic>{};



  /// get ///
  double get getNum => num;

  double get getResult => result;

  Map<String, dynamic> get getDeviceData => deviceData;

  /// set ///
  set setNum(double v) => num = v;

  set setResult(double v) => result = v;

  set setDeviceData(Map<String, dynamic> v) => deviceData = v;
}
