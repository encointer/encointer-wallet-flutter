import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserOnMap.dart';
import 'package:encointer_wallet/page/account/create/createPinForm.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePinPageParams {
  CreatePinPageParams(this.onCreatePin);

  final Future<void> Function() onCreatePin;
}

class CreatePinPage extends StatefulWidget {
  const CreatePinPage(this.store);

  static const String route = '/account/createPin';
  final AppStore store;

  @override
  _CreatePinPageState createState() => _CreatePinPageState(store);
}

class _CreatePinPageState extends State<CreatePinPage> {
  _CreatePinPageState(this.store);

  final AppStore store;

  Future<void> Function() onCreatePin;

  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    CreatePinPageParams params = ModalRoute.of(context).settings.arguments;

    onCreatePin = params.onCreatePin;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          I18n.of(context).translationsForLocale().home.create,
        ),
        iconTheme: IconThemeData(
          color: encointerGrey, //change your color here
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
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

                  if (store.encointer.communities != null) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CommunityChooserOnMap(store)),
                    );
                  } else {
                    await showNoCommunityDialog(context);
                  }

                  setState(() {
                    _submitting = false;
                  });

                  // Even if we do not choose a community, we go back to the home screen.
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                store: store,
              )
            : Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}

Future<void> showNoCommunityDialog(BuildContext context) {
  var translations = I18n.of(context).translationsForLocale();

  return showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Container(),
        content: Text(translations.encointer.noCommunitiesFoundChooseLater),
        actions: <Widget>[
          CupertinoButton(
            child: Text(translations.home.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
