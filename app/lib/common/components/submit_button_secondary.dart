import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:flutter/cupertino.dart';

/// Button that shows a `CupertinoActivityIndicator` within while `onPressed` is executed.
///
/// Useful for sending transactions because it takes a while until we know the result.
///
/// Same as `SubmitButton` but with the style of the secondary button.
class SubmitButtonSecondary extends StatefulWidget {
  const SubmitButtonSecondary({super.key, required this.child, this.onPressed});

  final Widget child;
  final Future<void> Function(BuildContext)? onPressed;

  @override
  State<SubmitButtonSecondary> createState() => _SubmitButtonSecondaryState();
}

class _SubmitButtonSecondaryState extends State<SubmitButtonSecondary> {
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
    return SecondaryButtonWide(
      onPressed: (!_submitting && widget.onPressed != null) ? _onPressed : null,
      child: !_submitting ? widget.child : const CupertinoActivityIndicator(),
    );
  }
}
