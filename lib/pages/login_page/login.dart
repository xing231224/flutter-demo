import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/service.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:flutter_application_1/utils/c_log_util.dart';
import 'package:flutter_application_1/utils/local.dart';
import 'package:flutter_application_1/widgets/widget_login.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.background,
      body: Container(
        // color: AppTheme.nearlyDarkBlue,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/2.0x/fullbg3.png',
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(height: 200),
            Expanded(
              child: ClipPath(
                clipper: LoginClipper(),
                // child: LoginBodyWidget(),
                child: Stack(children: [
                  Positioned(
                    bottom: 0,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Opacity(
                        opacity: .8,
                      ),
                    ),
                  ),
                  Positioned(child: LoginBodyWidget())
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({super.key});

  @override
  State<LoginBodyWidget> createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.maxFinite,
      padding: EdgeInsets.all(32),
      child: LoginForm(),
    );
  }
}

// 登录 表单
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _phone = new TextEditingController();
  var _password = new TextEditingController();

  String? _errorPhone;
  String? _errorPass;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Text(
          '登录',
          style: TextStyle(fontSize: 25, fontFamily: AppTheme.fontName, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        LoginInput(
          hintText: 'Phone',
          prefixIcon: Icons.account_circle,
          controller: _phone,
          errorText: _errorPhone,
        ),
        SizedBox(height: 20),
        LoginInput(
          hintText: 'PassWord',
          prefixIcon: Icons.code,
          controller: _password,
          obscureText: true,
          errorText: _errorPass,
        ),
        SizedBox(height: 20),
        // LoginBtnIconWidget(
        //   onTap: loginBtn,
        // ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 1,
                    child: Divider(height: 1.0, endIndent: 20.0, color: kInputBorderColor),
                  ),
                  Text('其他登录方式'),
                  SizedBox(
                    width: 100,
                    height: 1,
                    child: Divider(height: 1.0, indent: 20.0, color: kInputBorderColor),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FabBtnLogin(
                    imageUrl: "assets/images/2.0x/fab-login/weixin.png",
                    onPressed: (() async {
                      // SPrefsUtil().isLogin.setValue(true);
                      // SPrefsUtil().authToken.setValue('123123');
                      print('ok--------${await SPrefsUtil().isLogin.getValue()}');
                    }),
                  ),
                  // FabBtnLogin(
                  //   imageUrl: "assets/images/2.0x/fab-login/sms.png",
                  //   onPressed: () => {},
                  // ),
                ],
              ),
            ],
          ),
        )
      ],
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
