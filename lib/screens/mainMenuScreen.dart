import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/RegionScreen.dart';
import 'package:flutter_application_1/screens/gamesScreen.dart';
import 'package:flutter_application_1/screens/pokemonMenu.dart';
import 'package:flutter_application_1/screens/typesScreen.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});
  
 @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State <MainMenuScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PokeInfo',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
    ),
    body: Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.lightGrey,
      child: Center(
        child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: [
          buildMenuButton('Pokemons', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const PokemonMenu()));
          }),
          buildMenuButton('Tipos', (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TypesScreen()));
          }),
          buildMenuButton('Regiões',(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegionScreen()));
          }),
          buildMenuButton('Jogos',(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
          }),

        ],
      ),
    )
    )
    
    );
    
  }
}

Widget buildMenuButton(String title, VoidCallback onPressed){
  return SizedBox(
  width: 150,
  height: 150,
  child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.redPokemon,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    ),
    child: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(color: AppColors.white, fontSize: 18)
    )
    )
  );
}