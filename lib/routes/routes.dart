import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // 跳转风格
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/tabbar/index.dart';

final Map<String, Function> routes = {
  "/": (context) => const TabbarDiy(),
  "/login": (context) => const Login(),
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route =
          CupertinoPageRoute(builder: (context) => pageContentBuilder(context, arguments: settings.arguments));

      return route;
    } else {
      final Route route = CupertinoPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
