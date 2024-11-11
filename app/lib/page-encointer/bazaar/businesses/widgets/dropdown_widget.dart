import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/custom/colors/app_colors.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/logic/businesses_store.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  Category selectedCategory = Category.all;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Category>(
      initialSelection: Category.all,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFFf4f7f8)),
        shadowColor: WidgetStateProperty.all(context.colorScheme.secondary),
        elevation: WidgetStateProperty.all(40),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      dropdownMenuEntries: Category.values
          .map(
            (e) => DropdownMenuEntry<Category>(
              value: e,
              label: e.name,
              style: ButtonStyle(
                textStyle: WidgetStateProperty.all(context.textTheme.bodySmall),
              ),
            ),
          )
          .toList(),
      onSelected: (category) {
        if (category != null && selectedCategory != category) {
          selectedCategory = category;

          context.read<BusinessesStore>().filterBusinessesByCategory(category: selectedCategory);
        }
      },
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFf4f7f8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.only(left: 18),
        constraints: const BoxConstraints(maxHeight: 40),
      ),
      textStyle: context.textTheme.bodyMedium,
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: AppColors.encointerGrey,
        size: 18,
      ),
      selectedTrailingIcon: const Icon(
        Icons.keyboard_arrow_up_outlined,
        color: AppColors.encointerGrey,
        size: 18,
      ),
    );
  }
}

enum Category {
  @JsonValue('all')
  all('All'),
  @JsonValue('art_music')
  artAndMusic('Art & Music'),
  @JsonValue('body_soul')
  bodyAndSoul('Body & Soul'),
  @JsonValue('fashion_clothing')
  fashionAndClothing('Fashion & Clothing'),
  @JsonValue('food_beverage_store')
  foodAndBeverageStore('Food & Beverage Store'),
  @JsonValue('restaurants_bars')
  restaurantsAndBars('Restaurants & Bars'),
  @JsonValue('food')
  food('Food');

  const Category(this.name);
  final String name;
}
