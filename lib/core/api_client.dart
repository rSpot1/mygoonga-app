import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_config.dart';

/// Exception applicative uniforme pour toutes les erreurs d'appel API,
/// avec le message renvoye par le serveur (champ "detail" de FastAPI) quand
/// il est disponible, pour un affichage direct et comprehensible a l'utilisateur.
class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Enveloppe unique autour de Dio : ajoute automatiquement le token Firebase
/// (ou les en-tetes de debug) a chaque requete, et normalise les erreurs.
class ApiClient {
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final headers = await _authHeaders();
          options.headers.addAll(headers);
          handler.next(options);
        },
      ),
    );
  }

  static final ApiClient instance = ApiClient._internal();
  late final Dio _dio;

  Dio get dio => _dio;

  /// En-tetes debug optionnels, utilises uniquement quand l'app est compilee
  /// avec --dart-define=DEBUG_AUTH_HEADERS=true, pour tester contre une API
  /// demarree en mode mock sans configurer Firebase cote client.
  String? debugUid;
  String? debugRole;

  Future<Map<String, String>> _authHeaders() async {
    if (AppConfig.debugAuthHeaders && debugUid != null) {
      return {
        'X-Debug-Uid': debugUid!,
        if (debugRole != null) 'X-Debug-Role': debugRole!,
      };
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return {};
    final token = await user.getIdToken();
    return {'Authorization': 'Bearer $token'};
  }

  ApiException mapError(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      String? detail;
      if (data is Map && data['detail'] != null) {
        detail = data['detail'].toString();
      }
      return ApiException(
        detail ?? error.message ?? 'Une erreur réseau est survenue.',
        statusCode: error.response?.statusCode,
      );
    }
    return ApiException(error.toString());
  }
}
