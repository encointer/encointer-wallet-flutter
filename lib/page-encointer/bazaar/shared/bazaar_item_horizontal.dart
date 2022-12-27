import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/2_offerings/offering_detail.dart';
import 'package:encointer_wallet/page-encointer/bazaar/3_businesses/business_detail.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';

class HorizontalBazaarItemList extends StatelessWidget {
  const HorizontalBazaarItemList(this.data, this.rowTitle, this.cardHeight, this.cardWidth, {super.key});

  final List<BazaarItemData> data;
  final double cardHeight;
  final String rowTitle;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        rowTitle,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 2),
      ),
      SizedBox(
        height: cardHeight, // otherwise ListView would use infinite height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: cardWidth,
          itemCount: data.length,
          itemBuilder: (context, index) => BazaarItemHorizontal(data: data, index: index),
        ),
      ),
    ]);
  }
}

class BazaarItemHorizontal extends StatelessWidget {
  const BazaarItemHorizontal({super.key, required this.data, required this.index});

  final List<BazaarItemData> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: data[index].cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      )),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => (data[index] is BazaarBusinessData)
                  ? BusinessDetail(data[index] as BazaarBusinessData?)
                  : OfferingDetail(data[index] as BazaarOfferingData),
            ),
          );
        },
        child: Column(children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: _ImageWithOverlaidIcon(data: data, index: index),
          ),
          Text(
            data[index].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              data[index].description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ]),
      ),
    );
  }
}

class _ImageWithOverlaidIcon extends StatelessWidget {
  const _ImageWithOverlaidIcon({required this.data, required this.index});

  final List<BazaarItemData> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(15),
            bottom: Radius.circular(0),
          ),
          child: data[index].image),
      Positioned(
          // opaque background to icon
          right: 0,
          // opaque background to icon
          child: Opacity(
            opacity: .4,
            child: Container(height: 24, width: 24, color: Colors.white),
          )),
      Positioned(right: 0, child: data[index].icon),
    ]);
  }
}
