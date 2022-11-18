import 'package:flutter/material.dart';

class MinePag extends StatelessWidget {
  const MinePag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('我的'),
      ),
    );
  }
}
