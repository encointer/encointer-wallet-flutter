import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_data.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_item_horizontal.dart';
import 'package:flutter/material.dart';

class SwitchAccountOrCommunity extends StatefulWidget {
  const SwitchAccountOrCommunity({super.key, this.rowTitle, this.data, this.onTap});

  final String? rowTitle;
  final List<AccountOrCommunityData>? data;
  final void Function(int index)? onTap;

  @override
  State<SwitchAccountOrCommunity> createState() => _SwitchAccountOrCommunityState();
}

class _SwitchAccountOrCommunityState extends State<SwitchAccountOrCommunity> {
  static const double identiconPlusTextHeight = 130;
  static const double itemExtent = 90;
  static const double fadeWidth = 32;
  static const Color whiteTransparent = Color(0x00ffffff);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 15,
      ),
      Center(
        child: Text(
          widget.rowTitle!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      const SizedBox(height: 15),
      SizedBox(
        height: identiconPlusTextHeight,
        // otherwise ListView would use infinite height
        child: Stack(
          children: [
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemExtent: itemExtent,
                itemCount: widget.data != null ? widget.data!.length : 0,
                itemBuilder: (context, index) => AccountOrCommunityItemHorizontal(
                  itemData: widget.data![index],
                  index: index,
                  onTap: widget.onTap,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, whiteTransparent],
                      ),
                    ),
                    height: identiconPlusTextHeight,
                    width: fadeWidth),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [whiteTransparent, Colors.white],
                    ),
                  ),
                  height: identiconPlusTextHeight,
                  width: fadeWidth,
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
