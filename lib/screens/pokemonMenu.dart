import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/models/pokemon.dart';


class PokemonMenu extends StatefulWidget {
  const PokemonMenu({super.key});

  @override
  State<PokemonMenu> createState() => _PokemonMenuState();
}

class _PokemonMenuState extends State<PokemonMenu> {
  List<Pokemon>? pokemons;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  void fetchPokemon() async {
    try {
      final result = await ApiService.fetchPokemon(40);
      setState(() {
        pokemons = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        pokemons = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Pokemons',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: AppColors.blueSquirtle,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: pokemons!.length,
                itemBuilder: (context, i) {
                  final pokemon = pokemons![i];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(pokemon.SpriteUrl, height: 100),
                        const SizedBox(height: 8),
                        Text(
                          pokemon.name[0].toUpperCase() +
                              pokemon.name.substring(1),
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.white),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: pokemon.tipo.map((type) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Image.asset(
                                'assets/icons_type/$type.png',
                                width: 24,
                                height: 24,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16,),
                        Text('Info',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.white
                        ),)
                        
                      ],
                      
                    ),
                  );
                },
              ),
      ),
    );
  }
}
