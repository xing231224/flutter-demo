import 'package:flutter/material.dart';

// 分类页显示
class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('任务'),
      ),
      body: Center(
        child: Container(
          child: OutlinedButton(
            child: Text('去登录'),
            onPressed: () => {
              Navigator.pushNamed(context, "/login"),
            },
          ),
        ),
      ),
    );
  }
}
