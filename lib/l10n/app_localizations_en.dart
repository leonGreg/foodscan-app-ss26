// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FoodScan';

  @override
  String get homeSubtitle => 'Scan products to discover nutritional info';

  @override
  String get searchHint => 'Search product or barcode...';

  @override
  String get recentScans => 'Recent Scans';

  @override
  String get noRecentScans => 'No recent scans yet';

  @override
  String get scanProduct => 'Scan Product';

  @override
  String get positionBarcode => 'Position barcode within the frame';

  @override
  String get enterBarcodeManually => 'Enter Barcode Manually';

  @override
  String get enterBarcode => 'Enter Barcode';

  @override
  String get barcodeNumber => 'Enter barcode number';

  @override
  String get search => 'Search';

  @override
  String get cancel => 'Cancel';

  @override
  String get searchProduct => 'Search Product';

  @override
  String get barcodeExample => 'e.g., 3017620422003';

  @override
  String get enterBarcodeInstructions =>
      'Type in the barcode number to search for a product';

  @override
  String get overallRating => 'Overall Rating';

  @override
  String get moderate => 'Moderate';

  @override
  String get poor => 'Poor';

  @override
  String get nutriScore => 'Nutri-Score';

  @override
  String get ecoScore => 'Eco-Score';

  @override
  String get additives => 'Additives';

  @override
  String get nutrition => 'Nutrition';

  @override
  String get nutritionalValues => 'Nutritional Values';

  @override
  String get energy => 'Energy';

  @override
  String get fat => 'Fat';

  @override
  String get saturatedFat => 'Saturated Fat';

  @override
  String get carbohydrates => 'Carbohydrates';

  @override
  String get sugars => 'Sugars';

  @override
  String get proteins => 'Proteins';

  @override
  String get salt => 'Salt';

  @override
  String get novaGroup => 'NOVA Group';

  @override
  String get highRisk => 'High Risk';

  @override
  String get moderateRisk => 'Moderate Risk';

  @override
  String get lowRisk => 'Low Risk';

  @override
  String get high => 'High';

  @override
  String get low => 'Low';

  @override
  String get avoid => 'Avoid';

  @override
  String get limit => 'Limit';

  @override
  String get safe => 'Safe';

  @override
  String get total => 'Total';

  @override
  String get aboutNutriScore => 'About Nutri-Score';

  @override
  String get understandingNutritionalSystem =>
      'Understanding the nutritional quality rating system';

  @override
  String get nutriScoreDescription =>
      'Nutri-Score is a nutrition label that converts the nutritional value of products into a simple code consisting of 5 letters, each with its own color. Each product is awarded a score based on a scientific algorithm.';

  @override
  String get fruitsVegetablesNuts => 'Fruits, Vegetables, Nuts';

  @override
  String get varies => 'Varies';

  @override
  String get aboutEcoScore => 'About Eco-Score';

  @override
  String get understandingEnvironmentalSystem =>
      'Understanding the environmental impact rating system';

  @override
  String get ecoScoreDescription =>
      'Eco-Score evaluates the environmental impact of food products from A to E. It considers production methods, transportation, packaging, and the impact on biodiversity.';

  @override
  String get impactFactors => 'Impact Factors';

  @override
  String get gradeClassifications => 'Grade Classifications';

  @override
  String get excellent => 'Excellent';

  @override
  String get goodLabel => 'Good';

  @override
  String get fairLabel => 'Fair';

  @override
  String get scoreBreakdown => 'Score Breakdown';

  @override
  String get howWeCalculated =>
      'How we calculated the overall rating for this product';

  @override
  String get totalScore => 'Total Score';

  @override
  String get points => 'points';

  @override
  String get baseScore => 'Base Score';

  @override
  String get baseScoreSubtitle => 'Starting point for all products';

  @override
  String nutriScoreSubtitle(Object grade) {
    return 'Grade $grade - Nutritional quality';
  }

  @override
  String ecoScoreSubtitle(Object grade) {
    return 'Grade $grade - Environmental impact';
  }

  @override
  String additivesSubtitle(Object high, Object moderate) {
    return '$high high-risk, $moderate moderate-risk additives';
  }

  @override
  String get novaSubtitleUltra => 'Ultra-processed foods';

  @override
  String get novaSubtitleProcessed => 'Processed foods';

  @override
  String get organicBonus => 'Organic Bonus';

  @override
  String get organicBonusSubtitle => 'Certified organic product';

  @override
  String get productNotFound => 'Product Not Found';

  @override
  String get notInDatabase =>
      'This barcode is not yet in the Open Food Facts database.';

  @override
  String get barcode => 'Barcode';

  @override
  String get helpBuildDatabase => 'Help Build the Database';

  @override
  String get addProductDescription =>
      'You can help millions of users by adding this product to Open Food Facts! It only takes a few minutes and makes the database more complete.';

  @override
  String get takePhotos =>
      'Take photos of the product, ingredients, and nutrition facts';

  @override
  String get enterProductInfo => 'Enter the product information';

  @override
  String get contributionAvailable =>
      'Your contribution will be immediately available to everyone';

  @override
  String get addProductButton => 'Add Product to Open Food Facts';

  @override
  String get whatYouCanDo => 'What else you can do:';

  @override
  String get scanAnother => 'Scan another product';

  @override
  String get tryDifferentBarcode => 'Try a different barcode';

  @override
  String get searchManually => 'Search manually';

  @override
  String get trySearchingByName => 'Try searching by product name';

  @override
  String get whyMissing => 'Why is this product missing?';

  @override
  String get whyMissingDescription =>
      'Open Food Facts is built by volunteers. New products, regional items, or products from smaller brands might not be in the database yet. Your contribution helps make it more complete!';

  @override
  String get scanAnotherProduct => 'Scan Another Product';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get aboutOpenFoodFacts => 'About Open Food Facts';

  @override
  String get aboutSubtitle =>
      'A free, open, collaborative database of food products from around the world';

  @override
  String get whatIsOff => 'What is Open Food Facts?';

  @override
  String get offDescription =>
      'Open Food Facts is a food products database made by everyone, for everyone. It\'s a non-profit project developed by thousands of volunteers from around the world.\n\nAnyone can add products to the database and use the data for any purpose - educational, commercial or personal - since the data is open and free.';

  @override
  String get collaborativeData => 'Collaborative Data';

  @override
  String get step1Title => 'Contributors Scan Products';

  @override
  String get step1Subtitle =>
      'Volunteers scan barcodes and photograph product labels.';

  @override
  String get step2Title => 'Data is Extracted';

  @override
  String get step2Subtitle =>
      'Ingredients, nutritional information, and labels are extracted from photos.';

  @override
  String get step3Title => 'Everyone Benefits';

  @override
  String get step3Subtitle =>
      'The data is freely available to apps, researchers, and consumers.';

  @override
  String get informationAvailable => 'Information Available';

  @override
  String get ingredientsLabel => 'Ingredients';

  @override
  String get allergensLabel => 'Allergens';

  @override
  String get additivesLabel => 'Additives';

  @override
  String get nutritionFactsLabel => 'Nutrition Facts';

  @override
  String get labelsLabel => 'Labels';

  @override
  String get databaseCoverage => 'Database Coverage';

  @override
  String get productsLabel => 'Products';

  @override
  String get countriesLabel => 'Countries';

  @override
  String get howToContribute => 'How to Contribute';

  @override
  String get contributeDescription =>
      'Help improve the database by adding missing products or completing existing product information!';

  @override
  String get contributeButton => 'Contribute to Open Food Facts';

  @override
  String get openDataLicense => 'Open Data License';

  @override
  String get licenseDescription =>
      'All product data is published under the Open Database License (ODbL). Product images are under Creative Commons Attribution ShareAlike license.';

  @override
  String get visitWebsite => 'Visit Open Food Facts Website';

  @override
  String get exploreData => 'Explore the Data';

  @override
  String get noScansYet => 'No scans yet';

  @override
  String get tapScanButtonToGetStarted => 'Tap the scan button to get started';

  @override
  String get noAdditivesFound => 'No additives found';

  @override
  String get noNutritionDataFound => 'No nutrition data found';

  @override
  String get nutritionalValuesPer100g => 'Nutritional Values (per 100g)';

  @override
  String get additiveInformation => 'Information about this food additive';

  @override
  String get additiveName => 'Name';

  @override
  String get riskLevel => 'Risk Level';

  @override
  String get lowRiskDescription =>
      'This additive is generally considered safe and has no known negative health effects in typical quantities.';

  @override
  String get moderateRiskDescription =>
      'This additive is generally safe but should be consumed in moderation. Some individuals may be sensitive to it.';

  @override
  String get highRiskDescription =>
      'This additive is controversial or linked to health concerns. It is recommended to avoid or limit its consumption.';

  @override
  String get unknown => 'Unknown';

  @override
  String get nova1 => 'Unprocessed';

  @override
  String get nova2 => 'Processed ingredients';

  @override
  String get nova3 => 'Processed foods';

  @override
  String get nova4 => 'Ultra-processed';

  @override
  String get errorFetchingProduct => 'Error fetching product';

  @override
  String get profileTitle => 'Profile';

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirmTitle => 'Log out?';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get memberSince => 'Member since';

  @override
  String get accountSection => 'Personal Information';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginSubtitle => 'Welcome back!';

  @override
  String get loginButton => 'Log in';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordTitle => 'Reset your password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email address and we will send you a reset link.';

  @override
  String get forgotPasswordButton => 'Send reset link';

  @override
  String get backToLogin => 'Back to log in';

  @override
  String get resetEmailSent =>
      'If an account exists for this email address, a reset link has been sent.';

  @override
  String get forgotPasswordErrorUserNotFound =>
      'No account exists for this email address.';

  @override
  String get forgotPasswordErrorNetwork =>
      'Network error. Please check your internet connection.';

  @override
  String get forgotPasswordErrorRateLimited =>
      'Too many requests. Please try again later.';

  @override
  String get forgotPasswordErrorGeneric =>
      'Unable to send reset email. Please try again.';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get noAccountYet => 'Don\'t have an account?';

  @override
  String get registerNow => 'Sign up';

  @override
  String get registerTitle => 'Sign up';

  @override
  String get registerSubtitle => 'Create a new account';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords don\'t match';

  @override
  String get registerButton => 'Sign up';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginNow => 'Log in';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get authErrorUserNotFound => 'No account found for this email.';

  @override
  String get authErrorWrongPassword => 'Incorrect password.';

  @override
  String get authErrorEmailAlreadyInUse =>
      'This email address is already in use.';

  @override
  String get authErrorWeakPassword => 'The password is too weak.';

  @override
  String get authErrorNetworkFailed =>
      'Network error. Please check your internet connection.';

  @override
  String get authErrorTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get authErrorInvalidCredential => 'Email or password is incorrect.';

  @override
  String get authErrorGeneric => 'An error occurred. Please try again.';

  @override
  String get save => 'Save';

  @override
  String get or => 'or';

  @override
  String get editProfileTooltip => 'Edit profile';

  @override
  String get searchTitle => 'Search';

  @override
  String get searchSubtitle => 'Search products from your scan history';

  @override
  String get searchTypePlaceholder => 'Type a product name or barcode...';

  @override
  String get noProductsFound => 'No products found.';

  @override
  String get searchResults => 'Search Results';

  @override
  String get scanDeleted => 'Scan deleted';

  @override
  String get retry => 'Retry';

  @override
  String get errorProductNotFound => 'Product not found.';

  @override
  String get errorNetwork =>
      'Could not load data. Please check your connection.';
}
