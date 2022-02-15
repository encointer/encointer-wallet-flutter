import 'package:encointer_wallet/common/components/BorderedTitle.dart';
import 'package:encointer_wallet/common/components/listTail.dart';
import 'package:encointer_wallet/page/assets/receive/receivePage.dart';
import 'package:encointer_wallet/page/assets/transfer/detailPage.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/service/subscan.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/transferData.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AssetPageParams {
  AssetPageParams({@required this.cid, this.communityName, this.communitySymbol});

  final String cid;
  final String communityName;
  final String communitySymbol;
}

class AssetPage extends StatefulWidget {
  AssetPage(this.store);

  static final String route = '/assets/detail';

  final AppStore store;

  @override
  _AssetPageState createState() => _AssetPageState(store);
}

class _AssetPageState extends State<AssetPage> with SingleTickerProviderStateMixin {
  _AssetPageState(this.store);

  final AppStore store;

  bool _loading = false;

  TabController _tabController;
  int _txsPage = 0;
  bool _isLastPage = false;
  ScrollController _scrollController;

  Future<void> _updateData() async {
    if (store.settings.loading || _loading) return;
    setState(() {
      _loading = true;
    });

    webApi.assets.fetchBalance();
    Map res = {"transfers": []};

    res = await webApi.assets.updateTxs(_txsPage);

    if (!mounted) return;
    setState(() {
      _loading = false;
    });

    if (res['transfers'] == null || res['transfers'].length < tx_list_page_size) {
      setState(() {
        _isLastPage = true;
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _txsPage = 0;
      _isLastPage = false;
    });
    await _updateData();
  }

  @override
  void initState() {
    super.initState();
    webApi.encointer.getEncointerBalance();

    _tabController = TabController(vsync: this, length: 3);

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        setState(() {
          if (_tabController.index == 0 && !_isLastPage) {
            _txsPage += 1;
            _updateData();
          }
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Note: Tx list display is currently limited to tx's that were sent on the running device, see:
  /// https://github.com/encointer/encointer-wallet-flutter/issues/54
  List<Widget> _buildTxList() {
    List<Widget> res = [];
    final AssetPageParams params = ModalRoute.of(context).settings.arguments;
    final String cid = params.cid;
    List<TransferData> ls = store.encointer.txsTransfer.reversed.toList();

    ls.retainWhere(
        (i) => i.token.toUpperCase() == cid.toUpperCase() && i.concernsCurrentAccount(store.account.currentAddress));
    res.addAll(ls.map((i) {
      return TransferListItem(
        data: i,
        cid: cid ?? "",
        isOut: i.from == store.account.currentAddress,
        hasDetail: false,
      );
    }));
    res.add(ListTail(
      isEmpty: ls.length == 0,
      isLoading: false,
    ));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final AssetPageParams params = ModalRoute.of(context).settings.arguments;
    final String token = params.cid;

    final titleColor = Theme.of(context).cardColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(params.communitySymbol),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: <Widget>[
                      Text(
                        Fmt.doubleFormat(store.encointer.communityBalance, length: 8),
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: titleColor,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      BorderedTitle(title: I18n.of(context).translationsForLocale().encointer.loanTxs)
                    ],
                  ),
                ),
                store.encointer.txsTransfer.isNotEmpty
                    ? Container(
                        color: titleColor,
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("From/To", style: Theme.of(context).textTheme.headline4),
                            Text("Amount", style: Theme.of(context).textTheme.headline4),
                          ],
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: RefreshIndicator(
                      key: globalAssetRefreshKey,
                      onRefresh: _refreshData,
                      child: ListView(
                        controller: _scrollController,
                        children: _buildTxList(),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        key: Key('transfer'),
                        color: Colors.lightBlue,
                        child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.all(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Image.asset('assets/images/assets/assets_send.png'),
                              ),
                              Text(
                                I18n.of(context).translationsForLocale().assets.transfer,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              TransferPage.route,
                              arguments: TransferPageParams(
                                  redirect: AssetPage.route, symbol: token, communitySymbol: params.communitySymbol),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.lightGreen,
                        child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.all(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Image.asset('assets/images/assets/assets_receive.png'),
                              ),
                              Text(
                                I18n.of(context).translationsForLocale().assets.receive,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, ReceivePage.route);
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class TransferListItem extends StatelessWidget {
  TransferListItem({
    this.data,
    this.cid,
    this.isOut,
    this.hasDetail,
  });

  final TransferData data;
  final String cid;
  final bool isOut;
  final bool hasDetail;

  @override
  Widget build(BuildContext context) {
    String address = isOut ? data.to : data.from;
    String title = Fmt.address(address) ?? data.extrinsicIndex ?? Fmt.address(data.hash);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: ListTile(
        title: Text('$title'),
        subtitle: Text(Fmt.dateTime(DateTime.fromMillisecondsSinceEpoch(data.blockTimestamp * 1000))),
        trailing: Container(
          width: 110,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                '${data.amount} $cid',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.end,
              )),
              isOut
                  ? Image.asset('assets/images/assets/assets_up.png')
                  : Image.asset('assets/images/assets/assets_down.png')
            ],
          ),
        ),
        onTap: hasDetail
            ? () {
                Navigator.pushNamed(context, TransferDetailPage.route, arguments: data);
              }
            : null,
      ),
    );
  }
}
