import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class DataInsertionScreen extends StatefulWidget {
  const DataInsertionScreen({super.key});

  @override
  State<DataInsertionScreen> createState() => _DataInsertionScreenState();
}

class _DataInsertionScreenState extends State<DataInsertionScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCollection;
  bool _isLoading = false;

  final Map<String, TextEditingController> _controllers = {
    'nomeDoTime': TextEditingController(),
    'pokemon1': TextEditingController(),
    'pokemon2': TextEditingController(),
    'pokemon3': TextEditingController(),
    'descricaoTime': TextEditingController(),
    'nomePokemon': TextEditingController(),
    'local': TextEditingController(),
    'nivel': TextEditingController(),
    'notas': TextEditingController(),
    'nomeItem': TextEditingController(),
    'categoria': TextEditingController(),
    'efeito': TextEditingController(),
    'jogoDeOrigem': TextEditingController(),
    'raridade': TextEditingController(),
  };

  bool _capturado = false;
  final List<String?> _teamSpriteUrls = [null, null, null];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controllers['pokemon1']!.addListener(() => _onPokemonNameChanged(0));
    _controllers['pokemon2']!.addListener(() => _onPokemonNameChanged(1));
    _controllers['pokemon3']!.addListener(() => _onPokemonNameChanged(2));
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    _debounce?.cancel();
    super.dispose();
  }

  void _onPokemonNameChanged(int slot) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      final pokemonName = _controllers['pokemon${slot + 1}']!.text;
      if (pokemonName.isNotEmpty) {
        _fetchSprite(pokemonName, slot);
      } else {
        setState(() {
          _teamSpriteUrls[slot] = null;
        });
      }
    });
  }

  Future<void> _fetchSprite(String pokemonName, int slot) async {
    try {
      final pokemon = await ApiService.fetchPokemonByName(pokemonName);
      setState(() {
        _teamSpriteUrls[slot] = pokemon.SpriteUrl;
      });
    } catch (e) {
      setState(() {
        _teamSpriteUrls[slot] = null;
      });
    }
  }

  void _clearControllers() {
    _controllers.forEach((_, controller) => controller.clear());
    setState(() {
      _capturado = false;
      _teamSpriteUrls[0] = null;
      _teamSpriteUrls[1] = null;
      _teamSpriteUrls[2] = null;
    });
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate() || _selectedCollection == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Por favor, selecione uma coleção e preencha todos os campos.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    Map<String, dynamic> data = {
      'userId': user.uid,
    };

    try {
      if (_selectedCollection == 'times_pokemon') {
        data.addAll({
          'nomeDoTime': _controllers['nomeDoTime']!.text,
          'pokemon1': _controllers['pokemon1']!.text,
          'pokemon2': _controllers['pokemon2']!.text,
          'pokemon3': _controllers['pokemon3']!.text,
          'descricao': _controllers['descricaoTime']!.text,
          'dataCriacao': Timestamp.now(),
        });
      } else if (_selectedCollection == 'encontros_pokemon') {
        final nomePokemonOriginal = _controllers['nomePokemon']!.text;
        final pokemonData = await ApiService.fetchPokemonByName(nomePokemonOriginal);
        
        data.addAll({
          'nomePokemon': nomePokemonOriginal,
          'nome_lowercase': nomePokemonOriginal.toLowerCase(),
          'spriteUrl': pokemonData.SpriteUrl, // <-- SALVANDO A URL DO SPRITE
          'local': _controllers['local']!.text,
          'nivel': int.tryParse(_controllers['nivel']!.text) ?? 0,
          'capturado': _capturado,
          'notas': _controllers['notas']!.text,
          'dataEncontro': Timestamp.now(),
        });
      } else if (_selectedCollection == 'itens_favoritos') {
        data.addAll({
          'nomeItem': _controllers['nomeItem']!.text,
          'categoria': _controllers['categoria']!.text,
          'efeito': _controllers['efeito']!.text,
          'jogoDeOrigem': _controllers['jogoDeOrigem']!.text,
          'raridade': _controllers['raridade']!.text,
          'dataAdicao': Timestamp.now(),
        });
      }

      await FirebaseFirestore.instance.collection(_selectedCollection!).add(data);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Dados salvos com sucesso!'),
            backgroundColor: Colors.green),
      );
      _clearControllers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erro ao salvar dados: $e'),
            backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novos Dados',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCollection,
                hint: const Text('Selecione onde salvar os dados'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCollection = newValue;
                  });
                },
                items: <String>[
                  'times_pokemon',
                  'encontros_pokemon',
                  'itens_favoritos'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.replaceAll('_', ' ').toUpperCase()),
                  );
                }).toList(),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              if (_selectedCollection != null) ..._buildFormFields(),
              const SizedBox(height: 20),
              if (_selectedCollection != null)
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveData,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redPokemon,
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('Salvar Dados',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    switch (_selectedCollection) {
      case 'times_pokemon':
        return [
          TextFormField(
              controller: _controllers['nomeDoTime'],
              decoration: const InputDecoration(labelText: 'Nome do Time')),
          TextFormField(
              controller: _controllers['pokemon1'],
              decoration: const InputDecoration(labelText: 'Pokémon 1')),
          TextFormField(
              controller: _controllers['pokemon2'],
              decoration: const InputDecoration(labelText: 'Pokémon 2')),
          TextFormField(
              controller: _controllers['pokemon3'],
              decoration: const InputDecoration(labelText: 'Pokémon 3')),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _teamSpriteUrls[index] != null
                    ? Image.network(
                        _teamSpriteUrls[index]!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error_outline, color: Colors.red),
                      )
                    : const Icon(Icons.question_mark, color: Colors.grey),
              );
            }),
          ),
          const SizedBox(height: 16),
          TextFormField(
              controller: _controllers['descricaoTime'],
              decoration: const InputDecoration(labelText: 'Descrição')),
        ];
      case 'encontros_pokemon':
        return [
          TextFormField(
              controller: _controllers['nomePokemon'],
              decoration: const InputDecoration(labelText: 'Nome do Pokémon')),
          TextFormField(
              controller: _controllers['local'],
              decoration: const InputDecoration(labelText: 'Local do Encontro')),
          TextFormField(
              controller: _controllers['nivel'],
              decoration: const InputDecoration(labelText: 'Nível'),
              keyboardType: TextInputType.number),
          SwitchListTile(
            title: const Text('Capturado?'),
            value: _capturado,
            onChanged: (bool value) {
              setState(() {
                _capturado = value;
              });
            },
          ),
          TextFormField(
              controller: _controllers['notas'],
              decoration: const InputDecoration(labelText: 'Notas Adicionais')),
        ];
      case 'itens_favoritos':
        return [
          TextFormField(
              controller: _controllers['nomeItem'],
              decoration: const InputDecoration(labelText: 'Nome do Item')),
          TextFormField(
              controller: _controllers['categoria'],
              decoration: const InputDecoration(labelText: 'Categoria')),
          TextFormField(
              controller: _controllers['efeito'],
              decoration: const InputDecoration(labelText: 'Efeito Principal')),
          TextFormField(
              controller: _controllers['jogoDeOrigem'],
              decoration: const InputDecoration(labelText: 'Jogo de Origem')),
          TextFormField(
              controller: _controllers['raridade'],
              decoration: const InputDecoration(labelText: 'Raridade')),
        ];
      default:
        return [Container()];
    }
  }
}