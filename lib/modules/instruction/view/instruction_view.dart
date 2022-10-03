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
          const ExpansionTile(
            title: Text('Push notification about meetup'),
            children: <Widget>[
              ListTile(
                title: Text('This is tile number 3'),
                subtitle: Text('This is tile number 3'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAppSettings(),
      ),
    );
  }
}
