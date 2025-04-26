
class Pokemon {
  final String name;
  final String SpriteUrl;
  final List<String> tipo;
  Pokemon({
    required this.name,
    required this.SpriteUrl,
    required this.tipo
    });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> types = (json['types'] as List).map((tipo) => tipo['type']['name'] as String).toList();
    
    return Pokemon(
      name: json['name'],
      SpriteUrl: json['sprites']['front_default'],
      tipo: types,
    );
  }
}
