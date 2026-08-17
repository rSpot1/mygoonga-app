/// Configuration de l'application cote client.
///
/// L'URL de base de l'API est fournie a la compilation via --dart-define,
/// pour eviter de coder en dur une URL differente entre developpement et
/// production. Voir le README pour les commandes exactes.
class AppConfig {
  AppConfig._();

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
    // 10.0.2.2 = alias de "localhost" de la machine hote depuis un emulateur
    // Android. Sur un appareil physique ou en production, passez toujours
    // --dart-define=API_BASE_URL=https://votre-api.onrender.com
  );

  static const bool debugAuthHeaders = bool.fromEnvironment(
    'DEBUG_AUTH_HEADERS',
    defaultValue: false,
    // Si true, ApiClient ajoute X-Debug-Uid / X-Debug-Role au lieu du token
    // Firebase, pour tester l'app contre une API en mode mock (USE_MOCK_DB=true)
    // sans avoir configure Firebase cote client. Ne jamais activer en production.
  );
}
