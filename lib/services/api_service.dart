
import 'dart:convert';
import 'package:flutter_application_1/models/regions.dart';
import 'package:flutter_application_1/models/types.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/pokemon.dart';

class ApiService {
  static Future<List<Pokemon>> fetchPokemon(int count) async {
    List<Pokemon> pokemons = [];
    for (int i = 1; i <= count; i++) {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$i'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        pokemons.add(Pokemon.fromJson(data));
      } else {
        throw Exception('Falha ao carregar dados do Pokémon');
      }
    }
    return pokemons;
  }
 
 
 
 
 static Future<List<Regions>> fetchRegions() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/region/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      return results.map((regionJson) => Regions.fromJson(regionJson)).toList();
    } else {
      throw Exception('Falha ao carregar dados da região');
    }
  }
 
 
 
 
 
 static Future<List<Types>> fetchTypes() async{
     final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/type/'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List results = data['results'];

    List<Types> types = [];

    for (var item in results) {
      final detailResponse = await http.get(Uri.parse(item['url']));
      if (detailResponse.statusCode == 200) {
        final detailData = json.decode(detailResponse.body);
        types.add(Types.fromJson(detailData));
      }
    }

    return types;
  } else {
    throw Exception('Erro ao carregar tipos de Pokémon');
  }
}
}

