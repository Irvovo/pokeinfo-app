import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/infoScreen.dart';
import 'package:flutter_application_1/screens/mainMenuScreen.dart';
import 'package:flutter_application_1/screens/recoverPassword.dart';
import 'package:flutter_application_1/screens/registerScreen.dart';
import 'package:flutter_application_1/utils/validator.dart';
import '../theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    if (!Validator.isValidEmail(email)) {
      setState(() {
        errorMessage = 'E-mail inválido';
      });
      return;
    }

    if (!Validator.isValidPassword(password)) {
      setState(() {
        errorMessage = 'A senha deve ter no mínimo 6 caracteres';
      });
      return;
    }

    setState(() {
      errorMessage = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainMenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeInfo', style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.lightGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('imagens/logo.png', width: 100, height: 100),
              const SizedBox(height: 16),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Digite seu e-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Digite sua senha',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.redPokemon),
                  child: const Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 263,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Cadastrar-se',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RecoverPassword()),
                        );
                      },
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
             
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoScreen()),
                  );
                },
                child: const Text(
                  'Sobre',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
