import 'package:doacao_leite/models/user/user_response_model.dart';
import 'package:doacao_leite/provider/order/get_user_service.dart';
import 'package:doacao_leite/screens/order/user_update_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({
    super.key,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  bool? active;
  String? role;

  @override
  void initState() {
    super.initState();
    GetUserService().getUser().then((snapshot) {
      if (snapshot.users != null) {
        setState(() {
          id = snapshot.users![0].id!;
          name = snapshot.users![0].name!;
          email = snapshot.users![0].email!;
          password = snapshot.users![0].password!;
          phone = snapshot.users![0].phone!;
          address = snapshot.users![0].address!;
          active = snapshot.users![0].active!;
          role = snapshot.users![0].role!;
        });
      }
    });
  }

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
              PageNavigator(ctx: context).nextPage(
                page: UserUpdateScreen(
                  id: id,
                  name: name,
                  email: email,
                  password: password,
                  phone: phone,
                  address: address,
                  active: active,
                  role: role,
                ),
              );
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
              id = snapshot.data!.users![0].id!;
              name = snapshot.data!.users![0].name!;
              email = snapshot.data!.users![0].email!;
              password = snapshot.data!.users![0].password!;
              phone = snapshot.data!.users![0].phone!;
              address = snapshot.data!.users![0].address!;
              active = snapshot.data!.users![0].active!;
              role = snapshot.data!.users![0].role!;
              return CustomScrollView(
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
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Nome: $name',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Telefone: $phone',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Endereço: $address',
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
