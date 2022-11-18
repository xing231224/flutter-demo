import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/routes/routes.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

void main() {
  if (Platform.isAndroid) {
    // 设置Appbar上面的电池显示的状态栏的背景与颜色
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // SystemChrome.setEnabledSystemUIOverlays([]); //隐藏状态栏
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '自定义底部导航',
      // theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
