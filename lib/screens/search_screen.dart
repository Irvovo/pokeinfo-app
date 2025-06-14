import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  bool _isLoading = false;
  String _sortOrder = 'dataEncontro';
  bool _sortDescending = true;

  Future<void> _performSearch() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
    });

    String searchTerm = _searchController.text.trim().toLowerCase();

    Query query = FirebaseFirestore.instance
        .collection('encontros_pokemon')
        .where('userId', isEqualTo: user.uid);

    if (searchTerm.isNotEmpty) {
      query = query
          .where('nome_lowercase', isGreaterThanOrEqualTo: searchTerm)
          .where('nome_lowercase', isLessThanOrEqualTo: '$searchTerm\uf8ff');
    }

    query = query.orderBy(_sortOrder, descending: _sortDescending);

    try {
      final QuerySnapshot snapshot = await query.get();
      setState(() {
        _searchResults = snapshot.docs;
      });
    } catch (e) {
      print("Erro ao realizar busca: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _setSortOrder(String field, bool descending) {
    setState(() {
      _sortOrder = field;
      _sortDescending = descending;
    });
    _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Buscar Encontros', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Digite o nome do Pokémon',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: [
              ActionChip(
                label: const Text('Mais Recentes'),
                onPressed: () => _setSortOrder('dataEncontro', true),
                backgroundColor: _sortOrder == 'dataEncontro'
                    ? AppColors.redPokemon
                    : Colors.grey.shade300,
              ),
              ActionChip(
                label: const Text('Nome (A-Z)'),
                onPressed: () => _setSortOrder('nome_lowercase', false),
                backgroundColor: _sortOrder == 'nome_lowercase'
                    ? AppColors.redPokemon
                    : Colors.grey.shade300,
              ),
              ActionChip(
                label: const Text('Nível (Maior)'),
                onPressed: () => _setSortOrder('nivel', true),
                backgroundColor: _sortOrder == 'nivel'
                    ? AppColors.redPokemon
                    : Colors.grey.shade300,
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isEmpty
                    ? const Center(child: Text('Nenhum resultado encontrado.'))
                    : ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final data = _searchResults[index].data()
                              as Map<String, dynamic>;
                          final date =
                              (data['dataEncontro'] as Timestamp).toDate();
                          final spriteUrl = data['spriteUrl'] as String?;

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.grey.shade200,
                                child: spriteUrl != null && spriteUrl.isNotEmpty
                                    ? Image.network(
                                        spriteUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.error_outline),
                                      )
                                    : const Icon(Icons.question_mark),
                              ),
                              title: Text(data['nomePokemon'] ?? 'N/A',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle:
                                  Text('Local: ${data['local']} - Nível: ${data['nivel']}'),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(DateFormat('dd/MM/yy').format(date)),
                                  if (data['capturado'] == true)
                                    const Icon(Icons.check_circle, color: Colors.green, size: 20)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}