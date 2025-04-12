import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/regions.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
class RegionScreen extends StatefulWidget {
  const RegionScreen({super.key});
  @override
  State<RegionScreen> createState() => _RegionScreenState();

}
class _RegionScreenState extends State <RegionScreen>{
  List<Regions> regions = [];
  bool isLoading = true;
  @override
  void initState(){
    super.initState();
    fetchRegions();
  }
  void fetchRegions() async {
    try {
      final result = await ApiService.fetchRegions();
      setState((){
        regions = result;
        isLoading = false;
      });
    }catch (e){
      setState((){
        isLoading = false;
      });
    }
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          'Regiões do mundo',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: AppColors.yellowPikachu,
        centerTitle: true,
    ),
    body: isLoading ? const Center(child: CircularProgressIndicator()): 
 ListView.builder(
  itemCount: regions.length,
  padding: const EdgeInsets.all(16),
  itemBuilder: (context, index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.red),
        title: Text(
          regions[index].name.toUpperCase(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // ação ao tocar
        },
      ),
    );
  },
)

    );
  }
}