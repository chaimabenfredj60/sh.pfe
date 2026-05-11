class AppConfig {
  // Configuration des URLs
  static const String devBaseUrl = 'http://localhost:3000';
  static const String prodBaseUrl = 'https://api.cooptalite.com';
  static const String stagingBaseUrl = 'https://staging-api.cooptalite.com';

  // Configuration de l'environnement
  static const String environment =
      'development'; // development, staging, production

  /// Récupérer l'URL de base selon l'environnement
  static String getBaseUrl() {
    switch (environment) {
      case 'production':
        return prodBaseUrl;
      case 'staging':
        return stagingBaseUrl;
      case 'development':
      default:
        return devBaseUrl;
    }
  }

  /// Vérifier si on est en environnement de production
  static bool isProduction() => environment == 'production';

  /// Vérifier si on est en environnement de staging
  static bool isStaging() => environment == 'staging';

  /// Vérifier si on est en environnement de développement
  static bool isDevelopment() => environment == 'development';

  // Configuration des endpoints
  static const String authEndpoint = '/auth';
  static const String usersEndpoint = '/users';
  static const String offersEndpoint = '/offers';
  static const String actualiteEndpoint = '/actualite';
  static const String eventsEndpoint = '/events';
  static const String tasksEndpoint = '/todos';
  static const String chatsEndpoint = '/chats';

  // Configuration des timeouts (en secondes)
  static const int connectTimeout = 10;
  static const int sendTimeout = 10;
  static const int receiveTimeout = 10;

  // Configuration du logging
  static const bool enableLogging = true;
  static const bool enableNetworkLogging = true;
}
