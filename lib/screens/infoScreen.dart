import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        backgroundColor: Colors.redAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'PokeInfo é um aplicativo criado para consulta de informações sobre Pokémon. '
          'Ele permite ver tipos, regiões, sprites e outros dados de forma simples. '
          'Criado por Irving Marinho',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
