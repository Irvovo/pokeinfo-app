import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'screens/loginScreen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'PokéInfo',
      theme: ThemeData(primarySwatch: Colors.red,
      appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: AppColors.white),
      ),
      ),
      
      home: const LoginScreen(),
    );
  }
}

