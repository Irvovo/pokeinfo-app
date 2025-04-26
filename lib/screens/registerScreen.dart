import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:flutter_application_1/utils/validator.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();}

class _RegisterScreenState extends State <RegisterScreen>{
final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PokeInfo', style: TextStyle(color: Colors.white, fontSize: 24),  ), backgroundColor: AppColors.redPokemon,
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
        // Logotipo
       Image.asset('imagens/logo.png',
       width: 100,
       height: 100,),

        const SizedBox(height: 16),

        // Campo de email
        SizedBox(
          width: 350,
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Digite um e-mail válido',
              border: OutlineInputBorder(),
            ),
          ),
        ),

        const SizedBox(height: 16),
        SizedBox(
          width: 350,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Digite uma senha válida de no mínimo 12 caracteres',
              border: OutlineInputBorder()
            )
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 350,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'DIgite um número de telefone',
              border: OutlineInputBorder()
            )
          ),
        ),
          const SizedBox(height: 24,),
          // botao entrar
          SizedBox(
            width: 350,
            child: ElevatedButton(
              onPressed: (){
                final email = emailController.text.trim();
                 if (Validator.isValidEmail(email)) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Conta cadastrada'),
                        content: Text('Seu email foi cadastrado!'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Ok'),
                          )
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Insira dados válidos'),
                        content: Text('Seu email não é válido'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), 
                          child: const Text('Ok'))]
                      ),
                    );
                  }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.redPokemon), 
              child: const Text('Cadastrar', style: TextStyle(color: Colors.white, fontSize: 18),)),
            
          ),
          const SizedBox(height: 12,),

   
      ],
    ),
  ),
)
);
}
}