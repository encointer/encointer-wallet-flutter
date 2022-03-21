import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

import 'AccountOrCommunityData.dart';

class AccountOrCommunityItemHorizontal extends StatefulWidget {
  final AccountOrCommunityData itemData;
  final int index;
  final Function onAvatarTapped;
  final bool isSelected;

  const AccountOrCommunityItemHorizontal({
    Key key,
    @required this.itemData,
    @required this.index,
    @required this.onAvatarTapped,
    @required this.isSelected,
  }) : super(key: key);

  @override
  _AccountOrCommunityItemHorizontalState createState() => _AccountOrCommunityItemHorizontalState();
}

class _AccountOrCommunityItemHorizontalState extends State<AccountOrCommunityItemHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => widget.onAvatarTapped(widget.index),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: widget.isSelected ? ZurichLion.shade500 : Colors.transparent),
            ),
            child: widget.itemData.avatar,
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.itemData.name,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
