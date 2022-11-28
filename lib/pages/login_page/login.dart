import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/common/service.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:flutter_application_1/utils/c_log_util.dart';
import 'package:flutter_application_1/utils/local.dart';
import 'package:flutter_application_1/widgets/widget_login.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  var animationStatus = 0;
  var _phone = new TextEditingController();
  var _password = new TextEditingController();
  late AnimationController _loginButtonController;
  String? _errorPhone;
  String? _errorPass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = new AnimationController(duration: Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _authCodeTap() async {
    try {
      LOG.d('------------开始发送验证码');
      return true;
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 250),
                    FormContainer(
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
                          onTap: () {
                            setState(() {
                              animationStatus = 1;
                            });
                            _playAnimation();
                          },
                          child: AnimationBtn(),
                        ),
                      )
                    : new StaggerAnimation(
                        buttonController: _loginButtonController,
                        bottom: 280.0,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void loginBtn() async {
    setState(() {
      if (_phone.text == '') {
        _errorPhone = '手机号不得为空';
        return;
      } else {
        _errorPhone = null;
      }
      if (_password.text == '') {
        _errorPass = '密码不得为空';
        return;
      } else {
        _errorPass = null;
      }
    });
    if (_errorPhone != null || _errorPass != null) return;
    LOG.d('${_phone.text}===================${_password.text}');
    Response data = await LoginApi.loginAuth({"username": _phone.text, "password": _password.text});
    LOG.d('${data}===================data');
  }
}
