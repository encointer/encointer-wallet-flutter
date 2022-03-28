import 'package:flutter/material.dart';

import 'AccountOrCommunityData.dart';
import 'accountOrCommunityItemHorizontal.dart';

class SwitchAccountOrCommunity extends StatefulWidget {
  SwitchAccountOrCommunity({
    this.rowTitle,
    this.data,
    this.onTap,
  });

  final String rowTitle;
  final List<AccountOrCommunityData> data;
  final Function onTap;

  @override
  _SwitchAccountOrCommunityState createState() => _SwitchAccountOrCommunityState();
}

class _SwitchAccountOrCommunityState extends State<SwitchAccountOrCommunity> {
  static const double identiconPlusTextHeight = 130;
  static const double itemExtent = 90;
  static const double fadeWidth = 32;
  static const Color whiteTransparent = Color(0x00ffffff);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 15,
      ),
      Center(
        child: Text(
          widget.rowTitle,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      SizedBox(height: 15),
      SizedBox(
        height: identiconPlusTextHeight,
        // otherwise ListView would use infinite height
        child: Stack(
          children: [
            Center(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemExtent: itemExtent,
                itemCount: widget.data != null ? widget.data.length : 0,
                itemBuilder: (context, index) => AccountOrCommunityItemHorizontal(
                  itemData: widget.data[index],
                  index: index,
                  onTap: widget.onTap,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, whiteTransparent],
                      ),
                    ),
                    height: identiconPlusTextHeight,
                    width: fadeWidth),
                Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [whiteTransparent, Colors.white],
                      ),
                    ),
                    height: identiconPlusTextHeight,
                    width: fadeWidth),
              ],
            ),
          ],
        ),
      ),
    ]);
  }
}
