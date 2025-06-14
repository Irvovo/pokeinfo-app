import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/edit_item_screen.dart';
import 'package:flutter_application_1/screens/edit_team_screen.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class MyDataListScreen extends StatelessWidget {
  final String collectionName;

  const MyDataListScreen({super.key, required this.collectionName});

  String _getTitle() {
    switch (collectionName) {
      case 'times_pokemon':
        return 'Meus Times Pokémon';
      case 'itens_favoritos':
        return 'Meus Itens Favoritos';
      case 'encontros_pokemon':
        return 'Meus Encontros';
      default:
        return 'Meus Dados';
    }
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    String title = 'Dado sem título';
    String subtitle = 'ID: ${document.id}';
    Widget? editScreen;

    switch (collectionName) {
      case 'times_pokemon':
        title = data['nomeDoTime'] ?? 'Time sem nome';
        subtitle = '${data['pokemon1']}, ${data['pokemon2']}, ${data['pokemon3']}';
        editScreen = EditTeamScreen(documentId: document.id, initialData: data);
        break;
      case 'itens_favoritos':
        title = data['nomeItem'] ?? 'Item sem nome';
        subtitle = 'Categoria: ${data['categoria']}';
        editScreen = EditItemScreen(documentId: document.id, initialData: data);
        break;
      case 'encontros_pokemon':
        title = data['nomePokemon'] ?? 'Pokémon sem nome';
        subtitle = 'Local: ${data['local']} - Nível: ${data['nivel']}';
        // Criar EditEncounterScreen se necessário
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 4,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.edit),
        onTap: () {
          if (editScreen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => editScreen!),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Usuário não logado.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(), style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(collectionName)
            .where('userId', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Nenhum dado encontrado."));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Ocorreu um erro."));
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return _buildListItem(context, documents[index]);
            },
          );
        },
      ),
    );
  }
}