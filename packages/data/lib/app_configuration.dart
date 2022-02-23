enum Environment { dev, prod }

class AppConfiguration {
  final String baseUrl;
  final String flavorName;
  static late AppConfiguration _instance;

  static const String environment = 'ENV';

  factory AppConfiguration.of() {
    final Environment flavor =
        Environment.values.byName(const String.fromEnvironment(environment));

    switch (flavor) {
      case Environment.dev:
        return AppConfiguration._internal('https://pokeapi.co', flavor.name);
      default:
        return AppConfiguration._internal('https://pokeapi.co', flavor.name);
    }
  }

  AppConfiguration._internal(this.baseUrl, this.flavorName);

  static AppConfiguration get instance => _instance;
}
