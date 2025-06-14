import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class EditItemScreen extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> initialData;

  const EditItemScreen({
    super.key,
    required this.documentId,
    required this.initialData,
  });

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _categoriaController;
  late TextEditingController _efeitoController;
  late TextEditingController _jogoController;
  late TextEditingController _raridadeController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.initialData['nomeItem']);
    _categoriaController = TextEditingController(text: widget.initialData['categoria']);
    _efeitoController = TextEditingController(text: widget.initialData['efeito']);
    _jogoController = TextEditingController(text: widget.initialData['jogoDeOrigem']);
    _raridadeController = TextEditingController(text: widget.initialData['raridade']);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _categoriaController.dispose();
    _efeitoController.dispose();
    _jogoController.dispose();
    _raridadeController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final updatedData = {
      'nomeItem': _nomeController.text,
      'categoria': _categoriaController.text,
      'efeito': _efeitoController.text,
      'jogoDeOrigem': _jogoController.text,
      'raridade': _raridadeController.text,
    };

    try {
      await FirebaseFirestore.instance
          .collection('itens_favoritos')
          .doc(widget.documentId)
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item atualizado com sucesso!'), backgroundColor: Colors.green),
      );
      Navigator.of(context).pop();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Item', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.redPokemon,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(controller: _nomeController, decoration: const InputDecoration(labelText: 'Nome do Item')),
              TextFormField(controller: _categoriaController, decoration: const InputDecoration(labelText: 'Categoria')),
              TextFormField(controller: _efeitoController, decoration: const InputDecoration(labelText: 'Efeito Principal')),
              TextFormField(controller: _jogoController, decoration: const InputDecoration(labelText: 'Jogo de Origem')),
              TextFormField(controller: _raridadeController, decoration: const InputDecoration(labelText: 'Raridade')),
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