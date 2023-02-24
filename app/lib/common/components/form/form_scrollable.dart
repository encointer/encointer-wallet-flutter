import 'package:flutter/material.dart';

class FormScrollable extends StatelessWidget {
  const FormScrollable({
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
