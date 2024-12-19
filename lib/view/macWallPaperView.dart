import 'package:flutter/material.dart';
import 'package:siiimple/util/util.dart';
import 'package:siiimple/util/commonWidget.dart';
import 'calculatorView.dart';
import 'previewView.dart';

class MacWallPaperView extends StatelessWidget {
  const MacWallPaperView({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceInfo().initPlatformState();
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
          //TODO: 현재 시간에 따른 배경 이미지 변경 (예정)
          image: DecorationImage(
            image: AssetImage('assets/image/bg/macOS-Big-Sur-Daylight-Wallpaper_02.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(color: Colors.grey[700], width: DeviceInfo().getWidth(context), height: 40),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconWidget().myApp(
                          context: context,
                          child: calculatorView(context),
                          iconName: '계산기',
                          iconPath: 'assets/image/icon/calculator.png',
                          maxWidth: 233,
                          maxHeight: 323,
                          backGround: Colors.blue,
                        ),
                        IconWidget().myApp(
                          context: context,
                          child: previewView(context),
                          iconName: '미리보기',
                          iconPath: 'assets/image/icon/preview.png',
                          maxWidth: 500,
                          maxHeight: 500,
                          backGround: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey[300],
                ),
                padding: const EdgeInsets.all(9),
                width: 250,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.red,
                      ),
                      width: 50,
                      height: 50,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.purple,
                      ),
                      width: 50,
                      height: 50,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.green,
                      ),
                      width: 50,
                      height: 50,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        color: Colors.orange,
                      ),
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
  }
}
