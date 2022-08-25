import "package:latlong2/latlong.dart";
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/businesses_on_map.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_horizontal.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class BusinessDetail extends StatelessWidget {
  BusinessDetail(this.business, {Key? key}) : super(key: key);
  final BazaarBusinessData? business;
  final double cardHeight = 200;
  final double cardWidth = 160;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("${business!.title}"),
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
                    child: Text("${business!.description}"),
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
                          dataRowHeight: 32,
                          rows: List<DataRow>.generate(
                            7,
                            (int index) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Container(width: 30, child: Text(business!.openingHours.getDayString(index))),
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
  const SmallLeaflet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 257,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(47.389712, 8.517076),
              zoom: 15.0,
              maxZoom: 18.4,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 20.0,
                    height: 20.0,
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
                  MaterialPageRoute(
                    builder: (context) => BusinessesOnMap(),
                  ))
            },
            child: const Icon(Icons.fullscreen, size: 40),
          ),
        )
      ],
    );
  }
}
