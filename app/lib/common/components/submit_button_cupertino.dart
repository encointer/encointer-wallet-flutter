import 'package:flutter/cupertino.dart';

/// Button that shows a `CupertinoActivityIndicator` within while `onPressed` is executed.
///
/// Useful for sending transactions because it takes a while until we know the result.
///
/// Same as `SubmitButton` but with the style of the secondary button.
class SubmitButtonCupertino extends StatefulWidget {
  const SubmitButtonCupertino({super.key, required this.child, this.onPressed});

  final Widget child;
  final Future<void> Function(BuildContext)? onPressed;

  @override
  State<SubmitButtonCupertino> createState() => _SubmitButtonCupertinoState();
}

class _SubmitButtonCupertinoState extends State<SubmitButtonCupertino> {
  bool _submitting = false;

  Future<void> _onPressed() async {
    setState(() {
      _submitting = true;
    });
    await widget.onPressed!(context);
    setState(() {
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: (!_submitting && widget.onPressed != null) ? _onPressed : null,
      child: !_submitting ? widget.child : const CupertinoActivityIndicator(),
    );
  }
}
