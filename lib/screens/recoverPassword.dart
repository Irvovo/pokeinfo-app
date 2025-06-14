import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> sendRecoveryEmail() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, digite um e-mail válido.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      
      if (mounted) {
        Navigator.of(context).pop(); // Fecha a tela de recuperação
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Link de recuperação enviado para $email.'),
            backgroundColor: Colors.green,
          ),
        );
      }
      
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.code == 'user-not-found'
                ? 'Nenhum usuário encontrado para este e-mail.'
                : 'Ocorreu um erro. Tente novamente.'),
            backgroundColor: Colors.red,
          ),
        );
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
        title: const Text(
          'Recuperar Senha',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: AppColors.redPokemon,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.lightGrey,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        // ADICIONADO: Column para organizar os widgets verticalmente
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CORRIGIDO: Sintaxe do Image.asset
            Image.asset(
              'imagens/logo.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 24),
            const Text(
              'Digite seu e-mail para receber um link de recuperação de senha.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 350,
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Seu e-mail',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 350,
              height: 50,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: sendRecoveryEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redPokemon,
                      ),
                      child: const Text(
                        'Enviar E-mail',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}