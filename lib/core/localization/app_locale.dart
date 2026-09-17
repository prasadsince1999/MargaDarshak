/// Supported Indian languages and localization definitions for Margadarshak.
library;

enum AppLanguage {
  english(code: 'en', nativeName: 'English', englishName: 'English'),
  hindi(code: 'hi', nativeName: 'हिन्दी', englishName: 'Hindi'),
  odia(code: 'or', nativeName: 'ଓଡ଼ିଆ', englishName: 'Odia'),
  telugu(code: 'te', nativeName: 'తెలుగు', englishName: 'Telugu'),
  tamil(code: 'ta', nativeName: 'தமிழ்', englishName: 'Tamil'),
  bengali(code: 'bn', nativeName: 'বাংলা', englishName: 'Bengali'),
  marathi(code: 'mr', nativeName: 'मराठी', englishName: 'Marathi'),
  kannada(code: 'kn', nativeName: 'ಕನ್ನಡ', englishName: 'Kannada');

  const AppLanguage({
    required this.code,
    required this.nativeName,
    required this.englishName,
  });

  final String code;
  final String nativeName;
  final String englishName;

  static AppLanguage fromCode(String? code) {
    if (code == null) return AppLanguage.english;
    return AppLanguage.values.firstWhere(
      (l) => l.code == code || l.name == code,
      orElse: () => AppLanguage.english,
    );
  }
}
