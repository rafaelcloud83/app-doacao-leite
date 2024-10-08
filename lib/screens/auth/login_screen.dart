import 'package:doacao_leite/provider/auth/auth_provider.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/admin/home_admin_screen.dart';
import 'package:doacao_leite/screens/auth/register_screen.dart';
import 'package:doacao_leite/screens/order/donor/home_donor_screen.dart';
import 'package:doacao_leite/screens/order/receiver/home_receiver_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 56),
                    Text(
                      'LOGIN',
                      style: GoogleFonts.ubuntu(
                        textStyle: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Image.asset("imagens/LeiteLogo.png"),
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
                          const SizedBox(height: 20),
                          Consumer<AuthenticationProvider>(
                              builder: (context, auth, child) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                if (auth.resMessage != '') {
                                  if (auth.resMessage == 'success') {
                                    successMessage(
                                      message: 'Login realizado com sucesso',
                                      ctx: context,
                                    );

                                    StorageProvider().getUserRole().then(
                                      (value) {
                                        if (value == 'DOADOR') {
                                          PageNavigator(ctx: context)
                                              .nextPageOnly(
                                            page: const HomeDonorScreen(),
                                          );
                                        } else if (value == 'RECEBEDOR') {
                                          PageNavigator(ctx: context)
                                              .nextPageOnly(
                                            page: const HomeReceiverScreen(),
                                          );
                                        } else if (value == 'ADMIN') {
                                          PageNavigator(ctx: context)
                                              .nextPageOnly(
                                            page: const HomeAdminScreen(),
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    errorMessage(
                                      message: auth.resMessage,
                                      ctx: context,
                                    );
                                  }
                                }
                                auth.clear();
                              },
                            );
                            return customButton(
                              text: "Entrar",
                              tap: () {
                                if (_emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty) {
                                  errorMessage(
                                    message: 'Todos os campos são obrigatórios',
                                    ctx: context,
                                  );
                                } else {
                                  auth.loginUser(
                                    context: context,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                }
                              },
                              context: context,
                              status: auth.isLoading,
                            );
                          }),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              PageNavigator(ctx: context).nextPage(
                                page: const RegisterScreen(),
                              );
                            },
                            child: const Text(
                              "Não tem cadastro? Clique aqui",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
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
