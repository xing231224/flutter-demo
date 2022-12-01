import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:flutter_application_1/models/tabIcon_data.dart';
import 'package:flutter_application_1/tabbar/data_page/index.dart';
import 'package:flutter_application_1/tabbar/mine_page/index.dart';
import 'package:flutter_application_1/tabbar/square_page/index.dart';
import 'package:flutter_application_1/tabbar/task_page/index.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
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
  AnimationController? animationBtnController;
  Duration animationDuration = Duration(milliseconds: 270);

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );
  bool isHidden = true;
  late Animation<double> containerSize;
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
    animationBtnController = AnimationController(vsync: this, duration: animationDuration);
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
    print(1111111);
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
    animationBtnController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double defaultSize = size.height - (size.height * 0.2);
    double defaultSize = size.height - (size.height * 0.1);
    containerSize = Tween<double>(begin: size.height * 0.1, end: defaultSize)
        .animate(CurvedAnimation(parent: animationBtnController!, curve: Curves.linear));
    return Container(
      color: AppTheme.background,
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
                  bottomBar(),
                  CancelButton(
                    isHidden: isHidden,
                    animationDuration: animationDuration,
                    size: size,
                    animationController: animationBtnController,
                    tapEvent: isHidden
                        ? null
                        : () {
                            // returning null to disable the button
                            animationBtnController!.reverse();
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                  ),
                  AnimatedBuilder(
                    animation: animationBtnController!,
                    builder: (context, child) {
                      if (!isHidden) {
                        return buildRegisterContainer();
                      }
                      // Returning empty container to hide the widget
                      return Container();
                    },
                  ),
                  AddTaskWidget(
                      isHidden: isHidden, animationDuration: animationDuration, size: size, defaultSize: defaultSize)
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          isLabel: true,
          tabIconsList: tabIconsList,
          addClick: handleAddTask,
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

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.black12,
          //       offset: Offset(0.0, 1.0), //阴影xy轴偏移量
          //       blurRadius: 1.0, //阴影模糊程度
          //       spreadRadius: 1.0 //阴影扩散程度
          //       )
          // ],
          color: Colors.white30,
        ),
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Opacity(
            opacity: 0.1,
          ),
        ),
      ),
    );
  }

  // 创建任务
  handleAddTask() {
    setState(() {
      isHidden = false;
    });
    animationBtnController!.forward();
  }
}
