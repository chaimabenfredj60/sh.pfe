import 'package:flutter/material.dart';

/// Interface de base pour tous les écrans
/// Cela permet à tous les écrans d'accepter isDarkMode et language
abstract class ThemeAwareScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;

  const ThemeAwareScreen({
    required this.isDarkMode,
    required this.language,
    Key? key,
  }) : super(key: key);

  String translate(String key, String language);
}

/// Classe utilitaire pour la traduction
class ScreenTranslations {
  static const Map<String, Map<String, String>> translations = {
    'en': {
      'dashboard': 'Dashboard',
      'offer': 'Offer',
      'offers': 'Offers',
      'rh': 'RH',
      'personal': 'Personal',
      'news': 'News & Events',
      'events': 'Events',
      'jackpot': 'My Jackpot',
      'applications': 'My Applications',
      'communication': 'Communication',
      'profile': 'Profile',
      'logout': 'Logout',
      'my_cra': 'My CRA',
      'my_expenses': 'My Expenses',
      'calendar': 'Calendar',
      'my_tasks': 'My Tasks',
      'cra_tracking': 'CRA Tracking',
      'postes': 'Job Offers',
      'chats': 'Chats',
      'feedbacks': 'Feedbacks',
      'documents': 'Documents',
      'send_feedback': 'Send feedback to admin support',
      'describe_feedback': 'Describe your feedback',
      'send': 'Send',
      'feedback_sent': 'Feedback sent successfully!',
    },
    'fr': {
      'dashboard': 'Tableau de bord',
      'offer': 'Offre',
      'offers': 'Offres',
      'rh': 'RH',
      'personal': 'Personnel',
      'news': 'Actualités et Événements',
      'events': 'Événements',
      'jackpot': 'Mon Jackpot',
      'applications': 'Mes Candidatures',
      'communication': 'Communication',
      'profile': 'Profil',
      'logout': 'Déconnexion',
      'my_cra': 'Mon CRA',
      'my_expenses': 'Mes Dépenses',
      'calendar': 'Calendrier',
      'my_tasks': 'Mes Tâches',
      'cra_tracking': 'Suivi CRA',
      'postes': 'Offres d\'emploi',
      'chats': 'Discussions',
      'feedbacks': 'Retours',
      'documents': 'Documents',
      'send_feedback': 'Envoyer un retour au support admin',
      'describe_feedback': 'Décrivez votre retour',
      'send': 'Envoyer',
      'feedback_sent': 'Retour envoyé avec succès!',
    },
  };

  static String translate(String key, String language) {
    return translations[language]?[key] ?? key;
  }
}
