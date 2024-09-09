import 'package:doacao_leite/provider/auth/auth_provider.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    _selectedRadio = '';
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
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Text(
                          'CADASTRE-SE',
                          style: GoogleFonts.ubuntu(
                            textStyle: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                          //maxLines: 2,
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
                                  //debugPrint(value);
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
                                  //debugPrint(value);
                                });
                              },
                            ),
                            const Text('Doador',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        //botão Cadastrar
                        Consumer<AuthenticationProvider>(
                            builder: (context, auth, child) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            //WidgetsBinding.instance!.addPostFrameCallback(
                            (_) {
                              //verificação de mensagem do auth_provider
                              if (auth.resMessage != '') {
                                if (auth.resMessage == 'success') {
                                  //se for sucesso
                                  successMessage(
                                    message: 'Cadastro realizado com sucesso',
                                    ctx: context,
                                  );
                                  PageNavigator(ctx: context)
                                      .nextPageOnly(page: const LoginScreen());
                                } else {
                                  //se for erro
                                  errorMessage(
                                    message: auth.resMessage,
                                    ctx: context,
                                  );
                                }
                              }
                              auth.clear(); //limpa mensagem de autenticação
                            },
                          );
                          return customButton(
                            text: "Cadastrar",
                            tap: () {
                              //validação dos campos
                              if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  _nameController.text.isEmpty ||
                                  _phoneController.text.isEmpty ||
                                  _addressController.text.isEmpty ||
                                  _passwordConfirmController.text.isEmpty) {
                                //campos vazios
                                errorMessage(
                                    message: 'Todos os campos são obrigatórios',
                                    ctx: context);
                              } else if (_passwordController.text !=
                                  _passwordConfirmController.text) {
                                //senhas diferentes
                                errorMessage(
                                    message:
                                        'Confirmar senha está diferente da Senha',
                                    ctx: context);
                              } else {
                                auth.registerUser(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  address: _addressController.text.trim(),
                                  role: _selectedRadio.toString(),
                                  password: _passwordController.text.trim(),
                                  context: context,
                                );
                              }
                            },
                            context: context,
                            status: auth.isLoading,
                          );
                        }),
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
