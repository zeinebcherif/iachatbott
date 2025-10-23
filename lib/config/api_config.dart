class ApiConfig {
  // Récupère la clé depuis les arguments de lancement
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  // Vérifie si la clé est valide
  static bool get isApiKeyValid => geminiApiKey.isNotEmpty;
}