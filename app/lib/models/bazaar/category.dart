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
