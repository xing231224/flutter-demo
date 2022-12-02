import 'package:flutter/cupertino.dart'; // 跳转风格
import 'package:flutter_application_1/common/global.dart';
import 'package:flutter_application_1/fitness_app/fitness_app_home_screen.dart';
import 'package:flutter_application_1/pages/login_page/login.dart';
import 'package:flutter_application_1/tabbar/index.dart';
import 'package:flutter_application_1/utils/c_log_util.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final Map<String, Function> routes = {
  "/": (context) => const TabbarDiy(),
  "/login": (context) => const LoginPage(),
  "/test": (context) => FitnessAppHomeScreen(),
};

var onGenerateRoute = (RouteSettings settings) {
  LOG.d('路由==========${settings.name}');

  LOG.d('登录状态==========${Global.accessToken}');
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (Global.accessToken == null || Global.accessToken!.isEmpty) {
      final Route route = CupertinoPageRoute(builder: (context) => routes['/login']!(context));
      return route;
    }
    if (settings.arguments != null) {
      LOG.d('111');
      final Route route =
          MaterialWithModalsPageRoute(builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      LOG.d('222');
      final Route route = MaterialWithModalsPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
