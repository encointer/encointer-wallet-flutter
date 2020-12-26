import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';

class ApiCantillon {
  ApiCantillon(this.apiRoot)
      : ceremonies = Ceremonies(apiRoot),
        balances = Balances(apiRoot);

  final Api apiRoot;
  final Ceremonies ceremonies;
  final Balances balances;
}

class Ceremonies {
  Ceremonies(this.apiRoot);

  final Api apiRoot;

  Future<int> participantCount(String cid) async {
    return await apiRoot.evalJavascript('worker.getParticipantCount("$cid")');
  }

  Future<int> participantIndex(String cid, String pubKey, String password) async {
    return await apiRoot.evalJavascript('worker.getParticipantIndex("$pubKey", "$cid", "$password")');
  }

  Future<int> meetupIndex(String cid, String pubKey, String password) async {
    return await apiRoot.evalJavascript('worker.getMeetupIndex("$pubKey", "$cid", "$password")');
  }

  Future<List<String>> meetupRegistry(String cid, String pubKey, String password) async {
    List<dynamic> meetupRegistry =
        await apiRoot.evalJavascript('worker.getMeetupRegistry("$pubKey", "$cid", "$password")');
    return meetupRegistry.map((e) => e.toString()).toList();
  }
}

class Balances {
  Balances(this.apiRoot);

  final Api apiRoot;

  Future<BalanceEntry> balance(String cid, String pubKey, String password) async {
    Map<String, dynamic> balance = await apiRoot.evalJavascript('worker.getBalance("$pubKey", "$cid", "$password")');
    return BalanceEntry.fromJson(balance);
  }
}
