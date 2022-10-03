import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Instruction extends StatelessWidget {
  const Instruction({Key? key}) : super(key: key);

  static const String route = '/instruction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruction'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: const Text('Push notification about meetup'),
            children: <Widget>[
              ListTile(
                title: const Text('This is tile number 3'),
                subtitle: Row(
                  children: [
                    const Text('This is tile number 3'),
                    TextButton(
                      onPressed: () => openAppSettings(),
                      child: const Text('Open App Settings'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
