// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'FoodScan';

  @override
  String get homeSubtitle => 'Skannaa tuotteita löytääksesi ravintotietoja';

  @override
  String get searchHint => 'Etsi tuotetta tai viivakoodia...';

  @override
  String get recentScans => 'Viimeisimmät skannaukset';

  @override
  String get noRecentScans => 'Ei vielä skannauksia';

  @override
  String get scanProduct => 'Skannaa tuote';

  @override
  String get positionBarcode => 'Sijoita viivakoodi kehyksen sisään';

  @override
  String get enterBarcodeManually => 'Syötä viivakoodi käsin';

  @override
  String get enterBarcode => 'Syötä viivakoodi';

  @override
  String get barcodeNumber => 'Syötä viivakoodinumero';

  @override
  String get search => 'Hae';

  @override
  String get cancel => 'Peruuta';

  @override
  String get searchProduct => 'Etsi tuotetta';

  @override
  String get barcodeExample => 'esim. 3017620422003';

  @override
  String get enterBarcodeInstructions =>
      'Kirjoita viivakoodinumero etsiäksesi tuotetta';

  @override
  String get overallRating => 'Kokonaisarvio';

  @override
  String get moderate => 'Kohtalainen';

  @override
  String get poor => 'Huono';

  @override
  String get nutriScore => 'Nutri-Score';

  @override
  String get ecoScore => 'Eco-Score';

  @override
  String get additives => 'Lisäaineet';

  @override
  String get nutrition => 'Ravintosisältö';

  @override
  String get nutritionalValues => 'Ravintoarvot';

  @override
  String get energy => 'Energia';

  @override
  String get fat => 'Rasva';

  @override
  String get saturatedFat => 'Tyydyttynyt rasva';

  @override
  String get carbohydrates => 'Hiilihydraatit';

  @override
  String get sugars => 'Sokerit';

  @override
  String get proteins => 'Proteiinit';

  @override
  String get salt => 'Suola';

  @override
  String get novaGroup => 'NOVA-ryhmä';

  @override
  String get highRisk => 'Korkea riski';

  @override
  String get moderateRisk => 'Kohtalainen riski';

  @override
  String get lowRisk => 'Matala riski';

  @override
  String get high => 'Korkea';

  @override
  String get low => 'Matala';

  @override
  String get avoid => 'Vältä';

  @override
  String get limit => 'Rajoita';

  @override
  String get safe => 'Turvallinen';

  @override
  String get total => 'Yhteensä';

  @override
  String get aboutNutriScore => 'Tietoa Nutri-Scoresta';

  @override
  String get understandingNutritionalSystem =>
      'Ymmärrä ravitsemuksellisen laadun arviointijärjestelmä';

  @override
  String get nutriScoreDescription =>
      'Nutri-Score on ravintomerkintä, joka muuntaa tuotteiden ravintoarvon yksinkertaiseksi 5 kirjaimen koodiksi, joilla kullakin on oma värinsä. Jokainen tuote saa pisteen tieteellisen algoritmin perusteella.';

  @override
  String get fruitsVegetablesNuts => 'Hedelmät, vihannekset, pähkinät';

  @override
  String get varies => 'Vaihtelee';

  @override
  String get aboutEcoScore => 'Tietoa Eco-Scoresta';

  @override
  String get understandingEnvironmentalSystem =>
      'Ymmärrä ympäristövaikutusten arviointijärjestelmä';

  @override
  String get ecoScoreDescription =>
      'Eco-Score arvioi elintarvikkeiden ympäristövaikutukset asteikolla A–E. Se huomioi tuotantotavat, kuljetuksen, pakkauksen ja vaikutuksen biologiseen monimuotoisuuteen.';

  @override
  String get impactFactors => 'Vaikuttavat tekijät';

  @override
  String get gradeClassifications => 'Luokitukset';

  @override
  String get excellent => 'Erinomainen';

  @override
  String get goodLabel => 'Hyvä';

  @override
  String get fairLabel => 'Kohtalainen';

  @override
  String get scoreBreakdown => 'Pisteiden erittely';

  @override
  String get howWeCalculated =>
      'Kuinka laskimme tämän tuotteen kokonaisarvosanan';

  @override
  String get totalScore => 'Kokonaispisteet';

  @override
  String get points => 'pistettä';

  @override
  String get baseScore => 'Peruspisteet';

  @override
  String get baseScoreSubtitle => 'Kaikkien tuotteiden lähtökohta';

  @override
  String nutriScoreSubtitle(Object grade) {
    return 'Luokka $grade - Ravitsemuksellinen laatu';
  }

  @override
  String ecoScoreSubtitle(Object grade) {
    return 'Luokka $grade - Ympäristövaikutus';
  }

  @override
  String additivesSubtitle(Object high, Object moderate) {
    return '$high korkean riskin, $moderate kohtalaisen riskin lisäainetta';
  }

  @override
  String get novaSubtitleUltra => 'Pitkälle prosessoidut elintarvikkeet';

  @override
  String get novaSubtitleProcessed => 'Prosessoidut elintarvikkeet';

  @override
  String get organicBonus => 'Luomubonus';

  @override
  String get organicBonusSubtitle => 'Sertifioitu luomutuote';

  @override
  String get productNotFound => 'Tuotetta ei löytynyt';

  @override
  String get notInDatabase =>
      'Tätä viivakoodia ei ole vielä Open Food Facts -tietokannassa.';

  @override
  String get barcode => 'Viivakoodi';

  @override
  String get helpBuildDatabase => 'Auta rakentamaan tietokantaa';

  @override
  String get addProductDescription =>
      'Voit auttaa miljoonia käyttäjiä lisäämällä tämän tuotteen Open Food Facts -tietokantaan! Se vie vain muutaman minuutin ja tekee tietokannasta kattavamman.';

  @override
  String get takePhotos =>
      'Ota kuvia tuotteesta, ainesosista ja ravintosisällöstä';

  @override
  String get enterProductInfo => 'Syötä tuotetiedot';

  @override
  String get contributionAvailable =>
      'Panoksesi on välittömästi kaikkien saatavilla';

  @override
  String get addProductButton => 'Lisää tuote Open Food Facts -tietokantaan';

  @override
  String get whatYouCanDo => 'Mitä muuta voit tehdä:';

  @override
  String get scanAnother => 'Skannaa toinen tuote';

  @override
  String get tryDifferentBarcode => 'Kokeile eri viivakoodia';

  @override
  String get searchManually => 'Hae käsin';

  @override
  String get trySearchingByName => 'Kokeile hakea tuotteen nimellä';

  @override
  String get whyMissing => 'Miksi tämä tuote puuttuu?';

  @override
  String get whyMissingDescription =>
      'Open Food Facts on vapaaehtoisten rakentama. Uudet tuotteet, paikalliset tuotteet tai pienten merkkien tuotteet eivät ehkä vielä ole tietokannassa. Panoksesi auttaa tekemään siitä kattavamman!';

  @override
  String get scanAnotherProduct => 'Skannaa toinen tuote';

  @override
  String get backToHome => 'Takaisin etusivulle';

  @override
  String get aboutOpenFoodFacts => 'Tietoa Open Food Factsista';

  @override
  String get aboutSubtitle =>
      'Ilmainen, avoin ja yhteisöllinen elintarviketietokanta kaikkialta maailmasta';

  @override
  String get whatIsOff => 'Mikä on Open Food Facts?';

  @override
  String get offDescription =>
      'Open Food Facts on kaikkien tekemä, kaikille tarkoitettu elintarviketietokanta. Se on voittoa tavoittelematon projekti, jota kehittävät tuhannet vapaaehtoiset ympäri maailmaa.\n\nKuka tahansa voi lisätä tuotteita tietokantaan ja käyttää tietoja mihin tahansa tarkoitukseen - opetukseen, kaupalliseen tai henkilökohtaiseen - koska tiedot ovat avoimia ja ilmaisia.';

  @override
  String get collaborativeData => 'Yhteisöllinen data';

  @override
  String get step1Title => 'Vapaaehtoiset skannaavat tuotteita';

  @override
  String get step1Subtitle =>
      'Vapaaehtoiset skannaavat viivakoodeja ja valokuvaavat tuote-etikettejä.';

  @override
  String get step2Title => 'Tiedot poimitaan';

  @override
  String get step2Subtitle =>
      'Ainesosat, ravintotiedot ja etiketit poimitaan valokuvista.';

  @override
  String get step3Title => 'Kaikki hyötyvät';

  @override
  String get step3Subtitle =>
      'Tiedot ovat vapaasti sovellusten, tutkijoiden ja kuluttajien käytettävissä.';

  @override
  String get informationAvailable => 'Saatavilla olevat tiedot';

  @override
  String get ingredientsLabel => 'Ainesosat';

  @override
  String get allergensLabel => 'Allergeenit';

  @override
  String get additivesLabel => 'Lisäaineet';

  @override
  String get nutritionFactsLabel => 'Ravintosisältö';

  @override
  String get labelsLabel => 'Merkinnät';

  @override
  String get databaseCoverage => 'Tietokannan kattavuus';

  @override
  String get productsLabel => 'Tuotteet';

  @override
  String get countriesLabel => 'Maat';

  @override
  String get howToContribute => 'Kuinka osallistua';

  @override
  String get contributeDescription =>
      'Auta parantamaan tietokantaa lisäämällä puuttuvia tuotteita tai täydentämällä olemassa olevia tuotetietoja!';

  @override
  String get contributeButton => 'Osallistu Open Food Factsiin';

  @override
  String get openDataLicense => 'Avoin datalisenssi';

  @override
  String get licenseDescription =>
      'Kaikki tuotetiedot on julkaistu Open Database -lisenssillä (ODbL). Tuotekuvat ovat Creative Commons Attribution ShareAlike -lisenssin alaisia.';

  @override
  String get visitWebsite => 'Vieraile Open Food Facts -verkkosivustolla';

  @override
  String get exploreData => 'Selaa tietoja';

  @override
  String get noScansYet => 'Ei vielä skannauksia';

  @override
  String get tapScanButtonToGetStarted =>
      'Aloita napauttamalla skannauspainiketta';

  @override
  String get noAdditivesFound => 'Lisäaineita ei löytynyt';

  @override
  String get noNutritionDataFound => 'Ravintotietoja ei löytynyt';

  @override
  String get nutritionalValuesPer100g => 'Ravintoarvot (per 100g)';

  @override
  String get additiveInformation => 'Tietoa tästä lisäaineesta';

  @override
  String get additiveName => 'Nimi';

  @override
  String get riskLevel => 'Riskitaso';

  @override
  String get lowRiskDescription =>
      'Tätä lisäainetta pidetään yleisesti turvallisena, eikä sillä ole tunnettuja negatiivisia terveysvaikutuksia tyypillisinä määrinä.';

  @override
  String get moderateRiskDescription =>
      'Tämä lisäaine on yleisesti turvallinen, mutta sitä tulee käyttää kohtuudella. Jotkut voivat olla sille herkkiä.';

  @override
  String get highRiskDescription =>
      'Tämä lisäaine on kiistanalainen tai siihen liittyy terveyshuolia. On suositeltavaa välttää tai rajoittaa sen käyttöä.';

  @override
  String get unknown => 'Tuntematon';

  @override
  String get nova1 => 'Käsittelemätön';

  @override
  String get nova2 => 'Käsitellyt ainesosat';

  @override
  String get nova3 => 'Käsitellyt ruoat';

  @override
  String get nova4 => 'Pitkälle prosessoitu';

  @override
  String get errorFetchingProduct => 'Virhe haettaessa tuotetta';

  @override
  String get profileTitle => 'Profiili';

  @override
  String get logout => 'Kirjaudu ulos';

  @override
  String get logoutConfirmTitle => 'Kirjaudu ulos?';

  @override
  String get logoutConfirmMessage =>
      'Oletko varma, että haluat kirjautua ulos?';

  @override
  String get memberSince => 'Jäsen vuodesta';

  @override
  String get accountSection => 'Henkilötiedot';

  @override
  String get loginTitle => 'Kirjaudu sisään';

  @override
  String get loginSubtitle => 'Tervetuloa takaisin!';

  @override
  String get loginButton => 'Kirjaudu sisään';

  @override
  String get forgotPassword => 'Unohtuiko salasana?';

  @override
  String get forgotPasswordTitle => 'Nollaa salasanasi';

  @override
  String get forgotPasswordSubtitle =>
      'Syötä sähköpostiosoitteesi, niin lähetämme sinulle linkin salasanan nollaamiseksi.';

  @override
  String get forgotPasswordButton => 'Lähetä nollauslinkki';

  @override
  String get backToLogin => 'Takaisin kirjautumiseen';

  @override
  String get resetEmailSent =>
      'Jos tällä sähköpostiosoitteella on tili, nollauslinkki on lähetetty.';

  @override
  String get forgotPasswordErrorUserNotFound =>
      'Tälle sähköpostiosoitteelle ei löydy tiliä.';

  @override
  String get forgotPasswordErrorNetwork =>
      'Verkkovirhe. Tarkista internetyhteytesi.';

  @override
  String get forgotPasswordErrorRateLimited =>
      'Liian monta yritystä. Yritä myöhemmin uudelleen.';

  @override
  String get forgotPasswordErrorGeneric =>
      'Nollausviestin lähetys epäonnistui. Yritä uudelleen.';

  @override
  String get emailLabel => 'Sähköposti';

  @override
  String get passwordLabel => 'Salasana';

  @override
  String get noAccountYet => 'Eikö sinulla ole tiliä?';

  @override
  String get registerNow => 'Rekisteröidy';

  @override
  String get registerTitle => 'Rekisteröidy';

  @override
  String get registerSubtitle => 'Luo uusi tili';

  @override
  String get nameLabel => 'Nimi';

  @override
  String get nameRequired => 'Nimi on pakollinen';

  @override
  String get confirmPasswordLabel => 'Vahvista salasana';

  @override
  String get confirmPasswordRequired => 'Vahvista salasanasi';

  @override
  String get passwordsDoNotMatch => 'Salasanat eivät täsmää';

  @override
  String get registerButton => 'Rekisteröidy';

  @override
  String get alreadyHaveAccount => 'Onko sinulla jo tili?';

  @override
  String get loginNow => 'Kirjaudu sisään';

  @override
  String get emailRequired => 'Sähköposti on pakollinen';

  @override
  String get emailInvalid => 'Virheellinen sähköpostiosoite';

  @override
  String get passwordRequired => 'Salasana on pakollinen';

  @override
  String get passwordTooShort =>
      'Salasanan on oltava vähintään 6 merkkiä pitkä';

  @override
  String get authErrorUserNotFound =>
      'Tälle sähköpostiosoitteelle ei löydy tiliä.';

  @override
  String get authErrorWrongPassword => 'Väärä salasana.';

  @override
  String get authErrorEmailAlreadyInUse =>
      'Tämä sähköpostiosoite on jo käytössä.';

  @override
  String get authErrorWeakPassword => 'Salasana on liian heikko.';

  @override
  String get authErrorNetworkFailed =>
      'Verkkovirhe. Tarkista internetyhteytesi.';

  @override
  String get authErrorTooManyRequests =>
      'Liian monta yritystä. Yritä myöhemmin uudelleen.';

  @override
  String get authErrorInvalidCredential => 'Sähköposti tai salasana on väärä.';

  @override
  String get authErrorGeneric => 'Tapahtui virhe. Yritä uudelleen.';

  @override
  String get save => 'Tallenna';

  @override
  String get or => 'tai';

  @override
  String get editProfileTooltip => 'Muokkaa profiilia';

  @override
  String get searchTitle => 'Haku';

  @override
  String get searchSubtitle => 'Etsi tuotteita skannauksistasi';

  @override
  String get searchTypePlaceholder =>
      'Kirjoita tuotteen nimi tai viivakoodi...';

  @override
  String get noProductsFound => 'Tuotteita ei löytynyt.';

  @override
  String get searchResults => 'Hakutulokset';

  @override
  String get scanDeleted => 'Skannaus poistettu';
}
