import 'package:flutter/material.dart';

class ScrollableForm extends StatelessWidget {
  const ScrollableForm({
    super.key,
    required this.formKey,
    required this.listViewChildren,
    required this.columnChildren,
  });

  final GlobalKey<FormState> formKey;
  final List<Widget> listViewChildren;
  final List<Widget> columnChildren;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(child: ListView(children: listViewChildren)),
          ...columnChildren,
        ],
      ),
    );
  }
}
