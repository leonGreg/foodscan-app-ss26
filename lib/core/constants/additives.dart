import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';

enum AdditiveRisk {
  low(Color(AppColors.successGreen)),
  moderate(Color(AppColors.warningOrange)),
  high(Color(AppColors.dangerRed));

  final Color color;

  const AdditiveRisk(this.color);

  static AdditiveRisk getFromTag(String tag) {
    final cleanTag = formatTag(tag).toLowerCase();
    return additiveRiskMapping[cleanTag] ?? AdditiveRisk.moderate;
  }

  static String formatTag(String tag) =>
      tag.replaceFirst('en:', '').toUpperCase();
}

/// Mapping von E-Nummern zu Risikostufen.
/// Basierend auf gängigen Datenbanken
const Map<String, AdditiveRisk> additiveRiskMapping = {
  // --- HIGH RISK (ROT / VERMEIDEN) ---
  // Farbstoffe (Azo-Farbstoffe & Co.)
  'e102': AdditiveRisk.high,
  // Tartrazin
  'e110': AdditiveRisk.high,
  // Gelborange S
  'e122': AdditiveRisk.high,
  // Azorubin
  'e123': AdditiveRisk.high,
  // Amaranth
  'e124': AdditiveRisk.high,
  // Cochenillerot A
  'e127': AdditiveRisk.high,
  // Erythrosin
  'e129': AdditiveRisk.high,
  // Allurarot AC
  'e131': AdditiveRisk.high,
  // Patentblau V
  'e142': AdditiveRisk.high,
  // Grün S
  'e150c': AdditiveRisk.high,
  // Ammoniak-Zuckerkulör
  'e150d': AdditiveRisk.high,
  // Ammonsulfit-Zuckerkulör
  'e151': AdditiveRisk.high,
  // Brillantschwarz BN
  'e154': AdditiveRisk.high,
  // Braun FK
  'e155': AdditiveRisk.high,
  // Braun HT
  'e173': AdditiveRisk.high,
  // Aluminium
  'e180': AdditiveRisk.high,
  // Litholrubin BK

  // Konservierungsstoffe
  'e210': AdditiveRisk.high,
  // Benzoesäure
  'e211': AdditiveRisk.high,
  // Natriumbenzoat
  'e212': AdditiveRisk.high,
  // Kaliumbenzoat
  'e213': AdditiveRisk.high,
  // Calciumbenzoat
  'e249': AdditiveRisk.high,
  // Kaliumnitrit
  'e250': AdditiveRisk.high,
  // Natriumnitrit
  'e251': AdditiveRisk.high,
  // Natriumnitrat
  'e252': AdditiveRisk.high,
  // Kaliumnitrat
  'e284': AdditiveRisk.high,
  // Borsäure
  'e285': AdditiveRisk.high,
  // Natriumtetraborat (Borax)

  // Antioxidationsmittel
  'e310': AdditiveRisk.high,
  // Propylgallat
  'e311': AdditiveRisk.high,
  // Octylgallat
  'e312': AdditiveRisk.high,
  // Dodecylgallat
  'e320': AdditiveRisk.high,
  // Butylhydroxyanisol (BHA)
  'e321': AdditiveRisk.high,
  // Butylhydroxytoluol (BHT)
  'e385': AdditiveRisk.high,
  // Calcium-Dinatrium-EDTA

  // Verdickungsmittel & Emulgatoren (teilweise umstritten)
  'e407': AdditiveRisk.high,
  // Carrageen
  'e407a': AdditiveRisk.high,
  // Verarbeitete Eucheuma-Algen
  'e432': AdditiveRisk.high,
  // Polysorbat 20
  'e433': AdditiveRisk.high,
  // Polysorbat 80
  'e434': AdditiveRisk.high,
  // Polysorbat 40
  'e435': AdditiveRisk.high,
  // Polysorbat 60
  'e436': AdditiveRisk.high,
  // Polysorbat 65
  'e466': AdditiveRisk.high,
  // Carboxymethylcellulose (CMC)

  // Geschmacksverstärker
  'e620': AdditiveRisk.high,
  // Glutaminsäure
  'e621': AdditiveRisk.high,
  // Mononatriumglutamat
  'e622': AdditiveRisk.high,
  // Monokaliumglutamat
  'e623': AdditiveRisk.high,
  // Calciumdiglutamat
  'e624': AdditiveRisk.high,
  // Monoammoniumglutamat
  'e625': AdditiveRisk.high,
  // Magnesiumdiglutamat

  // Süßstoffe
  'e950': AdditiveRisk.high,
  // Acesulfam K
  'e951': AdditiveRisk.high,
  // Aspartam
  'e952': AdditiveRisk.high,
  // Cyclamat
  'e954': AdditiveRisk.high,
  // Saccharin

  // --- MODERATE RISK (GELB / EINGESCHRÄNKT) ---
  'e104': AdditiveRisk.moderate,
  // Chinolingelb
  'e132': AdditiveRisk.moderate,
  // Indigokarmin
  'e133': AdditiveRisk.moderate,
  // Brillantblau FCF
  'e150b': AdditiveRisk.moderate,
  // Sulfit-Laugen-Zuckerkulör
  'e160b': AdditiveRisk.moderate,
  // Annatto (Bixin, Norbixin)
  'e171': AdditiveRisk.moderate,
  // Titandioxid (in EU mittlerweile verboten, oft noch in Datenbanken)
  'e172': AdditiveRisk.moderate,
  // Eisenoxide
  'e200': AdditiveRisk.moderate,
  // Sorbinsäure
  'e202': AdditiveRisk.moderate,
  // Kaliumsorbat
  'e203': AdditiveRisk.moderate,
  // Calciumsorbat
  'e220': AdditiveRisk.moderate,
  // Schwefeldioxid
  'e221': AdditiveRisk.moderate,
  // Natriumsulfit
  'e222': AdditiveRisk.moderate,
  // Natriumhydrogensulfit
  'e223': AdditiveRisk.moderate,
  // Natriummetabisulfit
  'e224': AdditiveRisk.moderate,
  // Kaliummetabisulfit
  'e280': AdditiveRisk.moderate,
  // Propionsäure
  'e281': AdditiveRisk.moderate,
  // Natriumpropionat
  'e282': AdditiveRisk.moderate,
  // Calciumpropionat
  'e283': AdditiveRisk.moderate,
  // Kaliumpropionat
  'e450': AdditiveRisk.moderate,
  // Diphosphate
  'e451': AdditiveRisk.moderate,
  // Triphosphate
  'e452': AdditiveRisk.moderate,
  // Polyphosphate
  'e481': AdditiveRisk.moderate,
  // Natriumstearoyl-2-lactylat
  'e482': AdditiveRisk.moderate,
  // Calciumstearoyl-2-lactylat
  'e520': AdditiveRisk.moderate,
  // Aluminiumsulfat
  'e521': AdditiveRisk.moderate,
  // Aluminiumnatriumsulfat
  'e541': AdditiveRisk.moderate,
  // Saures Natriumaluminiumphosphat
  'e631': AdditiveRisk.moderate,
  // Dinatriuminosinat
  'e635': AdditiveRisk.moderate,
  // Dinatrium-5′-ribonucleotid
  'e955': AdditiveRisk.moderate,
  // Sucralose
  'e965': AdditiveRisk.moderate,
  // Maltit

  // --- LOW RISK (GRÜN / UNBEDENKLICH) ---
  'e100': AdditiveRisk.low,
  // Kurkumin
  'e101': AdditiveRisk.low,
  // Riboflavin (Vit B2)
  'e140': AdditiveRisk.low,
  // Chlorophylle
  'e160a': AdditiveRisk.low,
  // Carotin
  'e160c': AdditiveRisk.low,
  // Paprikaextrakt
  'e161b': AdditiveRisk.low,
  // Lutein
  'e162': AdditiveRisk.low,
  // Beetenrot (Betanin)
  'e163': AdditiveRisk.low,
  // Anthocyane
  'e170': AdditiveRisk.low,
  // Calciumcarbonat
  'e260': AdditiveRisk.low,
  // Essigsäure
  'e270': AdditiveRisk.low,
  // Milchsäure
  'e290': AdditiveRisk.low,
  // Kohlendioxid
  'e296': AdditiveRisk.low,
  // Äpfelsäure
  'e300': AdditiveRisk.low,
  // Ascorbinsäure (Vit C)
  'e301': AdditiveRisk.low,
  // Natriumascorbat
  'e306': AdditiveRisk.low,
  // Tocopherol (Vit E)
  'e322': AdditiveRisk.low,
  // Lecithine
  'e330': AdditiveRisk.low,
  // Zitronensäure
  'e331': AdditiveRisk.low,
  // Natriumcitrate
  'e334': AdditiveRisk.low,
  // Weinsäure
  'e406': AdditiveRisk.low,
  // Agar-Agar
  'e410': AdditiveRisk.low,
  // Johannisbrotkernmehl
  'e412': AdditiveRisk.low,
  // Guarkernmehl
  'e414': AdditiveRisk.low,
  // Gummi arabicum
  'e415': AdditiveRisk.low,
  // Xanthan
  'e440': AdditiveRisk.low,
  // Pektine
  'e500': AdditiveRisk.low,
  // Natriumcarbonate (Backtriebmittel)
  'e901': AdditiveRisk.low,
  // Bienenwachs
  'e960': AdditiveRisk.low,
  // Steviaglycoside (Stevia)
  'e967': AdditiveRisk.low,
  // Xylit (Birkenzucker)
};
