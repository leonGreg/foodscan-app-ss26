// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'FoodScan';

  @override
  String get homeSubtitle =>
      'Produkte scannen um Nährwertinformationen zu entdecken';

  @override
  String get searchHint => 'Produkt oder Barcode suchen...';

  @override
  String get recentScans => 'Letzte Scans';

  @override
  String get noRecentScans => 'Noch keine Scans';

  @override
  String get scanProduct => 'Produkt scannen';

  @override
  String get positionBarcode => 'Barcode im Rahmen positionieren';

  @override
  String get enterBarcodeManually => 'Barcode manuell eingeben';

  @override
  String get enterBarcode => 'Barcode eingeben';

  @override
  String get barcodeNumber => 'Barcodenummer eingeben';

  @override
  String get search => 'Suchen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get searchProduct => 'Produkt suchen';

  @override
  String get barcodeExample => 'z.B. 3017620422003';

  @override
  String get enterBarcodeInstructions =>
      'Geben Sie die Barcodenummer ein, um nach einem Produkt zu suchen';

  @override
  String get overallRating => 'Gesamtbewertung';

  @override
  String get moderate => 'Mittel';

  @override
  String get poor => 'Schlecht';

  @override
  String get nutriScore => 'Nutri-Score';

  @override
  String get ecoScore => 'Eco-Score';

  @override
  String get additives => 'Zusatzstoffe';

  @override
  String get nutrition => 'Nährwertangaben';

  @override
  String get nutritionalValues => 'Nährwertangaben';

  @override
  String get energy => 'Energie';

  @override
  String get fat => 'Fett';

  @override
  String get saturatedFat => 'Gesättigte Fettsäuren';

  @override
  String get carbohydrates => 'Kohlenhydrate';

  @override
  String get sugars => 'Zucker';

  @override
  String get proteins => 'Eiweiß';

  @override
  String get salt => 'Salz';

  @override
  String get novaGroup => 'NOVA Gruppe';

  @override
  String get highRisk => 'Hohes Risiko';

  @override
  String get moderateRisk => 'Mittleres Risiko';

  @override
  String get lowRisk => 'Niedriges Risiko';

  @override
  String get high => 'Hoch';

  @override
  String get low => 'Niedrig';

  @override
  String get avoid => 'Vermeiden';

  @override
  String get limit => 'Einschränken';

  @override
  String get safe => 'Sicher';

  @override
  String get total => 'Gesamt';

  @override
  String get aboutNutriScore => 'Über Nutri-Score';

  @override
  String get understandingNutritionalSystem =>
      'Das Bewertungssystem für die Ernährungsqualität verstehen';

  @override
  String get nutriScoreDescription =>
      'Der Nutri-Score ist ein Nährwertkennzeichnungssystem, das den Nährwert von Produkten in einen einfachen Code aus 5 Buchstaben mit jeweils eigener Farbe übersetzt. Jedes Produkt erhält eine Bewertung basierend auf einem wissenschaftlichen Algorithmus.';

  @override
  String get fruitsVegetablesNuts => 'Obst, Gemüse, Nüsse';

  @override
  String get varies => 'Variiert';

  @override
  String get aboutEcoScore => 'Über Eco-Score';

  @override
  String get understandingEnvironmentalSystem =>
      'Das System zur Bewertung der Umweltauswirkungen verstehen';

  @override
  String get ecoScoreDescription =>
      'Der Eco-Score bewertet die Umweltauswirkungen von Lebensmitteln von A bis E. Er berücksichtigt Produktionsmethoden, Transport, Verpackung und die Auswirkungen auf die Artenvielfalt.';

  @override
  String get impactFactors => 'Einflussfaktoren';

  @override
  String get gradeClassifications => 'Stufen-Klassifizierung';

  @override
  String get excellent => 'Ausgezeichnet';

  @override
  String get goodLabel => 'Gut';

  @override
  String get fairLabel => 'Mittel';

  @override
  String get scoreBreakdown => 'Score-Aufschlüsselung';

  @override
  String get howWeCalculated =>
      'Wie wir die Gesamtbewertung für dieses Produkt berechnet haben';

  @override
  String get totalScore => 'Gesamtpunktzahl';

  @override
  String get points => 'Punkte';

  @override
  String get baseScore => 'Basispunktzahl';

  @override
  String get baseScoreSubtitle => 'Ausgangspunkt für alle Produkte';

  @override
  String nutriScoreSubtitle(Object grade) {
    return 'Stufe $grade - Ernährungsphysiologische Qualität';
  }

  @override
  String ecoScoreSubtitle(Object grade) {
    return 'Stufe $grade - Umweltauswirkungen';
  }

  @override
  String additivesSubtitle(Object high, Object moderate) {
    return '$high Hochrisiko-, $moderate moderate Zusatzstoffe';
  }

  @override
  String get novaSubtitleUltra => 'Ultra-verarbeitete Lebensmittel';

  @override
  String get novaSubtitleProcessed => 'Verarbeitete Lebensmittel';

  @override
  String get organicBonus => 'Bio-Bonus';

  @override
  String get organicBonusSubtitle => 'Zertifiziertes Bio-Produkt';

  @override
  String get productNotFound => 'Produkt nicht gefunden';

  @override
  String get notInDatabase =>
      'Dieser Barcode ist noch nicht in der Open Food Facts Datenbank vorhanden.';

  @override
  String get barcode => 'Barcode';

  @override
  String get helpBuildDatabase => 'Helfen Sie beim Aufbau der Datenbank';

  @override
  String get addProductDescription =>
      'Sie können Millionen von Nutzern helfen, indem Sie dieses Produkt zu Open Food Facts hinzufügen! It dauert nur wenige Minuten und macht die Datenbank vollständiger.';

  @override
  String get takePhotos =>
      'Machen Sie Fotos vom Produkt, den Zutaten und den Nährwertangaben';

  @override
  String get enterProductInfo => 'Geben Sie die Produktinformationen ein';

  @override
  String get contributionAvailable =>
      'Ihr Beitrag ist sofort für alle verfügbar';

  @override
  String get addProductButton => 'Produkt zu Open Food Facts hinzufügen';

  @override
  String get whatYouCanDo => 'Was Sie sonst noch tun können:';

  @override
  String get scanAnother => 'Ein weiteres Produkt scannen';

  @override
  String get tryDifferentBarcode => 'Versuchen Sie einen anderen Barcode';

  @override
  String get searchManually => 'Manuell suchen';

  @override
  String get trySearchingByName => 'Versuchen Sie die Suche nach Produktnamen';

  @override
  String get whyMissing => 'Warum fehlt dieses Produkt?';

  @override
  String get whyMissingDescription =>
      'Open Food Facts wird von Freiwilligen aufgebaut. Neue Produkte, regionale Artikel oder Produkte kleinerer Marken sind möglicherweise noch nicht in der Datenbank. Ihr Beitrag hilft, sie zu vervollständigen!';

  @override
  String get scanAnotherProduct => 'Anderes Produkt scannen';

  @override
  String get backToHome => 'Zurück zur Startseite';

  @override
  String get aboutOpenFoodFacts => 'Über Open Food Facts';

  @override
  String get aboutSubtitle =>
      'Eine freie, offene und gemeinschaftliche Datenbank für Lebensmittel aus der ganzen Welt';

  @override
  String get whatIsOff => 'Was ist Open Food Facts?';

  @override
  String get offDescription =>
      'Open Food Facts ist eine Lebensmitteldatenbank von allen für alle. Es ist ein gemeinnütziges Projekt, das von Tausenden von Freiwilligen aus der ganzen Welt entwickelt wurde.\n\nJeder kann Produkte zur Datenbank hinzufügen und die Daten für jeden Zweck nutzen - sei es für Bildungszwecke, kommerziell oder persönlich - da die Daten offen und kostenlos sind.';

  @override
  String get collaborativeData => 'Gemeinschaftliche Daten';

  @override
  String get step1Title => 'Beitragende scannen Produkte';

  @override
  String get step1Subtitle =>
      'Freiwillige scannen Barcodes und fotografieren Produktetiketten.';

  @override
  String get step2Title => 'Daten werden extrahiert';

  @override
  String get step2Subtitle =>
      'Zutaten, Nährwertinformationen und Etiketten werden aus Fotos extrahiert.';

  @override
  String get step3Title => 'Alle profitieren';

  @override
  String get step3Subtitle =>
      'Die Daten stehen Apps, Forschern und Verbrauchern frei zur Verfügung.';

  @override
  String get informationAvailable => 'Verfügbare Informationen';

  @override
  String get ingredientsLabel => 'Zutaten';

  @override
  String get allergensLabel => 'Allergene';

  @override
  String get additivesLabel => 'Zusatzstoffe';

  @override
  String get nutritionFactsLabel => 'Nährwertangaben';

  @override
  String get labelsLabel => 'Etiketten';

  @override
  String get databaseCoverage => 'Abdeckung der Datenbank';

  @override
  String get productsLabel => 'Produkte';

  @override
  String get countriesLabel => 'Länder';

  @override
  String get howToContribute => 'Wie man beitragen kann';

  @override
  String get contributeDescription =>
      'Helfen Sie mit, die Datenbank zu verbessern, indem Sie fehlende Produkte hinzufügen oder bestehende Produktinformationen vervollständigen!';

  @override
  String get contributeButton => 'Zu Open Food Facts beitragen';

  @override
  String get openDataLicense => 'Open Data Lizenz';

  @override
  String get licenseDescription =>
      'Alle Produktdaten werden unter der Open Database License (ODbL) veröffentlicht. Produktbilder stehen unter der Creative Commons Attribution ShareAlike-Lizenz.';

  @override
  String get visitWebsite => 'Open Food Facts Website besuchen';

  @override
  String get exploreData => 'Daten erkunden';

  @override
  String get noScansYet => 'Noch keine Scans';

  @override
  String get tapScanButtonToGetStarted =>
      'Drücken Sie die Schaltfläche zum Scannen, um zu beginnen';

  @override
  String get noAdditivesFound => 'Keine Zusatzstoffe gefunden';

  @override
  String get noNutritionDataFound => 'Keine Nährwertangaben gefunden';

  @override
  String get nutritionalValuesPer100g => 'Nährwertangaben (pro 100g)';

  @override
  String get additiveInformation => 'Informationen über diesen Zusatzstoff';

  @override
  String get additiveName => 'Name';

  @override
  String get riskLevel => 'Risikostufe';

  @override
  String get lowRiskDescription =>
      'Dieser Zusatzstoff gilt allgemein als sicher und hat in üblichen Mengen keine bekannten negativen Auswirkungen auf die Gesundheit.';

  @override
  String get moderateRiskDescription =>
      'Dieser Zusatzstoff ist allgemein sicher, sollte aber in Maßen verzehrt werden. Manche Menschen können empfindlich darauf reagieren.';

  @override
  String get highRiskDescription =>
      'Dieser Zusatzstoff ist umstritten oder wird mit gesundheitlichen Bedenken in Verbindung gebracht. Es wird empfohlen, den Verzehr zu vermeiden oder einzuschränken.';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get nova1 => 'Unverarbeitet';

  @override
  String get nova2 => 'Verarbeitete Zutaten';

  @override
  String get nova3 => 'Verarbeitetes Lebensmittel';

  @override
  String get nova4 => 'Hochverarbeitet';

  @override
  String get errorFetchingProduct => 'Fehler beim Abrufen des Produkts';

  @override
  String get profileTitle => 'Profil';

  @override
  String get logout => 'Abmelden';

  @override
  String get logoutConfirmTitle => 'Abmelden?';

  @override
  String get logoutConfirmMessage => 'Möchtest du dich wirklich abmelden?';

  @override
  String get memberSince => 'Mitglied seit';

  @override
  String get accountSection => 'Persönliche Daten';

  @override
  String get loginTitle => 'Anmelden';

  @override
  String get loginSubtitle => 'Willkommen zurück!';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get forgotPasswordTitle => 'Passwort zurücksetzen';

  @override
  String get forgotPasswordSubtitle =>
      'Gib deine E-Mail-Adresse ein und wir senden dir einen Link zum Zurücksetzen.';

  @override
  String get forgotPasswordButton => 'Reset-Link senden';

  @override
  String get backToLogin => 'Zurück zum Login';

  @override
  String get resetEmailSent =>
      'Falls ein Konto für diese E-Mail-Adresse existiert, wurde ein Reset-Link gesendet.';

  @override
  String get forgotPasswordErrorUserNotFound =>
      'Für diese E-Mail-Adresse existiert kein Konto.';

  @override
  String get forgotPasswordErrorNetwork =>
      'Netzwerkfehler. Bitte überprüfe deine Internetverbindung.';

  @override
  String get forgotPasswordErrorRateLimited =>
      'Zu viele Anfragen. Bitte versuche es später erneut.';

  @override
  String get forgotPasswordErrorGeneric =>
      'Die Reset-E-Mail konnte nicht gesendet werden. Bitte versuche es erneut.';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get noAccountYet => 'Noch kein Konto?';

  @override
  String get registerNow => 'Jetzt registrieren';

  @override
  String get registerTitle => 'Registrieren';

  @override
  String get registerSubtitle => 'Neues Konto erstellen';

  @override
  String get nameLabel => 'Name';

  @override
  String get nameRequired => 'Name ist erforderlich';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get confirmPasswordRequired => 'Bitte Passwort bestätigen';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get registerButton => 'Registrieren';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto?';

  @override
  String get loginNow => 'Jetzt anmelden';

  @override
  String get emailRequired => 'E-Mail ist erforderlich';

  @override
  String get emailInvalid => 'Ungültige E-Mail-Adresse';

  @override
  String get passwordRequired => 'Passwort ist erforderlich';

  @override
  String get passwordTooShort => 'Passwort muss mindestens 6 Zeichen lang sein';

  @override
  String get authErrorUserNotFound => 'Kein Konto mit dieser E-Mail gefunden.';

  @override
  String get authErrorWrongPassword => 'Falsches Passwort.';

  @override
  String get authErrorEmailAlreadyInUse =>
      'Diese E-Mail-Adresse wird bereits verwendet.';

  @override
  String get authErrorWeakPassword => 'Das Passwort ist zu schwach.';

  @override
  String get authErrorNetworkFailed =>
      'Netzwerkfehler. Bitte überprüfe deine Internetverbindung.';

  @override
  String get authErrorTooManyRequests =>
      'Zu viele Versuche. Bitte versuche es später erneut.';

  @override
  String get authErrorInvalidCredential => 'E-Mail oder Passwort ist falsch.';

  @override
  String get authErrorGeneric =>
      'Ein Fehler ist aufgetreten. Bitte versuche es erneut.';

  @override
  String get save => 'Speichern';

  @override
  String get or => 'oder';

  @override
  String get editProfileTooltip => 'Profil bearbeiten';

  @override
  String get searchTitle => 'Suche';

  @override
  String get searchSubtitle => 'Produkte aus deiner Scan-Historie durchsuchen';

  @override
  String get searchTypePlaceholder => 'Produktnamen oder Barcode eingeben...';

  @override
  String get noProductsFound => 'Keine Produkte gefunden.';

  @override
  String get searchResults => 'Suchergebnisse';

  @override
  String get scanDeleted => 'Scan gelöscht';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get errorProductNotFound => 'Produkt nicht gefunden.';

  @override
  String get errorNetwork =>
      'Daten konnten nicht geladen werden. Bitte Verbindung prüfen.';
}
