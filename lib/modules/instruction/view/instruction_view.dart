import 'package:flutter/material.dart';

class Instruction extends StatelessWidget {
  const Instruction({Key? key}) : super(key: key);

  static const String route = '/instruction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruction'),
      ),
    );
  }
}
