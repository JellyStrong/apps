import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siiimple/util/commonWidget.dart';
import 'provider/calculatorViewProvider.dart';
import 'util/common.dart';
import 'view/macWallPaperView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => CalculatorViewProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => WindowControls(),
        )
      ],
      child: const MaterialApp(
        // initialRoute: '/',
        // routes: MyRoute,
        home: MacWallPaperView(),
        debugShowCheckedModeBanner: false,
        // home: Scaffold(
        //   body: MacWallPaperView(),
        // ),
      ),
    );
  }
}

// class Siiimple extends StatelessWidget {
//   const Siiimple({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Container(constraints: BoxConstraints(maxWidth: 255, maxHeight: 355), child: CalculatorView(context: context,))));
//   }
// }
