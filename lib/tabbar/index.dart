import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:flutter_application_1/models/tabIcon_data.dart';
import 'package:flutter_application_1/tabbar/data_page/index.dart';
import 'package:flutter_application_1/tabbar/mine_page/index.dart';
import 'package:flutter_application_1/tabbar/square_page/index.dart';
import 'package:flutter_application_1/tabbar/task_page/index.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'components/cancel_button.dart';
import 'widgets/add_task.dart';
import 'dart:ui';

class TabbarDiy extends StatefulWidget {
  const TabbarDiy({super.key});
  @override
  State<TabbarDiy> createState() => _TabbarDiyState();
}

class _TabbarDiyState extends State<TabbarDiy> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );
  @override
  void initState() {
    super.initState();
    _initFluwx();
    _test();
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    tabBody = TaskPage(animationController: animationController);
    super.initState();
  }

  _test() async {
    bool exist = await fluwx.isWeChatInstalled;

    print("object-001");
    if (!exist) {
      print("请先安装微信");
      print("object-002");
    } else {
      print("object-003");
      fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) {
        print("object-004");
        if (res is fluwx.WeChatAuthResponse) {
          print("object-005");
          int? errCode = res.errCode;
          print("登录返回值:errCode:${errCode} code:${res.code}");
          if (errCode == 0) {
            String code = res.code!;
            //需要吧登录返回code传给后台，剩下的事就交给后台处理
            //_presenter.getWeChatAccessToken(code);
            print("用户同意授权成功");
          } else if (errCode == -4) {
            print("用户拒绝授权");
          } else if (errCode == -3) {
            print("用户取消");
          }
          print("object-006");
        }
      });
    }
  }

  // 初始化微信配置
  _initFluwx() async {
    print("这里进来了吗？");
    bool result = await fluwx.registerWxApi(
        appId: 'wxf15c8d316e65375e',
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://your.univerallink.com/link/" // ios 需要配置
        );
    print("微信注册结果1 $result");
    var isInstall = await fluwx.isWeChatInstalled;
    print("是否安装微信 $isInstall");
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 38),
                    child: tabBody,
                  ),
                  bottomBar(context),
                ],
              );
            }
          },
        ),
      ),
    );

    // return Material(
    //   child: Container(
    //     color: AppTheme.background,
    //     child: Scaffold(
    //       backgroundColor: Colors.transparent,
    //       body: FutureBuilder<bool>(
    //         future: getData(),
    //         builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //           if (!snapshot.hasData) {
    //             return const SizedBox();
    //           } else {
    //             return Stack(
    //               children: <Widget>[
    //                 Padding(
    //                   padding: EdgeInsets.fromLTRB(0, 0, 0, 38),
    //                   child: tabBody,
    //                 ),
    //                 bottomBar(context),
    //               ],
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar(context) {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          isLabel: true,
          tabIconsList: tabIconsList,
          addClick: () => showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            backgroundColor: Colors.white,
            builder: (context) => AddTaskWidget(),
          ),
          changeIndex: (int index) {
            animationController?.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                // tabBody = TrainingScreen(animationController: animationController);
                print('tabs-------------------$index');
                switch (index) {
                  case 0:
                    tabBody = TaskPage(animationController: animationController);
                    break;
                  case 1:
                    tabBody = DataPage(animationController: animationController);
                    break;
                  case 2:
                    tabBody = SquarePage(animationController: animationController);
                    break;
                  case 3:
                    tabBody = MinePage(animationController: animationController);
                    break;
                }
              });
            });
          },
        ),
      ],
    );
  }
}
