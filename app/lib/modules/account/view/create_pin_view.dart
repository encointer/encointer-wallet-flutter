import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/utils/format.dart';

class CreatePinView extends StatefulWidget {
  const CreatePinView({super.key});

  static const String route = '/account/createPin';

  @override
  State<CreatePinView> createState() => _CreatePinViewState();
}

class _CreatePinViewState extends State<CreatePinView> {
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final dic = I18n.of(context)!.translationsForLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(dic.home.create),
        actions: const [CloseButton()],
      ),
      body: SafeArea(
        child: !_submitting
            ? CreatePinForm(
                onSubmit: () async {
                  setState(() {
                    _submitting = true;
                  });

                  // await params.onCreatePin();

                  if (store.encointer.communityIdentifiers.length == 1) {
                    await store.encointer.setChosenCid(
                      store.encointer.communityIdentifiers[0],
                    );
                  } else {
                    await Navigator.pushNamed(context, CommunityChooserOnMap.route);
                  }

                  setState(() {
                    _submitting = false;
                  });

                  // Even if we do not choose a community, we go back to the home screen.
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    CupertinoPageRoute<void>(builder: (context) => const EncointerHomePage()),
                    (route) => false,
                  );
                },
                store: store,
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}

class CreatePinForm extends StatefulWidget {
  const CreatePinForm({super.key, required this.store, required this.onSubmit});

  final VoidCallback onSubmit;
  final AppStore store;

  @override
  State<CreatePinForm> createState() => _CreatePinFormState();
}

class _CreatePinFormState extends State<CreatePinForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _pass2Ctrl = TextEditingController();

  @override
  void dispose() {
    _passCtrl.dispose();
    _pass2Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: <Widget>[
                const SizedBox(height: 80),
                Center(
                  child: Text(dic.profile.pinSecure, style: Theme.of(context).textTheme.displayMedium),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      dic.profile.pinHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: encointerBlack,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  key: const Key('create-account-pin'),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                    ),
                    filled: true,
                    fillColor: zurichLion.shade50,
                    hintText: dic.account.createPassword,
                    labelText: dic.account.createPassword,
                  ),
                  controller: _passCtrl,
                  validator: (v) {
                    return Fmt.checkPassword(v!.trim()) ? null : dic.account.createPasswordError;
                  },
                  obscureText: true,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  key: const Key('create-account-pin2'),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                    ),
                    filled: true,
                    //todo define color
                    fillColor: const Color(0xffF4F8F9),
                    hintText: dic.account.createPassword2,
                    labelText: dic.account.createPassword2,
                  ),
                  controller: _pass2Ctrl,
                  obscureText: true,
                  validator: (v) {
                    return _passCtrl.text != v ? dic.account.createPassword2Error : null;
                  },
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.info_outlined),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 250,
                        child: Text(
                          dic.profile.pinInfo,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: encointerGrey,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            key: const Key('create-account-confirm'),
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              child: Text(
                I18n.of(context)!.translationsForLocale().account.create,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: zurichLion.shade50,
                    ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // widget.store.account.setNewAccountPin(_passCtrl.text);

                  widget.store.settings.setPin(_passCtrl.text);

                  widget.onSubmit();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
