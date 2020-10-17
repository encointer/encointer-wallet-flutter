import 'package:flutter/material.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class StateMachineWidget extends StatelessWidget {
  StateMachineWidget({
    Key key,
    @required this.otherMeetupRegistryIndex,
    @required this.otherParty,
    @required this.onBackward,
    @required this.onForwardText,
    @required this.onForward,
  }) : super(key: key);

  final int otherMeetupRegistryIndex;
  final String otherParty;

  final Function onBackward;
  final String onForwardText;
  final Function onForward;

  static const backButtonKey = Key("back");
  static const nextButtonKey = Key("next");

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;

    return Scaffold(
      appBar: AppBar(
        title: Text(dic['ceremony']),
        centerTitle: true,
        leading: new IconButton(
          key: backButtonKey,
          icon: new Icon(Icons.arrow_back),
          onPressed: onBackward,
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            RoundedCard(
              // margin: EdgeInsets.fromLTRB(16, 4, 16, 16),
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    "${dic['attestation.performing.with']}:",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    "${Fmt.address(otherParty)}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            SizedBox(width: double.infinity, height: 12),
            RoundedCard(
              child: ListTile(
                title: Text(
                  "${dic['next.step']}: $onForwardText",
                ),
                trailing: IconButton(
                  key: nextButtonKey,
                  icon: new Icon(Icons.navigate_next),
                  onPressed: onForward,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
