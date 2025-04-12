import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/types.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key});
  @override
  State<TypesScreen> createState() => _TypesScreenState();

}

class _TypesScreenState extends State <TypesScreen>{
  List<Types>? types;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTypes();
  }
  void fetchTypes() async {
    try{
      final result = await ApiService.fetchTypes();
      setState((){
        types = result;
        isLoading = false;
      });
    } catch (e){
      setState(() {
        types = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        title: const Text(
          'Tipos de Pokemon',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: AppColors.softBlack,
        centerTitle: true,
    ),
    body: isLoading ? const Center(child: CircularProgressIndicator()): 
    ListView.builder(
      itemCount: types!.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i){
        final type = types![i];
        return ExpansionTile(
          title: Text(
            type.type.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Causa dano duplo em: ${type.typeDamage}',
                style: const TextStyle(fontSize: 14),
              )
              )
          ],
          );

      }
      )

    );
  }

}