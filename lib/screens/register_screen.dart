import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  String? _selectedRadio = "RECEBEDOR";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CADASTRE-SE',
                style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Nome Completo",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: "Senha",
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: _passwordConfirmController,
                      decoration: const InputDecoration(
                        hintText: "Confirmar Senha",
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Sou Recebedor ou Doador?'),
                    Row(
                      children: [
                        Radio<String>(
                          value: "RECEBEDOR",
                          groupValue: _selectedRadio,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedRadio = value;
                              debugPrint(value);
                            });
                          },
                        ),
                        const Text('Recebedor'),
                        const SizedBox(width: 16),
                        Radio<String>(
                          value: 'DOADOR',
                          groupValue: _selectedRadio,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedRadio = value;
                              debugPrint(value);
                            });
                          },
                        ),
                        const Text('Doador'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // TODO implementar cadastro e validações
                        if (_passwordController.text ==
                            _passwordConfirmController.text) {
                          //registra e volta ao login
                          const snackBar = SnackBar(
                            content: Text('Usuario cadastrado com sucesso'),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('As senhas não correspondem'),
                            backgroundColor: Colors.redAccent,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text("Cadastrar"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
