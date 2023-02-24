import 'package:flutter/cupertino.dart';

class ProgressingIndicator extends StatelessWidget {
  const ProgressingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator());
  }
}
