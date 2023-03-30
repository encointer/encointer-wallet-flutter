import 'package:flutter/cupertino.dart';

class CenteredActivityIndicator extends StatelessWidget {
  const CenteredActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.minPositive,
      child: Center(child: CupertinoActivityIndicator()),
    );
  }
}
