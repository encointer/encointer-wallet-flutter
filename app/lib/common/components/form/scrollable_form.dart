import 'package:flutter/material.dart';

class ScrollableForm extends StatelessWidget {
  const ScrollableForm({
    super.key,
    required this.formKey,
    required this.listViewChildren,
    required this.columnChildren,
    this.listViewKey,
  });

  final GlobalKey<FormState> formKey;
  final List<Widget> listViewChildren;
  final List<Widget> columnChildren;
  final Key? listViewKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(child: ListView(key: listViewKey, children: listViewChildren)),
          ...columnChildren,
        ],
      ),
    );
  }
}
