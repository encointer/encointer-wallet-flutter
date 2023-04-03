import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_data.dart';

class AccountOrCommunityItemHorizontal extends StatefulWidget {
  const AccountOrCommunityItemHorizontal({
    super.key,
    required this.itemData,
    required this.index,
    required this.onTap,
  });

  final AccountOrCommunityData itemData;
  final int index;
  final void Function(int index)? onTap;

  @override
  State<AccountOrCommunityItemHorizontal> createState() => _AccountOrCommunityItemHorizontalState();
}

class _AccountOrCommunityItemHorizontalState extends State<AccountOrCommunityItemHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => widget.onTap!(widget.index),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: widget.itemData.isSelected ? zurichLion.shade500 : Colors.transparent,
              ),
            ),
            child: widget.itemData.avatar,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            widget.itemData.name ?? '',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
