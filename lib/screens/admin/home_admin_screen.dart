import 'package:doacao_leite/provider/admin/get_count_all_orders.dart';
import 'package:doacao_leite/provider/admin/get_count_all_orders_status.dart';
import 'package:doacao_leite/provider/admin/get_count_all_users.dart';
import 'package:doacao_leite/provider/admin/get_count_all_users_role.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:doacao_leite/widgets/button.dart';
import 'package:flutter/material.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  String? userName;
  String? countOrders;
  String? countOrdersStatusAguardando;
  String? countOrdersStatusDoado;
  String? countOrdersStatusConcluido;
  String? countUsers;
  String? countUsersRoleRecebedor;
  String? countUsersRoleDoador;

  @override
  void initState() {
    super.initState();
    _loadAdminName();
    _loadCountOrders();
    _loadCountOrdersStatus();
    _loadCountUsers();
    _loadCountUsersRole();
  }

  Future<void> _loadAdminName() async {
    String? name = await StorageProvider().getUserName();
    setState(() {
      userName = name;
    });
  }

  Future<void> _loadCountOrders() async {
    String? count = await GetCountAllOrders().getCountAllOrders();
    setState(() {
      countOrders = count;
    });
  }

  Future<void> _loadCountOrdersStatus() async {
    String? countAguandando =
        await GetCountAllOrdersStatus().getCountAllOrdersStatus('AGUARDANDO');
    String? countDoado =
        await GetCountAllOrdersStatus().getCountAllOrdersStatus('DOADO');
    String? countConcluido =
        await GetCountAllOrdersStatus().getCountAllOrdersStatus('CONCLUIDO');
    setState(() {
      countOrdersStatusAguardando = countAguandando;
      countOrdersStatusDoado = countDoado;
      countOrdersStatusConcluido = countConcluido;
    });
  }

  Future<void> _loadCountUsers() async {
    String? count = await GetCountAllUsers().getCountAllUsers();
    setState(() {
      countUsers = count;
    });
  }

  Future<void> _loadCountUsersRole() async {
    String? countRecebedor =
        await GetCountAllUsersRole().getCountAllUsersRole('RECEBEDOR');
    String? countDoador =
        await GetCountAllUsersRole().getCountAllUsersRole('DOADOR');
    setState(() {
      countUsersRoleRecebedor = countRecebedor;
      countUsersRoleDoador = countDoador;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'OLÁ $userName',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              StorageProvider().logout();
              PageNavigator(ctx: context).nextPageOnly(
                page: const LoginScreen(),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Total de usuários: $countUsers',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total de usuários RECEBEDOR: $countUsersRoleRecebedor',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total de usuários DOADOR: $countUsersRoleDoador',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Total de doações: $countOrders',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total de doações AGUARDANDO: $countOrdersStatusAguardando',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total de doações DOADO: $countOrdersStatusDoado',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total de doações CONCLUIDO: $countOrdersStatusConcluido',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            customButton(
              text: 'Ver Usuários',
              tap: () {
                //TODO: Implementar função para ver todos os usuários
              },
              context: context,
              status: false,
            ),
            const SizedBox(height: 40),
            customButton(
              text: 'Ver Doações',
              tap: () {
                //TODO: Implementar função para ver todas as doações
              },
              context: context,
              status: false,
            )
          ],
        ),
      ),
    );
  }
}
