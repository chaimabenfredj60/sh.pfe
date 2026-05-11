import 'package:dio/dio.dart';

class ApiService {
  // Pour le développement local sur Chrome
  static const String devBaseUrl = 'http://localhost:3000';

  // Si vous testez sur un émulateur Android, utilisez :
  // static const String devBaseUrl = 'http://10.0.2.2:3000';

  // Si vous testez sur un appareil réel ou iOS, utilisez l'IP de votre machine :
  // static const String devBaseUrl = 'http://192.168.1.X:3000';

  late Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: devBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Ajouter les intercepteurs pour le debug
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🌐 [REQUEST] ${options.method} ${options.path}');
          if (options.data != null) {
            print('📦 [DATA] ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
              '✅ [RESPONSE] ${response.statusCode} - ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('❌ [ERROR] ${e.message}');
          if (e.response != null) {
            print('📊 [STATUS] ${e.response?.statusCode}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Méthode GET
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Méthode POST
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Méthode PUT
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Méthode DELETE
  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Méthode PATCH
  Future<dynamic> patch(String path, {dynamic data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Méthode pour uploader un fichier CV
  Future<dynamic> uploadCvFile(String userId, String filePath,
      {Map<String, dynamic>? additionalData}) async {
    try {
      final file = await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      );

      final formData = FormData.fromMap({
        'file': file,
        if (additionalData != null) ...additionalData,
      });

      final response = await _dio.post(
        '/api/MyCvtech/upload/$userId',
        data: formData,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Méthode pour télécharger un fichier CV
  Future<dynamic> downloadCvFile(String filename) async {
    try {
      final response = await _dio.get(
        '/api/upload/$filename',
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Gérer les erreurs
  String _handleError(DioException error) {
    String errorMessage = 'Erreur réseau';

    if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage =
          'Timeout de connexion - Le serveur met trop de temps à répondre';
    } else if (error.type == DioExceptionType.sendTimeout) {
      errorMessage = 'Timeout d\'envoi - Impossible d\'envoyer les données';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Timeout de réception - Le serveur répond trop lentement';
    } else if (error.type == DioExceptionType.badResponse) {
      errorMessage =
          'Erreur ${error.response?.statusCode}: ${error.response?.statusMessage}';
    } else if (error.type == DioExceptionType.unknown) {
      errorMessage = 'Erreur inconnue: ${error.message}';
    }

    return errorMessage;
  }

  // Définir le token d'authentification
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Supprimer le token
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Ajouter un header personnalisé
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  // Obtenir le Dio instance pour une utilisation avancée
  Dio getDioInstance() => _dio;
}
