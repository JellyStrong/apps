import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siiimple/view/mainView.dart';

import 'provider/mainViewProviderl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ChangeNotifierProvider(create: (BuildContext context) => MainViewProvider(), child: Siiimple()));
    // ChangeNotifierProvider(
    //   create: (BuildContext context) => FirstPageViewModel(),
    //   child: Siiimple(),
    // ));
  }
}

class Siiimple extends StatelessWidget {
  const Siiimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container(constraints: BoxConstraints(maxWidth: 255, maxHeight: 355), child: MainView())));
  }
}
