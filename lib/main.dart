import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/calculatorViewProvider.dart';
import 'util/util.dart';
import 'view/macWallPaperView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ),
    );
  }
}
