import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();

  AppState._();

  // State Variables
  String _languageCode = 'en';
  bool _isLargeText = false;
  bool _isHighContrast = false;

  // Getters
  String get languageCode => _languageCode;
  bool get isLargeText => _isLargeText;
  bool get isHighContrast => _isHighContrast;

  // Actions
  void setLanguage(String code) {
    if (_languageCode != code) {
      _languageCode = code;
      notifyListeners();
    }
  }

  void setLargeText(bool enable) {
    if (_isLargeText != enable) {
      _isLargeText = enable;
      notifyListeners();
    }
  }

  void setHighContrast(bool enable) {
    if (_isHighContrast != enable) {
      _isHighContrast = enable;
      notifyListeners();
    }
  }

  // Translations
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Smart Agriculture',
      'welcome': 'Hello, Farmer!',
      'welcome_back': 'Welcome Back',
      'farm_overview': "Here is your farm's overview",
      'my_farm_view': 'My Farm View',
      'soil_moisture': 'Soil Moisture',
      'soil_temp': 'Soil Temp',
      'soil_npk': 'Soil NPK Levels',
      'optimal': 'Optimal',
      'suitable': 'Suitable',
      'balanced': 'Balanced',
      'home': 'Home',
      'sensors': 'Sensors',
      'chatbot': 'Chatbot',
      'crops': 'Crops',
      'live_updates': 'Live Updates Active',
      'temperature': 'Temperature',
      'nutrient_levels': 'Nutrient Levels (NPK)',
      'nitrogen': 'Nitrogen',
      'phosphorus': 'Phosphorus',
      'potassium': 'Potassium',
      'ai_analysis': 'AI Analysis Complete',
      'analysis_desc': 'Based on soil sensor readings from today.',
      'high_match': 'High Match',
      'moderate_match': 'Moderate Match',
      'excellent_match': 'Excellent Match',
      'settings': 'Settings',
      'my_profile': 'MY PROFILE',
      'my_farm': 'MY FARM',
      'alerts': 'ALERTS',
      'general': 'GENERAL',
      'weather_alert': 'Weather Alert',
      'water_alert': 'Water Alert',
      'crop_tips': 'Crop Tips',
      'price_updates': 'Price Updates',
      'language': 'Language',
      'help_support': 'Help & Support',
      'app_info': 'App Info',
      'save_changes': 'Save Changes',
      'exit_settings': 'Exit Settings',
      'exit_saved': 'Settings saved successfully!',
      'name': 'Name',
      'phone': 'Phone',
      'location': 'Location',
      'farm_size': 'Farm Size',
      'accessibility_options': 'Accessibility Options',
      'large_text': 'Large Text',
      'high_contrast': 'High Contrast',
      'screen_reader': 'Screen Reader'
    },
    'hi': {
      'app_title': 'स्मार्ट कृषि',
      'welcome': 'नमस्ते, किसान!',
      'welcome_back': 'वापसी पर स्वागत है',
      'farm_overview': 'यहाँ आपके खेत का अवलोकन है',
      'my_farm_view': 'मेरा खेत दृश्य',
      'soil_moisture': 'मिट्टी की नमी',
      'soil_temp': 'मिट्टी का तापमान',
      'soil_npk': 'मिट्टी एनपीके स्तर',
      'optimal': 'इष्टतम',
      'suitable': 'उपयुक्त',
      'balanced': 'संतुलित',
      'home': 'होम',
      'sensors': 'सेंसर',
      'chatbot': 'चैटबॉट',
      'crops': 'फसलें',
      'live_updates': 'लाइव अपडेट सक्रिय',
      'temperature': 'तापमान',
      'nutrient_levels': 'पोषक तत्व स्तर (NPK)',
      'nitrogen': 'नाइट्रोजन',
      'phosphorus': 'फास्फोरस',
      'potassium': 'पोटैशियम',
      'ai_analysis': 'एआई विश्लेषण पूर्ण',
      'analysis_desc': 'आज के मिट्टी सेंसर रीडिंग के आधार पर।',
      'high_match': 'उच्च मेल',
      'moderate_match': 'मध्यम मेल',
      'excellent_match': 'उत्कृष्ट मेल',
      'settings': 'सेटिंग्स',
      'my_profile': 'मेरी प्रोफाइल',
      'my_farm': 'मेरा खेत',
      'alerts': 'अलर्ट',
      'general': 'सामान्य',
      'weather_alert': 'मौसम अलर्ट',
      'water_alert': 'जल अलर्ट',
      'crop_tips': 'फसल सुझाव',
      'price_updates': 'मूल्य अपडेट',
      'language': 'भाषा',
      'help_support': 'सहायता और समर्थन',
      'app_info': 'ऐप जानकारी',
      'save_changes': 'परिवर्तन सहेजें',
      'exit_settings': 'सेटिंग्स से बाहर निकलें',
      'exit_saved': 'सेटिंग्स सफलतापूर्वक सहेजी गईं!',
      'name': 'नाम',
      'phone': 'फ़ोन',
      'location': 'स्थान',
      'farm_size': 'खेत का आकार',
      'accessibility_options': 'सुलभता विकल्प',
      'large_text': 'बड़ा पाठ',
      'high_contrast': 'उच्च कंट्रास्ट',
      'screen_reader': 'स्क्रीन रीडर'
    },
    'te': {
      'app_title': 'స్మార్ట్ వ్యవసాయం',
      'welcome': 'హలో, రైతు!',
      'welcome_back': 'స్వాగతం',
      'farm_overview': 'మీ పొలం యొక్క అవలోకనం ఇక్కడ ఉంది',
      'my_farm_view': 'నా పొలం వీక్షణ',
      'soil_moisture': 'నేల తేమ',
      'soil_temp': 'నేల ఉష్ణోగ్రత',
      'soil_npk': 'నేల NPK స్థాయిలు',
      'optimal': 'సరైనది',
      'suitable': 'తగినది',
      'balanced': 'సమతుల్యమైనది',
      'home': 'హోమ్',
      'sensors': 'సెన్సార్ల',
      'chatbot': 'చాట్‌బాట్',
      'crops': 'పంటలు',
      'live_updates': 'లైవ్ అప్‌డేట్‌లు యాక్టివ్‌గా ఉన్నాయి',
      'temperature': 'ఉష్ణోగ్రత',
      'nutrient_levels': 'పోషక స్థాయిలు (NPK)',
      'nitrogen': 'నైట్రోజన్',
      'phosphorus': 'భాస్వరం',
      'potassium': 'పొటాషియం',
      'ai_analysis': 'AI విశ్లేషణ పూర్తయింది',
      'analysis_desc': 'నేటి నేల సెన్సార్ రీడింగుల ఆధారంగా.',
      'high_match': 'అధిక సరిపోలిక',
      'moderate_match': 'మితమైన సరిపోలిక',
      'excellent_match': 'అద్భుతమైన సరిపోలిక',
      'settings': 'సెట్టింగ్‌లు',
      'my_profile': 'నా ప్రొఫైల్',
      'my_farm': 'నా వ్యవసాయం',
      'alerts': 'హెచ్చరికలు',
      'general': 'సాధారణ',
      'weather_alert': 'వాతావరణ హెచ్చరిక',
      'water_alert': 'నీటి హెచ్చరిక',
      'crop_tips': 'పంట చిట్కాలు',
      'price_updates': 'ధర నవీకరణలు',
      'language': 'భాష',
      'help_support': 'సహాయం & మద్దతు',
      'app_info': 'యాప్ సమాచారం',
      'save_changes': 'మార్పులను సేవ్ చేయండి',
      'exit_settings': 'నిష్క్రమించు',
      'exit_saved': 'సెట్టింగ్‌లు విజయవంతంగా సేవ్ చేయబడ్డాయి!',
      'name': 'పేరు',
      'phone': 'ఫోన్',
      'location': 'స్థానం',
      'farm_size': 'పొలం పరిమాణం',
      'accessibility_options': 'ప్రాప్యత ఎంపికలు',
      'large_text': 'పెద్ద వచనం',
      'high_contrast': 'అధిక కాంట్రాస్ట్',
      'screen_reader': 'స్క్రీన్ రీడర్'
    }
  };

  String getString(String key) {
    return _localizedValues[_languageCode]?[key] ?? _localizedValues['en']![key]!;
  }
}
