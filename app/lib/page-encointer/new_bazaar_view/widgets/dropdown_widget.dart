// import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar_view/logic/businesses_store.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  Category selectedCategory = Category.alle;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Category>(
      initialSelection: Category.alle,
      dropdownMenuEntries: Category.values
          .map(
            (e) => DropdownMenuEntry<Category>(
              value: e,
              label: e.name,
              style: ButtonStyle(
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
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: encointerGrey,
      ),
    );
  }
}

enum Category {
  alle,
  artAndMusic,
  bodyAndSoul,
  fashionAndClothing,
  foodAndBeverageStore,
  restaurantsAndBars,
  neuBeiLeu
}

extension CategoryEntry on Category {
  String get name {
    switch (this) {
      case Category.alle:
        return 'Alle';
      case Category.artAndMusic:
        return 'Art & Music';
      case Category.bodyAndSoul:
        return 'Body & Soul';
      case Category.fashionAndClothing:
        return 'Fashion & Clothing';
      case Category.foodAndBeverageStore:
        return 'Food & Beverage Store';
      case Category.restaurantsAndBars:
        return 'Restaurants & Bars';
      case Category.neuBeiLeu:
        return 'Neu bei Leu';
    }
  }

  bool get enabled => this != Category.neuBeiLeu;
}
