import 'package:flutter/cupertino.dart';

class CenteredActivityIndicator extends StatelessWidget {
  const CenteredActivityIndicator({super.key, this.radius = 10});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(radius: radius),
    );
  }
}
