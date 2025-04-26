import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override

  Widget build(BuildContext context){
    final List<Map<String, String>> gamesInfo = [
      {'image': 'imagens/capa_jogos/1.jpg', 'name': 'Primeira Geração', 'year': '1996'},
      {'image': 'imagens/capa_jogos/2.jpg', 'name': 'Segunda Geração', 'year': '1999'},
      {'image': 'imagens/capa_jogos/3.jpg', 'name': 'Terceira Geração', 'year': '2002'},
      {'image': 'imagens/capa_jogos/4.jpg', 'name': 'Quarta Geração', 'year': '2006'},
      {'image': 'imagens/capa_jogos/5.jpg', 'name': 'Quinta Geração', 'year': '2010'},
      {'image': 'imagens/capa_jogos/6.jpg', 'name': 'Sexta Geração', 'year': '2013'},
      {'image': 'imagens/capa_jogos/7.jpg', 'name': 'Sétima Geração', 'year': '2016'},
      {'image': 'imagens/capa_jogos/8.jpg', 'name': 'Oitava Geração', 'year': '2019'},

    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text (
          'Jogos',
          style: TextStyle(color: AppColors.white, fontSize: 24),
        ),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
     body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: gamesInfo.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final game = gamesInfo[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      game['image']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        game['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lançado em ${game['year']}',
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      );
  }
}