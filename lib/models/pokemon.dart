// lib/services/api_service.dart
// lib/models/pokemon.dart
class Pokemon {
  final String name;
  final String SpriteUrl;
  Pokemon({
    required this.name,
    required this.SpriteUrl
    });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      SpriteUrl: json['sprites']['front_default'],
    );
  }
}
