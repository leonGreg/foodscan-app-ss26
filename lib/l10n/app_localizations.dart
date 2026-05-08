import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'FoodScan'**
  String get appTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan products to discover nutritional info'**
  String get homeSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search product or barcode...'**
  String get searchHint;

  /// No description provided for @recentScans.
  ///
  /// In en, this message translates to:
  /// **'Recent Scans'**
  String get recentScans;

  /// No description provided for @noRecentScans.
  ///
  /// In en, this message translates to:
  /// **'No recent scans yet'**
  String get noRecentScans;

  /// No description provided for @scanProduct.
  ///
  /// In en, this message translates to:
  /// **'Scan Product'**
  String get scanProduct;

  /// No description provided for @positionBarcode.
  ///
  /// In en, this message translates to:
  /// **'Position barcode within the frame'**
  String get positionBarcode;

  /// No description provided for @enterBarcodeManually.
  ///
  /// In en, this message translates to:
  /// **'Enter Barcode Manually'**
  String get enterBarcodeManually;

  /// No description provided for @enterBarcode.
  ///
  /// In en, this message translates to:
  /// **'Enter Barcode'**
  String get enterBarcode;

  /// No description provided for @barcodeNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter barcode number'**
  String get barcodeNumber;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @searchProduct.
  ///
  /// In en, this message translates to:
  /// **'Search Product'**
  String get searchProduct;

  /// No description provided for @barcodeExample.
  ///
  /// In en, this message translates to:
  /// **'e.g., 3017620422003'**
  String get barcodeExample;

  /// No description provided for @enterBarcodeInstructions.
  ///
  /// In en, this message translates to:
  /// **'Type in the barcode number to search for a product'**
  String get enterBarcodeInstructions;

  /// No description provided for @demoScan.
  ///
  /// In en, this message translates to:
  /// **'Demo Scan (Nutella)'**
  String get demoScan;

  /// No description provided for @overallRating.
  ///
  /// In en, this message translates to:
  /// **'Overall Rating'**
  String get overallRating;

  /// No description provided for @moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// No description provided for @nutriScore.
  ///
  /// In en, this message translates to:
  /// **'Nutri-Score'**
  String get nutriScore;

  /// No description provided for @ecoScore.
  ///
  /// In en, this message translates to:
  /// **'Eco-Score'**
  String get ecoScore;

  /// No description provided for @additives.
  ///
  /// In en, this message translates to:
  /// **'Additives'**
  String get additives;

  /// No description provided for @nutrition.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutrition;

  /// No description provided for @nutritionalValues.
  ///
  /// In en, this message translates to:
  /// **'Nutritional Values'**
  String get nutritionalValues;

  /// No description provided for @energy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get energy;

  /// No description provided for @fat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get fat;

  /// No description provided for @saturatedFat.
  ///
  /// In en, this message translates to:
  /// **'Saturated Fat'**
  String get saturatedFat;

  /// No description provided for @carbohydrates.
  ///
  /// In en, this message translates to:
  /// **'Carbohydrates'**
  String get carbohydrates;

  /// No description provided for @sugars.
  ///
  /// In en, this message translates to:
  /// **'Sugars'**
  String get sugars;

  /// No description provided for @proteins.
  ///
  /// In en, this message translates to:
  /// **'Proteins'**
  String get proteins;

  /// No description provided for @salt.
  ///
  /// In en, this message translates to:
  /// **'Salt'**
  String get salt;

  /// No description provided for @novaGroup.
  ///
  /// In en, this message translates to:
  /// **'NOVA Group'**
  String get novaGroup;

  /// No description provided for @moderateRisk.
  ///
  /// In en, this message translates to:
  /// **'Moderate Risk'**
  String get moderateRisk;

  /// No description provided for @ultraProcessedFoods.
  ///
  /// In en, this message translates to:
  /// **'Ultra-processed foods'**
  String get ultraProcessedFoods;

  /// No description provided for @group4.
  ///
  /// In en, this message translates to:
  /// **'Group 4'**
  String get group4;

  /// No description provided for @aboutNutriScore.
  ///
  /// In en, this message translates to:
  /// **'About Nutri-Score'**
  String get aboutNutriScore;

  /// No description provided for @understandingNutritionalSystem.
  ///
  /// In en, this message translates to:
  /// **'Understanding the nutritional quality rating system'**
  String get understandingNutritionalSystem;

  /// No description provided for @nutriScoreDescription.
  ///
  /// In en, this message translates to:
  /// **'Nutri-Score is a nutrition label that converts the nutritional value of products into a simple code consisting of 5 letters, each with its own color. Each product is awarded a score based on a scientific algorithm.'**
  String get nutriScoreDescription;

  /// No description provided for @thisProductGradeE.
  ///
  /// In en, this message translates to:
  /// **'This Product: Grade E'**
  String get thisProductGradeE;

  /// No description provided for @fruitsVegetablesNuts.
  ///
  /// In en, this message translates to:
  /// **'Fruits, Vegetables, Nuts'**
  String get fruitsVegetablesNuts;

  /// No description provided for @varies.
  ///
  /// In en, this message translates to:
  /// **'Varies'**
  String get varies;

  /// No description provided for @aboutEcoScore.
  ///
  /// In en, this message translates to:
  /// **'About Eco-Score'**
  String get aboutEcoScore;

  /// No description provided for @understandingEnvironmentalSystem.
  ///
  /// In en, this message translates to:
  /// **'Understanding the environmental impact rating system'**
  String get understandingEnvironmentalSystem;

  /// No description provided for @ecoScoreDescription.
  ///
  /// In en, this message translates to:
  /// **'Eco-Score evaluates the environmental impact of food products from A to E. It considers production methods, transportation, packaging, and the impact on biodiversity.'**
  String get ecoScoreDescription;

  /// No description provided for @thisProductGradeUnknown.
  ///
  /// In en, this message translates to:
  /// **'This Product: Grade UNKNOWN'**
  String get thisProductGradeUnknown;

  /// No description provided for @impactFactors.
  ///
  /// In en, this message translates to:
  /// **'Impact Factors'**
  String get impactFactors;

  /// No description provided for @carbonFootprint.
  ///
  /// In en, this message translates to:
  /// **'Carbon Footprint: CO2 emissions from production and transportation'**
  String get carbonFootprint;

  /// No description provided for @packagingInfo.
  ///
  /// In en, this message translates to:
  /// **'Packaging: Materials used and recyclability'**
  String get packagingInfo;

  /// No description provided for @originInfo.
  ///
  /// In en, this message translates to:
  /// **'Origin: Transportation distance and method'**
  String get originInfo;

  /// No description provided for @productionMethodInfo.
  ///
  /// In en, this message translates to:
  /// **'Production Method: Farming practices and certifications'**
  String get productionMethodInfo;

  /// No description provided for @gradeClassifications.
  ///
  /// In en, this message translates to:
  /// **'Grade Classifications'**
  String get gradeClassifications;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get excellent;

  /// No description provided for @goodLabel.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get goodLabel;

  /// No description provided for @fairLabel.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get fairLabel;

  /// No description provided for @scoreBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Score Breakdown'**
  String get scoreBreakdown;

  /// No description provided for @howWeCalculated.
  ///
  /// In en, this message translates to:
  /// **'How we calculated the overall rating for this product'**
  String get howWeCalculated;

  /// No description provided for @totalScore.
  ///
  /// In en, this message translates to:
  /// **'Total Score'**
  String get totalScore;

  /// No description provided for @baseScore.
  ///
  /// In en, this message translates to:
  /// **'Base Score'**
  String get baseScore;

  /// No description provided for @startingPoint.
  ///
  /// In en, this message translates to:
  /// **'Starting point for all products'**
  String get startingPoint;

  /// No description provided for @ratingScale.
  ///
  /// In en, this message translates to:
  /// **'Rating Scale'**
  String get ratingScale;

  /// No description provided for @goodScore.
  ///
  /// In en, this message translates to:
  /// **'Good: 70-100 points'**
  String get goodScore;

  /// No description provided for @moderateScore.
  ///
  /// In en, this message translates to:
  /// **'Moderate: 40-69 points'**
  String get moderateScore;

  /// No description provided for @poorScore.
  ///
  /// In en, this message translates to:
  /// **'Poor: 0-39 points'**
  String get poorScore;

  /// No description provided for @nutriScoreEInfo.
  ///
  /// In en, this message translates to:
  /// **'Grade E - Nutritional quality'**
  String get nutriScoreEInfo;

  /// No description provided for @ecoScoreUnknownInfo.
  ///
  /// In en, this message translates to:
  /// **'Grade UNKNOWN - Environmental impact'**
  String get ecoScoreUnknownInfo;

  /// No description provided for @additivesInfo.
  ///
  /// In en, this message translates to:
  /// **'0 high-risk, 2 moderate-risk additives'**
  String get additivesInfo;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product Not Found'**
  String get productNotFound;

  /// No description provided for @notInDatabase.
  ///
  /// In en, this message translates to:
  /// **'This barcode is not yet in the Open Food Facts database.'**
  String get notInDatabase;

  /// No description provided for @barcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode;

  /// No description provided for @helpBuildDatabase.
  ///
  /// In en, this message translates to:
  /// **'Help Build the Database'**
  String get helpBuildDatabase;

  /// No description provided for @addProductDescription.
  ///
  /// In en, this message translates to:
  /// **'You can help millions of users by adding this product to Open Food Facts! It only takes a few minutes and makes the database more complete.'**
  String get addProductDescription;

  /// No description provided for @takePhotos.
  ///
  /// In en, this message translates to:
  /// **'Take photos of the product, ingredients, and nutrition facts'**
  String get takePhotos;

  /// No description provided for @enterProductInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter the product information'**
  String get enterProductInfo;

  /// No description provided for @contributionAvailable.
  ///
  /// In en, this message translates to:
  /// **'Your contribution will be immediately available to everyone'**
  String get contributionAvailable;

  /// No description provided for @addProductButton.
  ///
  /// In en, this message translates to:
  /// **'Add Product to Open Food Facts'**
  String get addProductButton;

  /// No description provided for @whatYouCanDo.
  ///
  /// In en, this message translates to:
  /// **'What else you can do:'**
  String get whatYouCanDo;

  /// No description provided for @scanAnother.
  ///
  /// In en, this message translates to:
  /// **'Scan another product'**
  String get scanAnother;

  /// No description provided for @tryDifferentBarcode.
  ///
  /// In en, this message translates to:
  /// **'Try a different barcode'**
  String get tryDifferentBarcode;

  /// No description provided for @searchManually.
  ///
  /// In en, this message translates to:
  /// **'Search manually'**
  String get searchManually;

  /// No description provided for @trySearchingByName.
  ///
  /// In en, this message translates to:
  /// **'Try searching by product name'**
  String get trySearchingByName;

  /// No description provided for @whyMissing.
  ///
  /// In en, this message translates to:
  /// **'Why is this product missing?'**
  String get whyMissing;

  /// No description provided for @whyMissingDescription.
  ///
  /// In en, this message translates to:
  /// **'Open Food Facts is built by volunteers. New products, regional items, or products from smaller brands might not be in the database yet. Your contribution helps make it more complete!'**
  String get whyMissingDescription;

  /// No description provided for @scanAnotherProduct.
  ///
  /// In en, this message translates to:
  /// **'Scan Another Product'**
  String get scanAnotherProduct;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @aboutOpenFoodFacts.
  ///
  /// In en, this message translates to:
  /// **'About Open Food Facts'**
  String get aboutOpenFoodFacts;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A free, open, collaborative database of food products from around the world'**
  String get aboutSubtitle;

  /// No description provided for @whatIsOff.
  ///
  /// In en, this message translates to:
  /// **'What is Open Food Facts?'**
  String get whatIsOff;

  /// No description provided for @offDescription.
  ///
  /// In en, this message translates to:
  /// **'Open Food Facts is a food products database made by everyone, for everyone. It\'s a non-profit project developed by thousands of volunteers from around the world.\n\nAnyone can add products to the database and use the data for any purpose - educational, commercial or personal - since the data is open and free.'**
  String get offDescription;

  /// No description provided for @collaborativeData.
  ///
  /// In en, this message translates to:
  /// **'Collaborative Data'**
  String get collaborativeData;

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Contributors Scan Products'**
  String get step1Title;

  /// No description provided for @step1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Volunteers scan barcodes and photograph product labels.'**
  String get step1Subtitle;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Data is Extracted'**
  String get step2Title;

  /// No description provided for @step2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Ingredients, nutritional information, and labels are extracted from photos.'**
  String get step2Subtitle;

  /// No description provided for @step3Title.
  ///
  /// In en, this message translates to:
  /// **'Everyone Benefits'**
  String get step3Title;

  /// No description provided for @step3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'The data is freely available to apps, researchers, and consumers.'**
  String get step3Subtitle;

  /// No description provided for @informationAvailable.
  ///
  /// In en, this message translates to:
  /// **'Information Available'**
  String get informationAvailable;

  /// No description provided for @ingredientsLabel.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredientsLabel;

  /// No description provided for @allergensLabel.
  ///
  /// In en, this message translates to:
  /// **'Allergens'**
  String get allergensLabel;

  /// No description provided for @additivesLabel.
  ///
  /// In en, this message translates to:
  /// **'Additives'**
  String get additivesLabel;

  /// No description provided for @nutritionFactsLabel.
  ///
  /// In en, this message translates to:
  /// **'Nutrition Facts'**
  String get nutritionFactsLabel;

  /// No description provided for @labelsLabel.
  ///
  /// In en, this message translates to:
  /// **'Labels'**
  String get labelsLabel;

  /// No description provided for @databaseCoverage.
  ///
  /// In en, this message translates to:
  /// **'Database Coverage'**
  String get databaseCoverage;

  /// No description provided for @productsLabel.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get productsLabel;

  /// No description provided for @countriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get countriesLabel;

  /// No description provided for @howToContribute.
  ///
  /// In en, this message translates to:
  /// **'How to Contribute'**
  String get howToContribute;

  /// No description provided for @contributeDescription.
  ///
  /// In en, this message translates to:
  /// **'Help improve the database by adding missing products or completing existing product information!'**
  String get contributeDescription;

  /// No description provided for @contributeButton.
  ///
  /// In en, this message translates to:
  /// **'Contribute to Open Food Facts'**
  String get contributeButton;

  /// No description provided for @openDataLicense.
  ///
  /// In en, this message translates to:
  /// **'Open Data License'**
  String get openDataLicense;

  /// No description provided for @licenseDescription.
  ///
  /// In en, this message translates to:
  /// **'All product data is published under the Open Database License (ODbL). Product images are under Creative Commons Attribution ShareAlike license.'**
  String get licenseDescription;

  /// No description provided for @visitWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit Open Food Facts Website'**
  String get visitWebsite;

  /// No description provided for @exploreData.
  ///
  /// In en, this message translates to:
  /// **'Explore the Data'**
  String get exploreData;

  /// No description provided for @noScansYet.
  ///
  /// In en, this message translates to:
  /// **'No scans yet'**
  String get noScansYet;

  /// No description provided for @tapScanButtonToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Tap the scan button to get started'**
  String get tapScanButtonToGetStarted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
