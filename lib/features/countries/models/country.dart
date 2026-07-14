class Country {
  const Country({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.phone,
    required this.capital,
    required this.currency,
    required this.emoji,
    required this.continent,
    required this.languages,
  });

  final String code;
  final String name;
  final String nativeName;
  final String phone;
  final String? capital;
  final String? currency;
  final String emoji;
  final Continent continent;
  final List<CountryLanguage> languages;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        code: json['code'] as String,
        name: json['name'] as String,
        nativeName: (json['native'] as String?) ?? (json['name'] as String),
        phone: (json['phone'] as String?) ?? '',
        capital: json['capital'] as String?,
        currency: json['currency'] as String?,
        emoji: (json['emoji'] as String?) ?? '',
        continent: Continent.fromJson(json['continent'] as Map<String, dynamic>),
        languages: ((json['languages'] as List<dynamic>?) ?? const [])
            .map((item) => CountryLanguage.fromJson(item as Map<String, dynamic>))
            .toList(growable: false),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'native': nativeName,
        'phone': phone,
        'capital': capital,
        'currency': currency,
        'emoji': emoji,
        'continent': continent.toJson(),
        'languages': languages.map((language) => language.toJson()).toList(),
      };
}

class Continent {
  const Continent({required this.code, required this.name});
  final String code;
  final String name;

  factory Continent.fromJson(Map<String, dynamic> json) => Continent(
        code: json['code'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {'code': code, 'name': name};
}

class CountryLanguage {
  const CountryLanguage({required this.code, required this.name, required this.nativeName, required this.isRtl});
  final String code;
  final String name;
  final String nativeName;
  final bool isRtl;

  factory CountryLanguage.fromJson(Map<String, dynamic> json) => CountryLanguage(
        code: json['code'] as String,
        name: (json['name'] as String?) ?? '',
        nativeName: (json['native'] as String?) ?? '',
        isRtl: (json['rtl'] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() => {'code': code, 'name': name, 'native': nativeName, 'rtl': isRtl};
}
