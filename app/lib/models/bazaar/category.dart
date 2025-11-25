import 'package:ew_l10n/l10n.dart';
import 'package:flutter/material.dart';

enum Category {
  all('all', 'All', 'category_all'),
  artAndMusic('art_music', 'Art & Music', 'category_art_music'),
  bodyAndSoul('body_soul', 'Body & Soul', 'category_body_soul'),
  fashionAndClothing('fashion_clothing', 'Fashion & Clothing', 'category_fashion_clothing'),
  foodAndBeverageStore('food_beverage_store', 'Food & Beverage Store', 'category_food_beverage_store'),
  restaurantsAndBars('restaurants_bars', 'Restaurants & Bars', 'category_restaurants_bars'),
  iTHardware('it_hardware', 'IT Hardware', 'category_it_hardware'),
  food('food', 'Food', 'category_food'),
  other('other', 'Other', 'category_other');

  const Category(this.jsonKey, this.defaultLabel, this.localizationKey);

  /// The canonical backend value, used in JSON.
  final String jsonKey;

  /// Default English name for display if localization not available.
  final String defaultLabel;

  /// The localization key, e.g. "category_food".
  final String localizationKey;

  /// Utility for reverse lookup.
  static Category fromJsonKey(String key) {
    for (final c in Category.values) {
      if (c.jsonKey == key) return c;
    }
    return Category.other;
  }
}

extension CategoryLocalization on Category {
  String localized(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case Category.all:
        return l10n.category_all;
      case Category.artAndMusic:
        return l10n.category_art_music;
      case Category.bodyAndSoul:
        return l10n.category_body_soul;
      case Category.fashionAndClothing:
        return l10n.category_fashion_clothing;
      case Category.foodAndBeverageStore:
        return l10n.category_food_beverage_store;
      case Category.restaurantsAndBars:
        return l10n.category_restaurants_bars;
      case Category.iTHardware:
        return l10n.category_it_hardware;
      case Category.food:
        return l10n.category_food;
      case Category.other:
        return l10n.category_other;
    }
  }
}
