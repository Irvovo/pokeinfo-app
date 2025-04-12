class Types {
  final String type;
  final List<String> typeDamage;

  Types({
    required this.type,
    required this.typeDamage,
  });

  factory Types.fromJson(Map<String, dynamic> json) {
    final damageList = json['damage_relations']['double_damage_to'] as List;
    final damageNames = damageList.map((e) => e['name'] as String).toList();

    return Types(
      type: json['name'],
      typeDamage: damageNames.isEmpty ? ['nenhum'] : damageNames,
    );
  }
}