import 'package:doacao_leite/models/user/user_response_model.dart';
import 'package:doacao_leite/provider/admin/get_all_users.dart';
import 'package:doacao_leite/screens/admin/admin_users_container.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Todos os Usuários',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<UserResponseModel>(
          future: GetAllUsers().getAllUsers(),
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
              if (snapshot.data!.users == null ||
                  snapshot.data!.users!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nenhum usuário encontrado',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView(
                  children: List.generate(
                    snapshot.data!.users!.length,
                    (index) {
                      final data = snapshot.data!.users![index];
                      return AdminUsersField(
                        id: '${data.id}',
                        name: data.name,
                        email: data.email,
                        //password: data.password,
                        phone: data.phone,
                        address: data.address,
                        active: data.active,
                        role: data.role,
                        createdAt: data.createdAt,
                        updatedAt: data.updatedAt,
                      );
                    },
                  ),
                );
              }
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
