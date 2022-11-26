import 'package:flutter/material.dart';

class AuthModel with ChangeNotifier {
  // 设置初始用户信息
  Map _userInfo = {};

  // 获取用户信息
  Map get userInfo => _userInfo;

  // 设置用户信息 更新状态
  setUserInfo(data) {
    this._userInfo = data;
    notifyListeners();
  }
}
