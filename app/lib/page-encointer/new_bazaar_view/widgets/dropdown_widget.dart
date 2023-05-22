import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar_view/logic/businesses_store.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  Category selectedCategory = Category.alle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownMenu<Category>(
      initialSelection: Category.alle,
      dropdownMenuEntries: Category.values
          .map(
            (e) => DropdownMenuEntry<Category>(
              value: e,
              label: e.name,
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(textTheme.bodySmall),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          )
          .toList(),
      onSelected: (category) async {
        if (category != null && selectedCategory != category) {
          selectedCategory = category;

          await context.read<BusinessesStore>().getBusinesses(category: selectedCategory);
        }
      },
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFf4f7f8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          constraints: const BoxConstraints(maxHeight: 40)),
      textStyle: textTheme.bodyMedium,
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: encointerGrey,
      ),
    );
  }
}

enum Category {
  alle('Alle'),
  artAndMusic('Art & Music'),
  bodyAndSoul('Body & Soul'),
  fashionAndClothing('Fashion & Clothing'),
  foodAndBeverageStore('Food & Beverage Store'),
  restaurantsAndBars('Restaurants & Bars'),
  neuBeiLeu('Neu bei Leu');

  const Category(
    this.name,
  );
  final String name;
}
