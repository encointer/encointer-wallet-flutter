// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:encointer_wallet/page-encointer/bazaar/1_home/BazaarSearch/bazaarSearchAndFilter.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaarItemData.dart';

class TestCaseBazaarSearch {
  final BazaarItemsWrapper items;
  final String searchQuery;
  final BazaarItemsWrapper expectedOutput;
  final String testDescription;

  TestCaseBazaarSearch(this.items, this.searchQuery, this.expectedOutput, this.testDescription);
}

/// test case for the low level functions
class TestCaseBazaarSearchLowLevelContainsCharSequence {
  final String input;
  final List<String> searchTerms;
  final bool expectedOutput;
  final String testDescription;

  TestCaseBazaarSearchLowLevelContainsCharSequence(
      this.input, this.searchTerms, this.expectedOutput, this.testDescription);
}

/// test case for the low level functions
class TestCaseBazaarSearchLowLevelWord {
  final String input;
  final List<String> searchTerms;
  final bool expectedOutput;
  final String testDescription;

  TestCaseBazaarSearchLowLevelWord(this.input, this.searchTerms, this.expectedOutput, this.testDescription);
}

class TestCaseBazaarFilter {
  final BazaarItemsWrapper rawSearchResults;
  final List<Keyword> keywords;
  final List<DeliveryOption> availableDeliveryOptions;
  final List<UsageState> availableUsageStates;
  final BazaarItemsWrapper expectedOutput;
  final String testDescription;

  TestCaseBazaarFilter(this.rawSearchResults, this.keywords, this.availableDeliveryOptions, this.availableUsageStates,
      this.expectedOutput, this.testDescription);
}

void main() {
  // constants
  final List<TestCaseBazaarSearchLowLevelContainsCharSequence> lowLevelTestCasesCharSequence =
      <TestCaseBazaarSearchLowLevelContainsCharSequence>[
    TestCaseBazaarSearchLowLevelContainsCharSequence(
      "a bone",
      <String>["bone"],
      true,
      "should find the word bone",
    ),
    TestCaseBazaarSearchLowLevelContainsCharSequence(
      "stick and Bone",
      <String>["bone"],
      true,
      "should find the word Bone",
    ),
    TestCaseBazaarSearchLowLevelContainsCharSequence(
      "four trombones",
      <String>["bone"],
      true,
      "should find the sequence bone in trombones",
    ),
    TestCaseBazaarSearchLowLevelContainsCharSequence(
      "four trombones",
      <String>["bone"],
      true,
      "should find the sequence bone in trombones",
    ),
    TestCaseBazaarSearchLowLevelContainsCharSequence(
      "FishBoneBucket",
      <String>["bone"],
      true,
      "pascal case",
    ),
    TestCaseBazaarSearchLowLevelContainsCharSequence(
      "bOne",
      <String>["bone"],
      true,
      "ignoring case",
    ),
  ];

  final List<TestCaseBazaarSearchLowLevelWord> lowLevelTestCasesWord = <TestCaseBazaarSearchLowLevelWord>[
    TestCaseBazaarSearchLowLevelWord(
      "a bone",
      <String>["bone"],
      true,
      "should find the word bone",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "a bone.",
      <String>["bone"],
      true,
      "should find the word bone, even though it is followed by a dot",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "a bone, five.",
      <String>["bone"],
      true,
      "should find the word bone, followed by a comma",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "a BONE",
      <String>["bone"],
      true,
      "should find the word bone, even though it is all caps",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "a BONE",
      <String>["boNE"],
      true,
      "should find the word bone, even though it is all caps, and the search term entered was not all lower case",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "stick and Bone",
      <String>["bone"],
      true,
      "should find the word Bone",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "four trombones",
      <String>["bone"],
      false,
      "should ignore the sequence bone in trombones",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "four trombones",
      <String>["bone"],
      false,
      "should ignore the sequence bone in trombones",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "FishBoneBucket",
      <String>["bone"],
      true,
      "pascal case",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "bOne",
      <String>["bone"],
      false,
      "bump case",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "boneFracture",
      <String>["bone"],
      true,
      "bump case",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "BoneFracture",
      <String>["bone"],
      true,
      "bump case",
    ),
    TestCaseBazaarSearchLowLevelWord(
      "fishBone",
      <String>["bone"],
      true,
      "bump case",
    ),
  ];

  final coopOfferings = <BazaarOfferingData>[
    BazaarOfferingData("coop super card", null, null, null, null, null, null),
    BazaarOfferingData("PaccoOppulent", null, null, null, null, null, null),
  ];
  final coopBusinesses = <BazaarBusinessData>[
    BazaarBusinessData("myCoop", null, null, null, null, null, null),
    BazaarBusinessData("the coOp", null, null, null, null, null, null),
  ];

  final coopOfferingsWord = <BazaarOfferingData>[
    BazaarOfferingData("coop super card", null, null, null, null, null, null),
  ];
  final coopBusinessesWord = <BazaarBusinessData>[
    BazaarBusinessData("myCoop", null, null, null, null, null, null),
  ];

  final nonCoopBusinesses = <BazaarBusinessData>[
    BazaarBusinessData("migros", null, null, null, null, null, null),
    BazaarBusinessData("copy shop", null, null, null, null, null, null),
  ];
  final nonCoopOfferings = <BazaarOfferingData>[
    BazaarOfferingData("car", null, null, null, null, null, null),
    BazaarOfferingData("opaque button", null, null, null, null, null, null),
    BazaarOfferingData("co op", null, null, null, null, null, null),
  ];

  final List<TestCaseBazaarSearch> testCasesIgnoringCase = [
    TestCaseBazaarSearch(
      BazaarItemsWrapper([...coopBusinesses, ...nonCoopBusinesses], [...coopOfferings, ...nonCoopOfferings]),
      "coop",
      BazaarItemsWrapper(coopBusinesses, coopOfferings),
      "items containing the char sequence 'Coop' in their name (ignoring case)",
    ),
  ];

  final List<TestCaseBazaarSearch> testCasesWords = [
    TestCaseBazaarSearch(
      BazaarItemsWrapper([...coopBusinesses, ...nonCoopBusinesses], [...coopOfferings, ...nonCoopOfferings]),
      "coop",
      BazaarItemsWrapper(coopBusinessesWord, coopOfferingsWord),
      "items containing the word 'Coop' in their name",
    ),
  ];

  var rawSearchResultsBusinessesFilteringKeywords = <BazaarBusinessData>[
    BazaarBusinessData("b1", null, <Keyword>[Keyword.winter, Keyword.livingRoom], null, null, null, null),
    BazaarBusinessData("b2", null, <Keyword>[Keyword.summer, Keyword.livingRoom], null, null, null, null),
    BazaarBusinessData(
        "b3", null, <Keyword>[Keyword.cooking, Keyword.food, Keyword.livingRoom], null, null, null, null),
    BazaarBusinessData("b4", null, <Keyword>[Keyword.food], null, null, null, null),
    BazaarBusinessData("b5", null, <Keyword>[Keyword.food, Keyword.summer], null, null, null, null),
  ];

  var rawSearchResultsBusinessesFilteringDeliveryOptions = <BazaarBusinessData>[
    BazaarBusinessData("b1", null, null, null, null, null, null),
  ];
  var rawSearchResultsOfferingsFilteringDeliveryOptions = <BazaarOfferingData>[
    BazaarOfferingData("o1", null, null, null, null, <DeliveryOption>[], null),
    BazaarOfferingData("o2", null, null, null, null, <DeliveryOption>[DeliveryOption.mailOrder], null),
    BazaarOfferingData("o3", null, null, null, null, <DeliveryOption>[DeliveryOption.pickUp], null),
    BazaarOfferingData(
        "o4", null, null, null, null, <DeliveryOption>[DeliveryOption.mailOrder, DeliveryOption.pickUp], null),
  ];

  var rawSearchResultsBusinessesFilteringUsageStates = <BazaarBusinessData>[
    BazaarBusinessData("b1", null, null, null, null, null, null),
  ];
  var rawSearchResultsOfferingsFilteringUsageStates = <BazaarOfferingData>[
    BazaarOfferingData("o1", null, null, null, null, <DeliveryOption>[], <UsageState>[]),
    BazaarOfferingData("o2", null, null, null, null, <DeliveryOption>[], <UsageState>[UsageState.used]),
    BazaarOfferingData("o3", null, null, null, null, <DeliveryOption>[], <UsageState>[UsageState.brandNew]),
    BazaarOfferingData(
      "o4",
      null,
      null,
      null,
      null,
      <DeliveryOption>[],
      <UsageState>[UsageState.used, UsageState.brandNew],
    )
  ];

  final List<TestCaseBazaarFilter> testCasesFilterKeywords = [
    TestCaseBazaarFilter(
      BazaarItemsWrapper(rawSearchResultsBusinessesFilteringKeywords, []),
      <Keyword>[Keyword.summer, Keyword.food],
      <DeliveryOption>[],
      <UsageState>[],
      BazaarItemsWrapper(rawSearchResultsBusinessesFilteringKeywords.sublist(1), []),
      "summer and food",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(rawSearchResultsBusinessesFilteringKeywords, []),
      null,
      <DeliveryOption>[],
      <UsageState>[],
      BazaarItemsWrapper(rawSearchResultsBusinessesFilteringKeywords, []),
      "No keywords constraint (null) -> should pass all",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(rawSearchResultsBusinessesFilteringKeywords, []),
      <Keyword>[],
      <DeliveryOption>[],
      <UsageState>[],
      BazaarItemsWrapper(rawSearchResultsBusinessesFilteringKeywords, []),
      "No keywords constraint (empty list) -> should pass all",
    ),
  ];

  final List<TestCaseBazaarFilter> testCasesFilterDeliveryOptions = [
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringDeliveryOptions,
        rawSearchResultsOfferingsFilteringDeliveryOptions,
      ),
      null,
      null,
      <UsageState>[],
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringDeliveryOptions,
        rawSearchResultsOfferingsFilteringDeliveryOptions,
      ),
      "no delivery option constraint (null) -> should pass all",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringDeliveryOptions,
        rawSearchResultsOfferingsFilteringDeliveryOptions,
      ),
      null,
      <DeliveryOption>[],
      <UsageState>[],
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringDeliveryOptions,
        rawSearchResultsOfferingsFilteringDeliveryOptions,
      ),
      "no delivery option constraint (empty list) -> should pass all",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringDeliveryOptions,
        rawSearchResultsOfferingsFilteringDeliveryOptions,
      ),
      null,
      <DeliveryOption>[DeliveryOption.mailOrder],
      <UsageState>[],
      BazaarItemsWrapper(
        [rawSearchResultsBusinessesFilteringDeliveryOptions[0]],
        [
          rawSearchResultsOfferingsFilteringDeliveryOptions[1],
          ...rawSearchResultsOfferingsFilteringDeliveryOptions.sublist(3),
        ],
      ),
      "mailOrder",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringDeliveryOptions,
        rawSearchResultsOfferingsFilteringDeliveryOptions,
      ),
      null,
      <DeliveryOption>[DeliveryOption.pickUp],
      <UsageState>[],
      BazaarItemsWrapper(
        [rawSearchResultsBusinessesFilteringDeliveryOptions[0]],
        rawSearchResultsOfferingsFilteringDeliveryOptions.sublist(2),
      ),
      "pickUp",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringDeliveryOptions,
        rawSearchResultsOfferingsFilteringDeliveryOptions,
      ),
      null,
      <DeliveryOption>[DeliveryOption.mailOrder, DeliveryOption.pickUp],
      <UsageState>[],
      BazaarItemsWrapper(
        [rawSearchResultsBusinessesFilteringDeliveryOptions[0]],
        rawSearchResultsOfferingsFilteringDeliveryOptions.sublist(1),
      ),
      "mailOrder and pickUp",
    ),
  ];

  final List<TestCaseBazaarFilter> testCasesFilterUsageStates = [
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringUsageStates,
        rawSearchResultsOfferingsFilteringUsageStates,
      ),
      null,
      null,
      null,
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringUsageStates,
        rawSearchResultsOfferingsFilteringUsageStates,
      ),
      "no usage states constraint (null) -> should pass all",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringUsageStates,
        rawSearchResultsOfferingsFilteringUsageStates,
      ),
      null,
      null,
      <UsageState>[],
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringUsageStates,
        rawSearchResultsOfferingsFilteringUsageStates,
      ),
      "no usage states constraint (empty list) -> should pass all",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringUsageStates,
        rawSearchResultsOfferingsFilteringUsageStates,
      ),
      null,
      <DeliveryOption>[],
      <UsageState>[UsageState.used],
      BazaarItemsWrapper(
        [rawSearchResultsBusinessesFilteringUsageStates[0]],
        [rawSearchResultsOfferingsFilteringUsageStates[1], ...rawSearchResultsOfferingsFilteringUsageStates.sublist(3)],
      ),
      "used",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringUsageStates,
        rawSearchResultsOfferingsFilteringUsageStates,
      ),
      null,
      <DeliveryOption>[],
      <UsageState>[UsageState.brandNew],
      BazaarItemsWrapper(
        [rawSearchResultsBusinessesFilteringUsageStates[0]],
        rawSearchResultsOfferingsFilteringUsageStates.sublist(2),
      ),
      "brandNew",
    ),
    TestCaseBazaarFilter(
      BazaarItemsWrapper(
        rawSearchResultsBusinessesFilteringUsageStates,
        rawSearchResultsOfferingsFilteringUsageStates,
      ),
      null,
      <DeliveryOption>[],
      <UsageState>[UsageState.used, UsageState.brandNew],
      BazaarItemsWrapper(
        [rawSearchResultsBusinessesFilteringUsageStates[0]],
        rawSearchResultsOfferingsFilteringUsageStates.sublist(1),
      ),
      "used or brandNew",
    ),
  ];

  lowLevelTestCasesCharSequence.forEach((testCase) {
    test('Should correctly find (ignoring case): ${testCase.testDescription}', () {
      final bazaarSearchAndFilter = BazaarSearchAndFilter(null);

      var actualOutput = bazaarSearchAndFilter.stringContainsIgnoreCase(testCase.input, testCase.searchTerms);

      expect(actualOutput, testCase.expectedOutput);
    });
  });

  lowLevelTestCasesWord.forEach((testCase) {
    test('Should correctly find (words): ${testCase.testDescription}', () {
      final bazaarSearchAndFilter = BazaarSearchAndFilter(null);

      var actualOutput = bazaarSearchAndFilter.stringContainsWords(testCase.input, testCase.searchTerms);

      expect(actualOutput, testCase.expectedOutput);
    });
  });

  testCasesIgnoringCase.forEach((testCase) {
    test('Should correctly find (ignoring case): ${testCase.testDescription}', () {
      final bazaarSearchAndFilter = BazaarSearchAndFilter(testCase.items);

      var actualSearchResults =
          bazaarSearchAndFilter.findItemsContainingIgnoringCase(testCase.searchQuery, SearchDomain.nameOnly);

      expect(actualSearchResults.businesses.length, testCase.expectedOutput.businesses.length);
      expect(actualSearchResults.offerings.length, testCase.expectedOutput.offerings.length);
      compareItems(actualSearchResults, testCase.expectedOutput);
    });
  });

  testCasesWords.forEach((testCase) {
    test('Should correctly find (words): ${testCase.testDescription}', () {
      final bazaarSearchAndFilter = BazaarSearchAndFilter(testCase.items);

      var actualSearchResults =
          bazaarSearchAndFilter.findItemsContainingWords(testCase.searchQuery, SearchDomain.nameOnly);

      expect(actualSearchResults.businesses.length, testCase.expectedOutput.businesses.length);
      expect(actualSearchResults.offerings.length, testCase.expectedOutput.offerings.length);
      compareItems(actualSearchResults, testCase.expectedOutput);
    });
  });

  test('search in title, vs. in both title and description', () {
    final bazaarSearchAndFilter = BazaarSearchAndFilter(
      BazaarItemsWrapper([], <BazaarOfferingData>[
        BazaarOfferingData("loop", "green loop", null, null, null, null, null),
      ]),
    );
    var actualInTitle = bazaarSearchAndFilter.findItemsContainingWords("green", SearchDomain.nameOnly);
    expect(actualInTitle.businesses.length, 0);
    expect(actualInTitle.offerings.length, 0);

    var actualInTitleAndDescription =
        bazaarSearchAndFilter.findItemsContainingWords("green", SearchDomain.nameAndDescription);
    expect(actualInTitleAndDescription.businesses.length, 0);
    expect(actualInTitleAndDescription.offerings.length, 1);
  });

  testCasesFilterKeywords.forEach((testCase) {
    test('Should filter keywords: ${testCase.testDescription}', () {
      final bazaarSearchAndFilter = BazaarSearchAndFilter(null);

      var actualFilteredSearchResults = bazaarSearchAndFilter.filterSearchResults(
        testCase.rawSearchResults,
        testCase.keywords,
        testCase.availableDeliveryOptions,
        testCase.availableUsageStates,
      );

      expect(actualFilteredSearchResults.businesses.length, testCase.expectedOutput.businesses.length);
      expect(actualFilteredSearchResults.offerings.length, testCase.expectedOutput.offerings.length);
      compareItems(actualFilteredSearchResults, testCase.expectedOutput);
    });
  });

  testCasesFilterDeliveryOptions.forEach((testCase) {
    test('Should filter delivery options (criteria for offerings only): ${testCase.testDescription}', () {
      final bazaarSearchAndFilter = BazaarSearchAndFilter(null);

      var actualFilteredSearchResults = bazaarSearchAndFilter.filterSearchResults(
        testCase.rawSearchResults,
        testCase.keywords,
        testCase.availableDeliveryOptions,
        testCase.availableUsageStates,
      );

      expect(actualFilteredSearchResults.businesses.length, testCase.expectedOutput.businesses.length);
      expect(actualFilteredSearchResults.offerings.length, testCase.expectedOutput.offerings.length);
      compareItems(actualFilteredSearchResults, testCase.expectedOutput);
    });
  });

  testCasesFilterUsageStates.forEach((testCase) {
    test('Should filter usage states (criteria for offerings only): ${testCase.testDescription}', () {
      final bazaarSearchAndFilter = BazaarSearchAndFilter(null);

      var actualFilteredSearchResults = bazaarSearchAndFilter.filterSearchResults(
        testCase.rawSearchResults,
        testCase.keywords,
        testCase.availableDeliveryOptions,
        testCase.availableUsageStates,
      );

      expect(actualFilteredSearchResults.businesses.length, testCase.expectedOutput.businesses.length);
      expect(actualFilteredSearchResults.offerings.length, testCase.expectedOutput.offerings.length);
      compareItems(actualFilteredSearchResults, testCase.expectedOutput);
    });
  });
}

void compareItems(BazaarItemsWrapper actualSearchResults, BazaarItemsWrapper expectedOutput) {
  // compare ignoring order, only need it sorted here for comparison.
  final sortRule = (a, b) => "${a.title} +++ ${a.description}".compareTo("${b.title} +++ ${b.description}");
  actualSearchResults.businesses.sort(sortRule);
  expectedOutput.businesses.sort(sortRule);
  for (int i = 0; i < expectedOutput.businesses.length; i++) {
    expect(actualSearchResults.businesses[i].title, expectedOutput.businesses[i].title);
    expect(actualSearchResults.businesses[i].description, expectedOutput.businesses[i].description);
  }
  actualSearchResults.offerings.sort(sortRule);
  expectedOutput.offerings.sort(sortRule);
  for (int i = 0; i < expectedOutput.offerings.length; i++) {
    expect(actualSearchResults.offerings[i].title, expectedOutput.offerings[i].title);
    expect(actualSearchResults.offerings[i].description, expectedOutput.offerings[i].description);
  }
}
