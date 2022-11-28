import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            child: BtnTextWhiteWidget(text: '登录'),
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

// 渐变按钮
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

// 浮动（图片）按钮
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

// 动画按钮
class AnimationBtn extends StatelessWidget {
  const AnimationBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320.0,
        height: 60.0,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          // color: const Color.fromRGBO(247, 64, 106, 1.0),
          gradient: kBtnLinearGradient,
          borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
        ),
        child: new Text(
          "登 录",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// 全屏动画
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key? key, required this.buttonController, this.bottom = 0.0})
      : buttonSqueezeanimation = new Tween(
          begin: 320.0,
          end: 70.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        // buttomZoomOut = new Tween(begin: 70.0, end: 1000.0).animate(
        //   new CurvedAnimation(
        //     parent: buttonController,
        //     curve: new Interval(0.550, 0.999, curve: Curves.bounceOut),
        //   ),
        // ),
        // containerCircleAnimation = new EdgeInsetsTween(
        //   begin: EdgeInsets.only(bottom: bottom),
        //   end: EdgeInsets.only(bottom: 0.0),
        // ).animate(
        //   new CurvedAnimation(
        //     parent: buttonController,
        //     curve: new Interval(
        //       0.500,
        //       0.800,
        //       curve: Curves.ease,
        //     ),
        //   ),
        // ),
        super(key: key);
  final double bottom;
  final AnimationController buttonController;
  final Animation buttonSqueezeanimation;
  // final Animation<EdgeInsets> containerCircleAnimation;
  // final Animation buttomZoomOut;

  final bool ces = false;

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
      // await buttonController.reverse();
    } on TickerCanceled {}
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return new Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: new InkWell(
        onTap: () {
          _playAnimation();
        },
        child: new Hero(
            tag: "fade",
            child: new Container(
                width: buttonSqueezeanimation.value,
                height: 60.0,
                alignment: FractionalOffset.center,
                decoration: new BoxDecoration(
                    // color: const Color.fromRGBO(247, 64, 106, 1.0),
                    gradient: kBtnLinearGradient,
                    borderRadius: new BorderRadius.all(const Radius.circular(30.0))),
                child: buttonSqueezeanimation.value > 75.0
                    ? new Text(
                        "登 录",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.3,
                        ),
                      )
                    : new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 1.0,
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                      ))),
      ),
    );

    // return new Padding(
    //   padding: buttomZoomOut.value == 70 ? EdgeInsets.only(bottom: bottom) : containerCircleAnimation.value,
    //   child: new InkWell(
    //     onTap: () {
    //       _playAnimation();
    //     },
    //     child: new Hero(
    //       tag: "fade",
    //       child: buttomZoomOut.value <= 300
    //           ? new Container(
    //               width: buttomZoomOut.value == 70 ? buttonSqueezeanimation.value : buttomZoomOut.value,
    //               height: buttomZoomOut.value == 70 ? 60.0 : buttomZoomOut.value,
    //               alignment: FractionalOffset.center,
    //               decoration: new BoxDecoration(
    //                 // color: const Color.fromRGBO(247, 64, 106, 1.0),
    //                 gradient: kBtnLinearGradient,
    //                 borderRadius: buttomZoomOut.value < 400
    //                     ? new BorderRadius.all(const Radius.circular(30.0))
    //                     : new BorderRadius.all(const Radius.circular(0.0)),
    //               ),
    //               child: buttonSqueezeanimation.value > 75.0
    //                   ? new Text(
    //                       "登 录",
    //                       style: new TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 20.0,
    //                         fontWeight: FontWeight.w300,
    //                         letterSpacing: 0.3,
    //                       ),
    //                     )
    //                   : buttomZoomOut.value < 300.0
    //                       ? new CircularProgressIndicator(
    //                           value: null,
    //                           strokeWidth: 1.0,
    //                           valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
    //                         )
    //                       : null)
    //           : new Container(
    //               width: buttomZoomOut.value,
    //               height: buttomZoomOut.value,
    //               decoration: new BoxDecoration(
    //                 shape: buttomZoomOut.value < 500 ? BoxShape.circle : BoxShape.rectangle,
    //                 // color: const Color.fromRGBO(247, 64, 106, 1.0),
    //                 gradient: kBtnLinearGradient,
    //               ),
    //             ),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      if (buttonController.isCompleted) {
        // Navigator.pushNamed(context, "/");
      }
    });
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}

class InputFieldArea extends StatelessWidget {
  final String? hint;
  final bool obscure;
  final IconData? icon;
  InputFieldArea({this.hint, this.obscure = false, this.icon});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            // color: Colors.white24,
          ),
        ),
      ),
      child: new TextFormField(
        obscureText: obscure,
        style: const TextStyle(
            // color: Colors.white,
            ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            // color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            // color: Colors.white,
            fontSize: 15.0,
          ),
          contentPadding: const EdgeInsets.only(top: 20.0, right: 20.0, bottom: 20.0, left: 5.0),
        ),
      ),
    ));
  }
}

class FormContainer extends StatelessWidget {
  const FormContainer({super.key, required this.authCodeTap});
  final Future<bool> Function() authCodeTap;
  @override
  Widget build(BuildContext context) {
    return (new Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new InputFieldArea(
                  hint: "请输入手机号",
                  obscure: false,
                  icon: Icons.phone_android_outlined,
                ),
                SizedBox(height: 20),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InputFieldArea(
                        hint: "验证码",
                        icon: Icons.lock_outline,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GetAuthCode(
                        time: 30,
                        onTap: authCodeTap,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 160.0,
      ),
      child: new Text(
        "Don't have an account? Sign Up",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: new TextStyle(
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
          // color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }
}

// 其他方式登录
class OtherLogin extends StatelessWidget {
  const OtherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 120.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 1,
                child: Divider(height: 1.0, endIndent: 20.0, color: Colors.grey.shade400),
              ),
              Text('其他登录方式'),
              SizedBox(
                width: 100,
                height: 1,
                child: Divider(height: 1.0, indent: 20.0, color: Colors.grey.shade400),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FabBtnLogin(
                imageUrl: "assets/images/2.0x/fab-login/weixin.png",
                onPressed: (() async {}),
              ),
              FabBtnLogin(
                imageUrl: "assets/images/2.0x/fab-login/sms.png",
                onPressed: () => {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 有状态组件 验证码
class GetAuthCode extends StatefulWidget {
  const GetAuthCode({super.key, this.time = 60, required this.onTap});
  final int time;
  final Future<bool> Function() onTap;
  @override
  State<GetAuthCode> createState() => _GetAuthCodeState();
}

class _GetAuthCodeState extends State<GetAuthCode> {
  bool isButtonEnable = true; //按钮初始状态  是否可点击
  String buttonText = '发送验证码'; //初始文本
  int count = 0; //初始倒计时时间
  Timer? timer; //倒计时的计时器
  @override
  void initState() {
    super.initState();
    count = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(overlayColor: MaterialStateProperty.resolveWith((states) {
        return !isButtonEnable ? Colors.transparent : null;
      })),
      onPressed: () async {
        if (isButtonEnable) {
          debugPrint('$isButtonEnable');
          final isTure = await widget.onTap();
          if (isTure) {
            setState(() {
              _buttonClickListen();
            });
          }
        }
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }

  void _buttonClickListen() {
    setState(() {
      if (isButtonEnable) {
        //当按钮可点击时
        isButtonEnable = false; //按钮状态标记
        _initTimer();
      }
    });
  }

  void _initTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          isButtonEnable = true; //按钮可点击
          count = widget.time; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '重新发送(${count}s)'; //更新文本内容
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel(); //销毁计时器
    timer = null;
    super.dispose();
  }
}
