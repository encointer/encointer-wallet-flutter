import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

/// Button that shows a `CupertinoActivityIndicator` within while `onPressed` is executed.
///
/// Useful for sending transactions because it takes a while until we know the result.
class SubmitButton extends StatefulWidget {
  const SubmitButton({super.key, required this.child, this.onPressed});

  final Widget child;
  final Future<void> Function(BuildContext)? onPressed;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
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
    return PrimaryButton(
      onPressed: (!_submitting && widget.onPressed != null) ? _onPressed : null,
      child: !_submitting
          ? widget.child
          : Theme(
              // change theme locally to dark such that the activity indicator appears bright
              data: ThemeData(cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark)),
              child: const CupertinoActivityIndicator()),
    );
  }
}

/// Button that shows a `CupertinoActivityIndicator` within while `onPressed` is executed.
///
/// Useful for sending transactions because it takes a while until we know the result.
class SubmitButtonSmall extends StatefulWidget {
  const SubmitButtonSmall({super.key, required this.child, this.onPressed});

  final Widget child;
  final Future<void> Function(BuildContext)? onPressed;

  @override
  State<SubmitButtonSmall> createState() => _SubmitButtonStateSmall();
}

class _SubmitButtonStateSmall extends State<SubmitButtonSmall> {
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
    return ElevatedButton(
      onPressed: (!_submitting && widget.onPressed != null) ? _onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: Colors.white,
        textStyle: context.titleSmall,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: !_submitting
          ? widget.child
          : Theme(
              // change theme locally to dark such that the activity indicator appears bright
              data: ThemeData(cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark)),
              child: const CupertinoActivityIndicator(),
            ),
    );
  }
}
