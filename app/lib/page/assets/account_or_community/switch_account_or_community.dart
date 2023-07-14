import 'package:flutter/material.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_data.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_item_horizontal.dart';
import 'package:encointer_wallet/theme/theme.dart';

class SwitchAccountOrCommunity extends StatefulWidget {
  const SwitchAccountOrCommunity({
    super.key,
    this.rowTitle,
    this.accountOrCommunityData,
    this.onTap,
    required this.onAddIconPressed,
    required this.addIconButtonKey,
  });

  final String? rowTitle;
  final List<AccountOrCommunityData>? accountOrCommunityData;
  final void Function(int index)? onTap;
  final VoidCallback onAddIconPressed;
  final Key addIconButtonKey;

  @override
  State<SwitchAccountOrCommunity> createState() => _SwitchAccountOrCommunityState();
}

class _SwitchAccountOrCommunityState extends State<SwitchAccountOrCommunity> {
  static const double identiconPlusTextHeight = 120;
  static const double itemExtent = 90;
  static const double fadeWidth = 32;
  static const Color whiteTransparent = Color(0x00ffffff);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.rowTitle!,
            style: context.textTheme.displayMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4),
            child: IconButton(
              key: widget.addIconButtonKey,
              onPressed: widget.onAddIconPressed,
              icon: const Icon(
                Icons.add,
                size: 36,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
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
                itemCount: widget.accountOrCommunityData != null ? widget.accountOrCommunityData!.length : 0,
                itemBuilder: (context, index) => AccountOrCommunityItemHorizontal(
                  itemData: widget.accountOrCommunityData![index],
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
