import 'package:encointer_wallet/common/components/encointerTextFormField.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'ceremonyProgressBar.dart';

class CeremonyStep1Count extends StatelessWidget {
  CeremonyStep1Count({
    Key key,
  }) : super(key: key);

  final TextEditingController _attendeesCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(dic.encointer.encointerCeremony),
        leading: Container(),
        actions: [
          IconButton(
            key: Key('close-encointer-ceremony-step1'),
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 24, 30, 24),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CeremonyProgressBar(progress: 1),
                    SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: Text(
                        'Count',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: ZurichLion.shade600,
                            ),
                      ),
                    ),
                    Center(
                        child: Text('How many people are attending?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black, height: 2))),
                    SizedBox(
                      height: 48,
                    ),
                    EncointerTextFormField(
                      labelText: dic.encointer.numberOfAttendees,
                      textStyle: Theme.of(context).textTheme.headline1.copyWith(color: encointerBlack),
                      controller: _attendeesCountController,
                      textFormFieldKey: Key('attendees-count'),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.arrow_right_2),
                    SizedBox(width: 12),
                    Text(
                      dic.encointer.next,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            color: ZurichLion.shade50,
                          ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop(int.parse(_attendeesCountController.text.trim()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
