import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class LoginCopy extends StatelessWidget {
  const LoginCopy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          new Positioned(
            child: Container(
              height: 82,
              // padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0.0, 0.0), //阴影y轴偏移量
                      blurRadius: 6, //阴影模糊程度
                      spreadRadius: 0 //阴影扩散程度
                      )
                ],
                image:
                    DecorationImage(image: (AssetImage("assets/images/2.0x/title_bg/title22.png")), fit: BoxFit.cover),
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                  Expanded(flex: 1, child: Center(child: Text('一键授权', style: TextStyle(fontSize: 18)))),
                  SizedBox(width: 60)
                ],
              ),
            ),
          ),
          new Center(
            child: SizedBox(
              width: 240,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Image.asset(
                  "assets/images/2.0x/login/weixin.png",
                  fit: BoxFit.cover,
                ),
                onPressed: () => {
                  //微信登录授权
                  fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: 'wechat_sdk_demo_test').then((value) {
                    print(value);
                  }).catchError((e) {
                    print('weChatLogin e $e');
                  })
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
