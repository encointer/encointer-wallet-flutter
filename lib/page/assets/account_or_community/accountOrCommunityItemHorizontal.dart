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
        SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () => widget.onAvatarTapped(widget.index),
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: widget.isSelected ? ZurichLion.shade500 : Colors.transparent),
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ZurichLion.shade50,
                  boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x11000000), spreadRadius: 4)]),
              child: widget.itemData.avatar,
            ),
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
