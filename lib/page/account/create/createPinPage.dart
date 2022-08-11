import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserOnMap.dart';
import 'package:encointer_wallet/page/account/create/createPinForm.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePinPageParams {
  const CreatePinPageParams(this.onCreatePin);

  final VoidCallback onCreatePin;
}

class CreatePinPage extends StatefulWidget {
  const CreatePinPage();

  static const String route = '/account/createPin';

  @override
  _CreatePinPageState createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)!.settings.arguments as CreatePinPageParams;

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context)!.translationsForLocale().home.create),
        iconTheme: const IconThemeData(color: encointerGrey), //change your color here
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: encointerGrey),
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          ),
        ],
      ),
      body: SafeArea(
        child: !_submitting
            ? CreatePinForm(
                onSubmit: () async {
                  setState(() {
                    _submitting = true;
                  });

                  params.onCreatePin();

                  if (context.read<AppStore>().encointer.communityIdentifiers.length == 1) {
                    context.read<AppStore>().encointer.setChosenCid(
                          context.read<AppStore>().encointer.communityIdentifiers[0],
                        );
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CommunityChooserOnMap(context.read<AppStore>())),
                    );
                  }

                  setState(() {
                    _submitting = false;
                  });

                  // Even if we do not choose a community, we go back to the home screen.
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                store: context.read<AppStore>(),
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
