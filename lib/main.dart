import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'model/deviceInfo.dart';
import 'provider/calculatorViewProvider.dart';
import 'util/util.dart';
import 'view/macWallPaperView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DeviceInfoDataAdapter()); // 어댑터 등록
  Box<DeviceInfoData> box = await Hive.openBox<DeviceInfoData>('deviceInfoBox');
  runApp(RunApp(box: box));
}

/// 디바이스 정보 Box 어댑터에 저장
void saveDeviceInfoData(BuildContext context, Box<DeviceInfoData> box) async {
  DeviceInfo().getDeviceInfo(context).then((result) async {
    // var box = await Hive.openBox<DeviceInfoData>('deviceInfoBox');
    var device = DeviceInfoData(model: result['model']);
    await box.put('model', device);
  });
}

Future<void> getAllDeviceInfo() async {
  var box = await Hive.openBox<DeviceInfo>('deviceInfoBox');


}

class RunApp extends StatefulWidget {
  RunApp({super.key, required this.box});

  Box<DeviceInfoData> box;

  @override
  State<RunApp> createState() => _RuntAppState();
}

class _RuntAppState extends State<RunApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    saveDeviceInfoData(context, widget.box);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.box.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); // 상태바 숨기기
    // 상태바 보이기
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => CalculatorViewProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => WindowControls(),
        ),
        // ChangeNotifierProvider(create: (BuildContext context)=> ),
      ],
      child: const MaterialApp(
        // initialRoute: '/',
        // routes: MyRoute,
        home: MacWallPaperView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
