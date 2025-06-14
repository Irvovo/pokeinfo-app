import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/my_data_list_screen.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class MyFavoritesScreen extends StatelessWidget {
  const MyFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFavoriteCategory(
            context: context,
            title: 'Meus Times Pokémon',
            icon: Icons.group_work_outlined, // Ícone para Times
            collectionName: 'times_pokemon',
          ),
          const SizedBox(height: 16),
          _buildFavoriteCategory(
            context: context,
            title: 'Meus Itens Favoritos',
            icon: Icons.backpack_outlined, // Ícone para Itens
            collectionName: 'itens_favoritos',
          ),
           const SizedBox(height: 16),
          _buildFavoriteCategory(
            context: context,
            title: 'Meus Encontros',
            icon: Icons.location_on_outlined, // Ícone para Encontros
            collectionName: 'encontros_pokemon',
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCategory({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String collectionName,
  }) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, color: AppColors.redPokemon, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyDataListScreen(collectionName: collectionName),
            ),
          );
        },
      ),
    );
  }
}