import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class EditTeamScreen extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> initialData;

  const EditTeamScreen({
    super.key,
    required this.documentId,
    required this.initialData,
  });

  @override
  State<EditTeamScreen> createState() => _EditTeamScreenState();
}

class _EditTeamScreenState extends State<EditTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _pokemon1Controller;
  late TextEditingController _pokemon2Controller;
  late TextEditingController _pokemon3Controller;
  late TextEditingController _descricaoController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.initialData['nomeDoTime']);
    _pokemon1Controller = TextEditingController(text: widget.initialData['pokemon1']);
    _pokemon2Controller = TextEditingController(text: widget.initialData['pokemon2']);
    _pokemon3Controller = TextEditingController(text: widget.initialData['pokemon3']);
    _descricaoController = TextEditingController(text: widget.initialData['descricao']);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _pokemon1Controller.dispose();
    _pokemon2Controller.dispose();
    _pokemon3Controller.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final updatedData = {
      'nomeDoTime': _nomeController.text,
      'pokemon1': _pokemon1Controller.text,
      'pokemon2': _pokemon2Controller.text,
      'pokemon3': _pokemon3Controller.text,
      'descricao': _descricaoController.text,
    };

    try {
      await FirebaseFirestore.instance
          .collection('times_pokemon')
          .doc(widget.documentId)
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Time atualizado com sucesso!'), backgroundColor: Colors.green),
      );
      Navigator.of(context).pop();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteTeam() async {
     try {
      await FirebaseFirestore.instance
          .collection('times_pokemon')
          .doc(widget.documentId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Time excluído com sucesso!'), backgroundColor: Colors.green),
      );
      Navigator.of(context).pop();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Time', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.redPokemon,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirmar Exclusão'),
                  content: const Text('Tem certeza que deseja excluir este time?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                      _deleteTeam();
                    }, child: const Text('Excluir', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(controller: _nomeController, decoration: const InputDecoration(labelText: 'Nome do Time')),
              TextFormField(controller: _pokemon1Controller, decoration: const InputDecoration(labelText: 'Pokémon 1')),
              TextFormField(controller: _pokemon2Controller, decoration: const InputDecoration(labelText: 'Pokémon 2')),
              TextFormField(controller: _pokemon3Controller, decoration: const InputDecoration(labelText: 'Pokémon 3')),
              TextFormField(controller: _descricaoController, decoration: const InputDecoration(labelText: 'Descrição')),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveChanges,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.redPokemon, padding: const EdgeInsets.symmetric(vertical: 16)),
                child: _isLoading ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : const Text('Salvar Alterações', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}