import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({super.key, this.border, this.margin, this.padding, this.child});

  final BoxBorder? border;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        border: border,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16, // has the effect of softening the shadow
            spreadRadius: 4, // has the effect of extending the shadow
            offset: Offset(
              2, // horizontal, move right 10
              2, // vertical, move down 10
            ),
          )
        ],
      ),
      child: child,
    );
  }
}
