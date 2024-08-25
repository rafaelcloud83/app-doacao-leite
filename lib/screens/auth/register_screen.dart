import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedRadio = "RECEBEDOR";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _passwordController.clear();
    _passwordConfirmController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 32, left: 8, right: 8),
              //color: white,
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CADASTRE-SE',
                      style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      //padding: const EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: "Nome Completo",
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            hintText: "Telefone",
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          maxLines: 2,
                          controller: _addressController,
                          decoration: const InputDecoration(
                            hintText: "Endereço",
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: "Senha",
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          controller: _passwordConfirmController,
                          decoration: const InputDecoration(
                            hintText: "Confirmar Senha",
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Sou Recebedor ou Doador?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                            const Text('Recebedor',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 48),
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
                            const Text('Doador',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        customButton(
                          text: "Cadastrar",
                          tap: () {
                            //TODO: fazer cadastro
                            //se estiver tudo ok volta pro login
                            PageNavigator(ctx: context)
                                .nextPageOnly(page: const LoginScreen());
                          },
                          context: context,
                          status: false,
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*   @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedRadio = "RECEBEDOR";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
              color: white,
              padding: const EdgeInsets.all(16),
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
                      child: Column(children: [
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
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 64,
                              vertical: 16,
                            ),
                          ),
                          onPressed: () {
                            //TODO: Implementar registrar
                          },
                          child: const Text("Entrar"),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 */