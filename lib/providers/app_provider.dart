import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'en'; // 'en' or 'fr'

  bool get isDarkMode => _isDarkMode;
  String get language => _language;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLanguage(String lang) {
    if (lang == 'en' || lang == 'fr') {
      _language = lang;
      notifyListeners();
    }
  }

  ThemeData get theme {
    if (_isDarkMode) {
      return ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF00B4A6),
        scaffoldBackgroundColor: const Color(0xFF1e1e1e),
      );
    }
    return ThemeData.light().copyWith(
      primaryColor: const Color(0xFF00B4A6),
      scaffoldBackgroundColor: Colors.white,
    );
  }
}

class AppLocalizations {
  static final Map<String, Map<String, String>> _translations = {
    'en': {
      'dashboard': 'Dashboard',
      'offer': 'Offer',
      'rh': 'RH',
      'personal': 'Personal',
      'news_events': 'News & Events',
      'my_jackpot': 'My Jackpot',
      'my_applications': 'My Applications',
      'communication': 'Communication',
      'profile': 'Profile',
      'my_application': 'My Application',
      'logout': 'Logout',
      'chats': 'Chats',
      'support': 'Support',
      'send_feedback': 'Send feedback to admin support',
      'describe_feedback': 'Describe your feedback',
      'send': 'Send',
      'feedback_sent': 'Feedback sent successfully!',
      'first_name': 'First name',
      'enter_first_name': 'Enter first name',
      'last_name': 'Last name',
      'enter_last_name': 'Enter last name',
      'category': 'Category',
      'select': 'Select...',
      'phone': 'Phone',
      'enter_phone': 'Enter phone',
      'email': 'Email',
      'enter_email': 'Enter email',
      'daily_role': 'Daily Role',
      'enter_daily_role': 'Enter daily role',
      'summary': 'Summary',
      'enter_summary': 'Enter summary',
      'informations': 'Informations Générales',
      'domain_skills': 'Domain Skills',
      'professional_skills': 'Professional Skills',
      'experiences': 'Experiences',
      'technical_skills': 'Technical Skills',
      'education_history': 'Education history',
      'languages': 'Languages',
      'certifications': 'Certifications',
      'training': 'Training',
      'save': 'Save',
      'add_new': 'Add New',
      'no_items': 'No items added yet',
    },
    'fr': {
      'dashboard': 'Tableau de bord',
      'offer': 'Offre',
      'rh': 'RH',
      'personal': 'Personnel',
      'news_events': 'Actualités & Événements',
      'my_jackpot': 'Mon Jackpot',
      'my_applications': 'Mes Applications',
      'communication': 'Communication',
      'profile': 'Profil',
      'my_application': 'Mon Application',
      'logout': 'Déconnexion',
      'chats': 'Discussions',
      'support': 'Support',
      'send_feedback': 'Envoyer un retour au support admin',
      'describe_feedback': 'Décrivez votre retour',
      'send': 'Envoyer',
      'feedback_sent': 'Retour envoyé avec succès!',
      'first_name': 'Prénom',
      'enter_first_name': 'Entrer le prénom',
      'last_name': 'Nom de famille',
      'enter_last_name': 'Entrer le nom de famille',
      'category': 'Catégorie',
      'select': 'Sélectionner...',
      'phone': 'Téléphone',
      'enter_phone': 'Entrer le téléphone',
      'email': 'Email',
      'enter_email': 'Entrer l\'email',
      'daily_role': 'Rôle quotidien',
      'enter_daily_role': 'Entrer le rôle quotidien',
      'summary': 'Résumé',
      'enter_summary': 'Entrer le résumé',
      'informations': 'Informations Générales',
      'domain_skills': 'Compétences du domaine',
      'professional_skills': 'Compétences professionnelles',
      'experiences': 'Expériences',
      'technical_skills': 'Compétences techniques',
      'education_history': 'Historique éducatif',
      'languages': 'Langues',
      'certifications': 'Certifications',
      'training': 'Formation',
      'save': 'Enregistrer',
      'add_new': 'Ajouter nouveau',
      'no_items': 'Aucun élément ajouté',
    },
  };

  static String translate(String key, String language) {
    return _translations[language]?[key] ?? key;
  }
}
