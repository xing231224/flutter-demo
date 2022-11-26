import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/c_log_util.dart';
import 'package:flutter_application_1/utils/local.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static late SharedPreferences prefs;
  // 同步获取数据
  // static bool? getIsLogin;
  // static String? getAuthToken;
  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    // getIsLogin = await SPrefsUtil().isLogin.getValue();
    // getAuthToken = await SPrefsUtil().authToken.getValue();
    return true;
  }
}

// class ProfileChangeNotifier extends ChangeNotifier {
//   bool? get _isLogin => Global.getIsLogin;

//   @override
//   void notifyListeners() {
//     // Global.saveProfile(); //保存Profile变更
//     super.notifyListeners(); //通知依赖的Widget更新
//   }
// }
