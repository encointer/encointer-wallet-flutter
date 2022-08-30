import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page/account/create/create_pin_form.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePinPageParams {
  CreatePinPageParams(this.onCreatePin);

  final Future<void> Function() onCreatePin;
}

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({Key? key}) : super(key: key);

  static const String route = '/account/createPin';

  @override
  _CreatePinPageState createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  late Future<void> Function() onCreatePin;

  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    CreatePinPageParams params = ModalRoute.of(context)!.settings.arguments as CreatePinPageParams;
    final _store = context.watch<AppStore>();

    onCreatePin = params.onCreatePin;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          I18n.of(context)!.translationsForLocale().home.create,
        ),
        iconTheme: const IconThemeData(
          color: encointerGrey, //change your color here
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.close,
              color: encointerGrey,
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          )
        ],
      ),
      body: SafeArea(
        child: !_submitting
            ? CreatePinForm(
                onSubmit: () async {
                  setState(() {
                    _submitting = true;
                  });

                  await onCreatePin();

                  if (_store.encointer.communityIdentifiers.length == 1) {
                    _store.encointer.setChosenCid(
                      _store.encointer.communityIdentifiers[0],
                    );
                  } else {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CommunityChooserOnMap(_store)),
                    );
                  }

                  setState(() {
                    _submitting = false;
                  });

                  // Even if we do not choose a community, we go back to the home screen.
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                store: _store,
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
