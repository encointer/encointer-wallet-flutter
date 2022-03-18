import 'package:flutter/material.dart';

import 'AccountOrCommunityData.dart';
import 'accountOrCommunityItemHorizontal.dart';

class SwitchAccountOrCommunity extends StatefulWidget {
  SwitchAccountOrCommunity({
    this.rowTitle,
    this.data,
    this.selectedItem,
    this.onAvatarTapped,
  });

  final String rowTitle;
  final List<AccountOrCommunityData> data;
  final int selectedItem;
  final Function onAvatarTapped;

  @override
  _SwitchAccountOrCommunityState createState() => _SwitchAccountOrCommunityState();
}

class _SwitchAccountOrCommunityState extends State<SwitchAccountOrCommunity> {
  static const double identiconPlusTextHeight = 110;
  static const double itemExtent = 90;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Center(
        child: Text(
          widget.rowTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      SizedBox(height: 20),
      SizedBox(
        height: identiconPlusTextHeight,
        // otherwise ListView would use infinite height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: itemExtent,
          itemCount: widget.data != null ? widget.data.length : 0,
          itemBuilder: (context, index) => AccountOrCommunityItemHorizontal(
            itemData: widget.data[index],
            index: index,
            isSelected: index == widget.selectedItem,
            onAvatarTapped: widget.onAvatarTapped,
          ),
        ),
      ),
    ]);
  }
}
