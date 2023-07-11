import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:encointer_wallet/models/bazaar/businesses.dart';

class BusinessesCard extends StatelessWidget {
  const BusinessesCard({super.key, required this.businesses});

  final Businesses businesses;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (businesses.logo != null)
            Image.network(
              businesses.logo!,
              fit: BoxFit.fitHeight,
              height: 120,
            ),
          Expanded(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(businesses.category.name, style: textTheme.bodySmall)),
                  Text(
                    businesses.status?.name ?? '',
                    style: textTheme.bodySmall!.copyWith(color: businesses.status?.textColor ?? Colors.black),
                  )
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  Text(utf8convert(businesses.name), style: textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Text(utf8convert(businesses.description), style: textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// To display, correctly, german names coming from server
  String utf8convert(String text) {
    final bytes = text.codeUnits;
    return utf8.decode(bytes);
  }
}
