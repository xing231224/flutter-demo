import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:flutter_application_1/theme/app_size.dart';
import 'package:flutter_application_1/theme/app_style.dart';

///登录页面剪裁曲线
class LoginClipper extends CustomClipper<Path> {
  // 第一个点
  Point<double> p1 = Point(0.0, 54.0);
  Point<double> c1 = Point(20.0, 25.0);
  Point<double> c2 = Point(81.0, -8.0);
  // 第二个点
  Point<double> p2 = Point(160.0, 20.0);
  Point<double> c3 = Point(216.0, 38.0);
  Point<double> c4 = Point(280.0, 73.0);
  // 第三个点
  Point<double> p3 = Point(280.0, 44.0);
  Point<double> c5 = Point(280.0, -11.0);
  Point<double> c6 = Point(330.0, 8.0);

  @override
  Path getClip(Size size) {
    // 第四个点
    Point<double> p4 = Point(size.width, .0);

    Path path = Path();
    // 移动到第一个点
    path.moveTo(p1.x, p1.y);
    //第一阶段 三阶贝塞尔曲线
    path.cubicTo(c1.x, c1.y, c2.x, c2.y, p2.x, p2.y);
    //第二阶段 三阶贝塞尔曲线
    path.cubicTo(c3.x, c3.y, c4.x, c4.y, p3.x, p3.y);
    //第三阶段 三阶贝塞尔曲线
    path.cubicTo(c5.x, c5.y, c6.x, c6.y, p4.x, p4.y);
    // 连接到右下角
    path.lineTo(size.width, size.height);
    // 连接到左下角
    path.lineTo(0, size.height);
    //闭合
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this.hashCode != oldClipper.hashCode;
  }
}

// 登录按钮
class LoginBtnIconWidget extends StatelessWidget {
  const LoginBtnIconWidget({super.key, required this.onTap});

  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        GradientBtnWidget(
          width: 160,
          child: Center(
            child: BtnTextWhiteWidget(text: 'Login'),
          ),
          onTap: onTap,
        ),
        Spacer(),
      ],
    );
  }
}

// 登入输入框
class LoginInput extends StatelessWidget {
  const LoginInput(
      {super.key, this.hintText, this.prefixIcon, this.obscureText = false, this.controller, this.errorText});
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          errorText: errorText,
          hintText: hintText,
          border: kInputBorder,
          focusedBorder: kInputBorder,
          enabledBorder: kInputBorder,
          prefixIcon: Container(
            width: kIconBoxSize,
            height: kIconBoxSize,
            alignment: Alignment.center,
            child: Icon(
              prefixIcon,
              size: kIconSize,
            ),
          )),
      obscureText: obscureText,
      style: kBodyTextStyle.copyWith(fontSize: 18),
    );
  }
}

class GradientBtnWidget extends StatelessWidget {
  const GradientBtnWidget({
    super.key,
    this.width,
    this.child,
    this.onTap,
  });
  final double? width;
  final Widget? child;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        height: 48,
        decoration: BoxDecoration(
            gradient: kBtnLinearGradient, boxShadow: kBtnShadow, borderRadius: BorderRadius.circular(kBtnRadius)),
        alignment: Alignment.center,
        child: child,
      ),
      onTap: onTap,
    );
  }
}

/// 白色按钮文字
class BtnTextWhiteWidget extends StatelessWidget {
  const BtnTextWhiteWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kBtnTextStyle.copyWith(
        color: Colors.white,
      ),
    );
  }
}

class FabBtnLogin extends StatelessWidget {
  const FabBtnLogin({super.key, this.size = 80, required this.imageUrl, required this.onPressed});
  final double size;
  final String imageUrl;
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
