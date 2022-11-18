import 'package:flutter/material.dart';
import 'package:flutter_application_1/tabbar/dataPage.dart';
import 'package:flutter_application_1/tabbar/minePage.dart';
import 'package:flutter_application_1/tabbar/squarePage.dart';
import 'package:flutter_application_1/tabbar/taskPage.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class TabbarDiy extends StatefulWidget {
  const TabbarDiy({super.key});

  @override
  State<TabbarDiy> createState() => _TabbarDiyState();
}

class _TabbarDiyState extends State<TabbarDiy> {
  int _currentIndex = 0;
  final List<Widget> _pages = [TaskPage(), DataPage(), SquarePage(), MinePag()];
  @override
  void initState() {
    super.initState();
    _initFluwx();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedFontSize: 12,
        onTap: (value) => setState(
          () => _currentIndex = value,
        ),
        type: BottomNavigationBarType.fixed, // 当tabbar大于等于4个的时候 需要配置
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('images/2.0x/tabbar/home_tn.png', width: 30, height: 30, fit: BoxFit.cover),
              activeIcon: Image.asset('images/2.0x/tabbar/home_tncur.png', width: 30, height: 30, fit: BoxFit.cover),
              label: '任务'),
          BottomNavigationBarItem(
              icon: Image.asset('images/2.0x/tabbar/case_tn.png', width: 30, height: 30, fit: BoxFit.cover),
              activeIcon: Image.asset('images/2.0x/tabbar/case_tncur.png', width: 30, height: 30, fit: BoxFit.cover),
              label: '数据'),
          BottomNavigationBarItem(
              icon: Image.asset('images/2.0x/tabbar/information_tn.png', width: 30, height: 30, fit: BoxFit.cover),
              activeIcon:
                  Image.asset('images/2.0x/tabbar/information_tncur.png', width: 30, height: 30, fit: BoxFit.cover),
              label: '广场'),
          BottomNavigationBarItem(
              icon: Image.asset('images/2.0x/tabbar/my_tn.png', width: 30, height: 30, fit: BoxFit.cover),
              activeIcon: Image.asset('images/2.0x/tabbar/my_tncur.png', width: 30, height: 30, fit: BoxFit.cover),
              label: '我的'),
        ],
      ),
    );
  }
}
