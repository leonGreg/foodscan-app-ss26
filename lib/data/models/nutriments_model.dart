class NutrimentsModel {
  const NutrimentsModel({
    this.energyKcal100g,
    this.fat100g,
    this.sugars100g,
    this.salt100g,
  });

  final double? energyKcal100g;
  final double? fat100g;
  final double? sugars100g;
  final double? salt100g;

  factory NutrimentsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const NutrimentsModel();
    }

    return NutrimentsModel(
      energyKcal100g: _toDouble(json['energy-kcal_100g']),
      fat100g: _toDouble(json['fat_100g']),
      sugars100g: _toDouble(json['sugars_100g']),
      salt100g: _toDouble(json['salt_100g']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'energy-kcal_100g': energyKcal100g,
      'fat_100g': fat100g,
      'sugars_100g': sugars100g,
      'salt_100g': salt100g,
    };
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
