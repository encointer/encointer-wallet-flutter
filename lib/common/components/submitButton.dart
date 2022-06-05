import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Button that shows a `CupertinoActivity` indicator within while `onPressed` is executed.
///
/// Useful for sending transactions because it takes a while until we know the result.
class SubmitButton extends StatefulWidget {
  const SubmitButton({
    Key key,
    this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Future<void> Function(BuildContext) onPressed;

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _submitting = false;

  Future<void> _onPressed() async {
    setState(() {
      _submitting = true;
    });
    await widget.onPressed(context);
    setState(() {
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      child: !_submitting ? widget.child : CupertinoActivityIndicator(),
      onPressed: !_submitting ? () => _onPressed() : null,
    );
  }
}
