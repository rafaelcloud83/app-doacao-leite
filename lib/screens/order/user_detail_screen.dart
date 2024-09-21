import 'package:doacao_leite/models/user/user_response_model.dart';
import 'package:doacao_leite/provider/order/get_user_service.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({
    Key? key,
    this.id,
    this.name,
    this.email,
    //this.password,
    this.phone,
    this.address,
    this.active,
    this.role,
    this.createdAt,
    this.updatedAt,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? email;
  //final String? password;
  final String? phone;
  final String? address;
  final bool? active;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Meus Dados',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //TODO: ir para tela de edição do usuário
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<UserResponseModel>(
          future: GetUserService().getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Ocorreu um erro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              initializeDateFormatting('pt_BR', null);
              DateTime dateCreated =
                  DateTime.parse(snapshot.data!.users![0].createdAt!).toLocal();
              String createdAt =
                  DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dateCreated);
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Usuário número: ${snapshot.data!.users![0].id}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nome: ${snapshot.data!.users![0].name}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Telefone: ${snapshot.data!.users![0].phone}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Endereço: ${snapshot.data!.users![0].address}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Data de Criação: $createdAt',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
