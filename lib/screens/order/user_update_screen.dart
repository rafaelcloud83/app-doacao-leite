import 'package:doacao_leite/provider/order/update_user_provider.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/order/donor/home_donor_screen.dart';
import 'package:doacao_leite/screens/order/receiver/home_receiver_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/utils/snack_message.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserUpdateScreen extends StatefulWidget {
  const UserUpdateScreen({
    Key? key,
    this.id,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.password,
    this.role,
    this.active,
  }) : super(key: key);

  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? email;
  final String? password;
  final String? role;
  final bool? active;

  @override
  State<UserUpdateScreen> createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.name!;
      _phoneController.text = widget.phone!;
      _addressController.text = widget.address!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Alterar Dados',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Usuário número: ${widget.id}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome:',
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Nome",
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Telefone:',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: "Telefone",
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Endereço:',
                    ),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: "Endereço",
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer<UpdateUserProvider>(
                      builder: (context, updateUser, child) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) {
                        if (updateUser.response != '') {
                          if (updateUser.response == 'success') {
                            StorageProvider()
                                .saveUserName(_nameController.text.trim());
                            successMessage(
                              message: 'Usuário alterado',
                              ctx: context,
                            );
                            if (widget.role == 'RECEBEDOR') {
                              PageNavigator(ctx: context).nextPageOnly(
                                page: const HomeReceiverScreen(),
                              );
                            } else if (widget.role == 'DOADOR') {
                              PageNavigator(ctx: context).nextPageOnly(
                                page: const HomeDonorScreen(),
                              );
                            }
                          } else {
                            errorMessage(
                              message: updateUser.response,
                              ctx: context,
                            );
                          }
                        }
                        updateUser.clear();
                      },
                    );
                    return customButton(
                      status: updateUser.status,
                      tap: () {
                        if (_nameController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _addressController.text.isEmpty) {
                          errorMessage(
                            message: 'Preencha todos os campos',
                            ctx: context,
                          );
                        } else {
                          updateUser.updateUser(
                            id: widget.id!,
                            name: _nameController.text.trim(),
                            email: widget.email!,
                            password: widget.password!,
                            phone: _phoneController.text.trim(),
                            address: _addressController.text.trim(),
                            active: widget.active!,
                            role: widget.role!,
                          );
                        }
                      },
                      context: context,
                      text: 'Atualizar usuário',
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
