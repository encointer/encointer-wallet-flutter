import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/businesses_on_map.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_horizontal.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class BusinessDetail extends StatelessWidget {
  const BusinessDetail(this.business, {super.key, this.cardHeight = 200, this.cardWidth = 160});

  final BazaarBusinessData? business;
  final double cardHeight;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(business!.title),
            const SizedBox(
              width: 6,
            ),
            business!.icon
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(padding: const EdgeInsets.all(4), child: business!.image),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 8, 0, 16),
                    child: Text(business!.description),
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 2,
                    child: SmallLeaflet(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(children: [
                      // OpeningHoursTable(business.openingHours),
                      Card(
                        margin: const EdgeInsets.fromLTRB(4, 0, 2, 0),
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text(dic.bazaar.day)),
                            DataColumn(label: Text(dic.bazaar.openningHours))
                          ],
                          headingRowHeight: 32,
                          columnSpacing: 4,
                          horizontalMargin: 8,
                          dataRowMinHeight: 32,
                          rows: List<DataRow>.generate(
                            7,
                            (int index) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  SizedBox(width: 30, child: Text(business!.openingHours.getDayString(index))),
                                ),
                                DataCell(Text(
                                  business!.openingHours.getOpeningHoursFor(index).toString(),
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
              HorizontalBazaarItemList(business!.offerings, dic.bazaar.offerings, cardHeight, cardWidth),
            ],
          ),
        ],
      ),
    );
  }
}

class SmallLeaflet extends StatelessWidget {
  const SmallLeaflet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 257,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(47.389712, 8.517076),
              zoom: 15,
              maxZoom: 18.4,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 20,
                    height: 20,
                    point: LatLng(47.389712, 8.517076),
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => BusinessesOnMap(),
                ),
              )
            },
            child: const Icon(Icons.fullscreen, size: 40),
          ),
        )
      ],
    );
  }
}
