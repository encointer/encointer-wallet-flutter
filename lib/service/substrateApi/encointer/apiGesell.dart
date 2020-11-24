import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';

class ApiGesell {
  ApiGesell(this.apiRoot)
      : ceremonies = Ceremonies(apiRoot),
        balances = Balances(apiRoot);

  final Api apiRoot;
  final Ceremonies ceremonies;
  final Balances balances;
}

class Ceremonies {
  Ceremonies(this.apiRoot);

  final Api apiRoot;

  Future<int> participantIndex(String cid, int cIndex, String pubKey) async {
    return await apiRoot.evalJavascript('encointer.getParticipantIndex("$cid", "$cIndex" ,"$pubKey")');
  }
}

class Balances {
  Balances(this.apiRoot);

  final Api apiRoot;

  Future<BalanceEntry> balance(String cid, String pubKey) async {
    Map<String, dynamic> balance = await apiRoot.evalJavascript('encointer.getBalance("$cid", "$pubKey")');
    return BalanceEntry.fromJson(balance);
  }
}
