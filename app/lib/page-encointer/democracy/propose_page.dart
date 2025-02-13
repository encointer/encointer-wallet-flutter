import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:flutter/material.dart';
// import 'package:encointer_wallet/store/app.dart';
// import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ProposePage extends StatefulWidget {
  const ProposePage({super.key});

  static const String route = '/propose';

  @override
  State<ProposePage> createState() => _ProposePageState();
}

class _ProposePageState extends State<ProposePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final store = context.read<AppStore>();
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.proposalNew),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () => AppLaunch.launchURL('https://book.encointer.org/protocol-democracy.html'),
              child: Text(
                l10n.democracyFaq,
                style: TextStyle(decoration: TextDecoration.underline, color: context.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => AppLaunch.launchURL(
                  'https://forum.encointer.org/t/deliberation-for-encointer-democracy-proposals/126'),
              child: Text(
                l10n.democracyDiscussion,
                style: TextStyle(decoration: TextDecoration.underline, color: context.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
