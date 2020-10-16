import 'package:flutter/material.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
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

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;

    return Scaffold(
      appBar: AppBar(
        title: Text(dic['ceremony']),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Stack(
        children: <Widget>[
          SafeArea(
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
                RoundedCard(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${dic['next.step']}: $onForwardText",
                      ),
                      RoundedButton(
                        text: "${dic['continue']}",
                        onPressed: onForward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: RoundedButton(
              text: dic['go.back'],
              onPressed: onBackward,
            ),
          )
        ],
      ),
    );
  }
}
