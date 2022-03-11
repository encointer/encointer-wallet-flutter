import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class ConfirmAttendeesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();

    return Scaffold(
        appBar: AppBar(
          title: Text(dic.encointer.encointerCeremony),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).canvasColor,
        body: SafeArea(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dic.encointer.howManyParticipantsShowedUp,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: RoundedCard(
                margin: EdgeInsets.fromLTRB(16, 12, 16, 24),
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: GridView.count(
                  // Create a grid with 2 columns.
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 2,
                  children: List.generate(10, (index) {
                    var value = index + 3;
                    return Center(
                        child: CupertinoButton(
                            key: Key('confirmed-participants-${value.toString()}'),
                            child: Text(value.toString()),
                            onPressed: () {
                              Navigator.of(context).pop(value);
                            }));
                  }),
                ),
              ),
            ),
          ]),
        ));
  }
}
