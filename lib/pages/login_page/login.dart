import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
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
  String loginType = 'login';
  final Map loginMap = {
    'login': LoginForm(),
    "register": '',
  };

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void changeLoginType(String type) {
    print('测试-------------$type');
    setState(() {
      loginType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.maxFinite,
      padding: EdgeInsets.all(32),
      child: Offstage(
        offstage: !(loginType == 'login'),
        child: LoginForm(changeLoginType: changeLoginType),
      ),
    );
  }
}

// 登录 表单
class LoginForm extends StatefulWidget {
  const LoginForm({super.key, this.changeLoginType});
  final changeLoginType;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Text(
          'LOGIN',
          style: TextStyle(fontSize: 25, fontFamily: AppTheme.fontName, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        LoginInput(
          hintText: 'ID / Phone',
          prefixIcon: Icons.account_circle,
        ),
        SizedBox(height: 20),
        LoginInput(
          hintText: 'PassWord',
          prefixIcon: Icons.password,
        ),
        SizedBox(height: 20),
        LoginBtnIconWidget(),
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
                    onPressed: () => {print(22222)},
                  ),
                  FabBtnLogin(
                    imageUrl: "assets/images/2.0x/fab-login/sms.png",
                    onPressed: () => {widget.changeLoginType('ces')},
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
