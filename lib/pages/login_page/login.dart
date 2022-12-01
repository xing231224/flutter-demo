import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/global.dart';
import 'package:flutter_application_1/common/service.dart';
import 'package:flutter_application_1/utils/c_log_util.dart';
import 'package:flutter_application_1/utils/local.dart';
import 'package:flutter_application_1/widgets/widget_login.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  var animationStatus = 0;
  var isPushName = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _formPhoneKey = new GlobalKey<FormFieldState>();
  late AnimationController _loginButtonController;
  late AnimationController _loginPushController;
  final Map<String, TextEditingController> fieldForm = {
    'phone': new TextEditingController(),
    'code': new TextEditingController(),
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = new AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    _loginPushController = new AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    _loginPushController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
    } on TickerCanceled {}
  }

  Future<bool> _authCodeTap() async {
    try {
      LOG.d('------------开始发送验证码');
      final phone = _formPhoneKey.currentState?.validate();
      if (phone != null && phone) {
        return true;
      }
      return false;
    } on TickerCanceled {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/2.0x/fullbg3.png',
                ),
                fit: BoxFit.cover)),
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Positioned(
                  bottom: 0,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Opacity(
                      opacity: .2,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 250),
                    FormContainer(
                      fieldProp: fieldForm,
                      formKey: _formKey,
                      formPhoneKey: _formPhoneKey,
                      authCodeTap: _authCodeTap,
                    ),
                    SignUp(),
                    OtherLogin(),
                  ],
                ),
                animationStatus == 0
                    ? new Padding(
                        padding: EdgeInsets.only(bottom: 280.0),
                        child: InkWell(
                          onTap: loginSubmit,
                          child: AnimationBtn(),
                        ),
                      )
                    : new StaggerAnimation(
                        buttonController: _loginButtonController,
                        isPushName: isPushName,
                        pushController: _loginPushController,
                        bottom: 280.0,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 登录
  void loginSubmit() async {
    final form = _formKey.currentState?.validate();
    if (form != null && form) {
      setState(() {
        animationStatus = 1;
      });
      _playAnimation();
      final phone = fieldForm['phone']?.text;
      final code = fieldForm['code']?.text;
      Response data = await LoginApi.loginAuth({"phone": phone, "code": code});
      if (!data.data.toString().isEmpty) {
        LOG.d('返回的数据 ===== ${data.data['access_token']}');
        // 存本地 全局;
        Global.accessToken = data.data['access_token'];
        final a = await SPrefsUtil().accessToken.setValue(data.data['access_token']);
        final b = await SPrefsUtil().loginInfo.setValue(json.encode(data.data));
        print('是否存本地============== ${a}');
        if (a && b) {
          setState(() {
            isPushName = true;
          });
          _loginPushController.forward();
        }
      }
    }
  }
}
