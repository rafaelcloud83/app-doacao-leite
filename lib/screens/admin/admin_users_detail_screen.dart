import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AdminUsersDetailScreen extends StatefulWidget {
  const AdminUsersDetailScreen({
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
    required this.updatedAt,
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
  final String updatedAt;

  @override
  State<AdminUsersDetailScreen> createState() => _AdminUsersDetailScreenState();
}

class _AdminUsersDetailScreenState extends State<AdminUsersDetailScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
    DateTime dateCreated = DateTime.parse(widget.createdAt!).toLocal();
    DateTime dateUpdated = DateTime.parse(widget.updatedAt).toLocal();
    String id = widget.id!;
    String name = widget.name!;
    String email = widget.email!;
    //String password = widget.password!;
    String phone = widget.phone!;
    String address = widget.address!;
    bool active = widget.active!;
    String role = widget.role!;
    String createdAt =
        DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dateCreated);
    String updatedAt =
        DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dateUpdated);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Detalhes do Usuário',
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
                    'Usuário número: $id',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nome: $name',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email: $email',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Telefone: $phone',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Endereço: $address',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ativo: $active',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Role: $role',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Data de Criação: $createdAt',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Data de Atualização: $updatedAt',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
