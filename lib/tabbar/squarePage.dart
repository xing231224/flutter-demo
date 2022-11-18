import 'package:flutter/material.dart';

class SquarePage extends StatelessWidget {
  const SquarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('广场'),
      ),
    );
    ;
  }
}
