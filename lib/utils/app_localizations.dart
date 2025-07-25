import 'package:flutter/material.dart';

class AppLanguage {
  final String name;
  final String code;
  final String flag;

  AppLanguage(this.name, this.code, this.flag);
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final List<AppLanguage> supportedLanguages = [
    AppLanguage('English', 'en', '🇬🇧'),
    AppLanguage('हिंदी', 'hi', '🇮🇳'),
    AppLanguage('தமிழ்', 'ta', '🇮🇳'),
    AppLanguage('తెలుగు', 'te', '🇮🇳'),
    AppLanguage('ಕನ್ನಡ', 'kn', '🇮🇳'),
    AppLanguage('മലയാളം', 'ml', '🇮🇳'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'Netflix Clone',
      // Onboarding
      'onboarding_title_1': 'Enjoy on your TV',
      'onboarding_desc_1': 'Watch on Smart TVs, PlayStation, Xbox, Chromecast, Apple TV, Blu-ray players, and more.',
      'onboarding_title_2': 'Download your shows to watch offline',
      'onboarding_desc_2': 'Save your favorites easily and always have something to watch.',
      'onboarding_title_3': 'Watch everywhere',
      'onboarding_desc_3': 'Stream unlimited movies and TV shows on your phone, tablet, laptop, and TV.',
      'onboarding_title_4': 'Create profiles for kids',
      'onboarding_desc_4': 'Send kids on adventures with their favorite characters in a space made just for them—free with your membership.',
      'get_started': 'GET STARTED',
      'skip': 'SKIP',
      'next': 'NEXT',
      // Login
      'email': 'Email',
      'password': 'Password',
      'sign_in': 'Sign In',
      'forgot_password': 'Forgot Password?',
      'login_error': 'Login failed. Please try again.',
      'email_required': 'Email is required',
      'invalid_email': 'Enter a valid email',
      'password_required': 'Password is required',
      'password_short': 'Password must be at least 6 characters',
      // Home
      'trending': 'Trending Now',
      'latest': 'Latest Releases',
      'coming_soon': 'Coming Soon',
      'top_rated': 'Top Rated',
      // Search
      'search_movies': 'Search for movies...',
      'no_results': 'No results found',
      // Profile
      'profile': 'Profile',
      'account': 'Account',
      'settings': 'Settings',
      'language': 'Language',
      'sign_out': 'Sign Out',
    },
    'hi': {
      'app_name': 'नेटफ्लिक्स क्लोन',
      // Onboarding
      'onboarding_title_1': 'अपने टीवी पर आनंद लें',
      'onboarding_desc_1': 'स्मार्ट टीवी, PlayStation, Xbox, Chromecast, Apple TV, ब्लू-रे प्लेयर और बहुत कुछ पर देखें।',
      'onboarding_title_2': 'ऑफ़लाइन देखने के लिए अपने शो डाउनलोड करें',
      'onboarding_desc_2': 'अपने पसंदीदा को आसानी से सहेजें और हमेशा कुछ न कुछ देखने के लिए रखें।',
      'onboarding_title_3': 'हर जगह देखें',
      'onboarding_desc_3': 'अपने फ़ोन, टैबलेट, लैपटॉप और टीवी पर असीमित फ़िल्में और टीवी शो स्ट्रीम करें।',
      'onboarding_title_4': 'बच्चों के लिए प्रोफ़ाइल बनाएं',
      'onboarding_desc_4': 'बच्चों को उनके पसंदीदा पात्रों के साथ उनके लिए बनाई गई जगह में साहसिक कार्यों पर भेजें—आपकी सदस्यता के साथ मुफ्त।',
      'get_started': 'शुरू करें',
      'skip': 'छोड़ें',
      'next': 'अगला',
      // Login
      'email': 'ईमेल',
      'password': 'पासवर्ड',
      'sign_in': 'साइन इन करें',
      'forgot_password': 'पासवर्ड भूल गए?',
      'login_error': 'लॉगिन विफल। कृपया पुनः प्रयास करें।',
      'email_required': 'ईमेल आवश्यक है',
      'invalid_email': 'वैध ईमेल दर्ज करें',
      'password_required': 'पासवर्ड आवश्यक है',
      'password_short': 'पासवर्ड कम से कम 6 अक्षर का होना चाहिए',
      // Home
      'trending': 'ट्रेंडिंग',
      'latest': 'नई रिलीज़',
      'coming_soon': 'जल्द आ रहा है',
      'top_rated': 'टॉप रेटेड',
      // Search
      'search_movies': 'फ़िल्में खोजें...',
      'no_results': 'कोई परिणाम नहीं मिला',
      // Profile
      'profile': 'प्रोफ़ाइल',
      'account': 'खाता',
      'settings': 'सेटिंग्स',
      'language': 'भाषा',
      'sign_out': 'साइन आउट',
    },
    'ta': {
      'app_name': 'நெட்ஃபிளிக்ஸ் குளோன்',
      // Add Tamil translations
    },
    'te': {
      'app_name': 'నెట్‌ఫ్లిక్స్ క్లోన్',
      // Add Telugu translations
    },
    'kn': {
      'app_name': 'ನೆಟ್‌ಫ್ಲಿಕ್ಸ್ ಕ್ಲೋನ್',
      // Add Kannada translations
    },
    'ml': {
      'app_name': 'നെറ്റ്ഫ്ലിക്സ് ക്ലോൺ',
      // Add Malayalam translations
    },
  };

  String get appName => _localizedValues[locale.languageCode]?['app_name'] ?? _localizedValues['en']!['app_name']!;

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? _localizedValues['en']![key] ?? key;
  }
} 