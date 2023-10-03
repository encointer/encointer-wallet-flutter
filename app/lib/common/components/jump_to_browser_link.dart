import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

class JumpToBrowserLink extends StatefulWidget {
  const JumpToBrowserLink(this.url, {super.key, this.text, this.mainAxisAlignment});

  final String? text;
  final String? url;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  State<JumpToBrowserLink> createState() => _JumpToBrowserLinkState();
}

class _JumpToBrowserLinkState extends State<JumpToBrowserLink> {
  bool _loading = false;

  Future<void> _launchUrl() async {
    if (_loading) return;
    setState(() {
      _loading = true;
    });
    await AppLaunch.launchURL(widget.url!);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Text(
              widget.text ?? widget.url!,
              style: TextStyle(color: context.colorScheme.primary),
            ),
          ),
          Icon(Icons.open_in_new, size: 16, color: context.colorScheme.primary)
        ],
      ),
    );
  }
}
