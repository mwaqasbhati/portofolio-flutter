enum AppEnvironment { qa, production }

class EnvironmentConfig {
  EnvironmentConfig._();

  static const String _env = String.fromEnvironment('APP_ENV', defaultValue: 'qa');

  static AppEnvironment get environment =>
      _env == 'production' ? AppEnvironment.production : AppEnvironment.qa;

  static String get baseUrl {
    switch (environment) {
      case AppEnvironment.production:
        return 'https://prod.example.com';
      case AppEnvironment.qa:
      return 'https://dummyjson.com';
    }
  }
}
