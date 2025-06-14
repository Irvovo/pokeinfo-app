import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/infoScreen.dart';
import 'package:flutter_application_1/screens/mainMenuScreen.dart';
import 'package:flutter_application_1/screens/recoverPassword.dart';
import 'package:flutter_application_1/screens/registerScreen.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;
  bool _isLoading = false;

  Future<void> login() async {
    setState(() {
      _isLoading = true;
      errorMessage = null;
    });

    try {
      final email = emailController.text;
      final password = passwordController.text;

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainMenuScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        setState(() {
          errorMessage = 'E-mail ou senha inválidos.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorMessage = 'Senha incorreta.';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          errorMessage = 'O formato do e-mail é inválido.';
        });
      } else {
        setState(() {
          errorMessage = 'Ocorreu um erro. Tente novamente.';
        });
      }
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
        title: const Text('PokeInfo',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.lightGrey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('imagens/logo.png', width: 100, height: 100),
                const SizedBox(height: 16),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redPokemon),
                          child: const Text('Entrar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
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
                            MaterialPageRoute(
                                builder: (context) => const RecoverPassword()),
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
      ),
    );
  }
}