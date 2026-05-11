import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApiProvider extends ChangeNotifier {
  late ApiService _apiService;
  String? _authToken;
  Map<String, dynamic>? _currentUser;
  bool _isLoading = false;

  ApiProvider() {
    _apiService = ApiService();
  }

  // Getters
  ApiService get apiService => _apiService;
  String? get authToken => _authToken;
  Map<String, dynamic>? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _authToken != null;

  // Setters
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ===================
  // Méthodes d'authentification
  // ===================

  /// Connexion avec email et mot de passe
  Future<bool> login(String email, String password) async {
    setLoading(true);
    try {
      final response = await _apiService.post(
        '/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response != null && response['access_token'] != null) {
        _authToken = response['access_token'];
        _apiService.setAuthToken(_authToken!);

        // Charger les infos utilisateur (le back retourne 'user_data')
        if (response['user_data'] != null) {
          _currentUser = response['user_data'];
        }

        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      print('❌ Erreur de connexion: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Inscription
  Future<bool> register(
      String email, String password, String firstName, String lastName) async {
    setLoading(true);
    try {
      final response = await _apiService.post(
        '/api/auth/register',
        data: {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
        },
      );

      if (response != null && response['access_token'] != null) {
        _authToken = response['access_token'];
        _apiService.setAuthToken(_authToken!);
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      print('❌ Erreur d\'inscription: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Déconnexion
  Future<void> logout() async {
    try {
      if (_authToken != null) {
        await _apiService.post('/api/auth/logout');
      }
    } catch (e) {
      print('⚠️ Erreur lors de la déconnexion: $e');
    } finally {
      _authToken = null;
      _currentUser = null;
      _apiService.removeAuthToken();
      notifyListeners();
    }
  }

  // ===================
  // Méthodes utilisateur
  // ===================

  /// Récupérer le profil utilisateur
  Future<Map<String, dynamic>?> getUserProfile() async {
    setLoading(true);
    try {
      final response = await _apiService.get('/users/profile');

      if (response != null) {
        _currentUser = response;
        notifyListeners();
        return response;
      }

      return null;
    } catch (e) {
      print('❌ Erreur lors de la récupération du profil: $e');
      return null;
    } finally {
      setLoading(false);
    }
  }

  /// Mettre à jour le profil utilisateur
  Future<bool> updateUserProfile(Map<String, dynamic> profileData) async {
    setLoading(true);
    try {
      final response = await _apiService.put(
        '/users/profile',
        data: profileData,
      );

      if (response != null) {
        _currentUser = response;
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      print('❌ Erreur lors de la mise à jour du profil: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Récupérer tous les utilisateurs
  Future<List<dynamic>> getUsers() async {
    setLoading(true);
    try {
      final response = await _apiService.get('/users');
      return response is List ? response : [];
    } catch (e) {
      print('❌ Erreur lors de la récupération des utilisateurs: $e');
      return [];
    } finally {
      setLoading(false);
    }
  }

  // ===================
  // Méthodes d'appels API génériques
  // ===================

  /// Appel GET générique
  Future<dynamic> apiGet(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      return await _apiService.get(endpoint, queryParameters: queryParams);
    } catch (e) {
      print('❌ Erreur GET $endpoint: $e');
      rethrow;
    }
  }

  /// Appel POST générique
  Future<dynamic> apiPost(String endpoint, {required dynamic data}) async {
    try {
      return await _apiService.post(endpoint, data: data);
    } catch (e) {
      print('❌ Erreur POST $endpoint: $e');
      rethrow;
    }
  }

  /// Appel PUT générique
  Future<dynamic> apiPut(String endpoint, {required dynamic data}) async {
    try {
      return await _apiService.put(endpoint, data: data);
    } catch (e) {
      print('❌ Erreur PUT $endpoint: $e');
      rethrow;
    }
  }

  /// Appel DELETE générique
  Future<dynamic> apiDelete(String endpoint) async {
    try {
      return await _apiService.delete(endpoint);
    } catch (e) {
      print('❌ Erreur DELETE $endpoint: $e');
      rethrow;
    }
  }
}
