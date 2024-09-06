import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class HomeDonorScreen extends StatefulWidget {
  const HomeDonorScreen({super.key});

  @override
  State<HomeDonorScreen> createState() => _HomeDonorScreenState();
}

class _HomeDonorScreenState extends State<HomeDonorScreen> {
  String? donorName;

  @override
  void initState() {
    super.initState();
    _loadDonorName();
  }

  Future<void> _loadDonorName() async {
    String? name = await StorageProvider().getUserName();
    setState(() {
      donorName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Doador $donorName' ?? 'Doador'),
        actions: [
          IconButton(
            onPressed: () {
              StorageProvider().logout();
              PageNavigator(ctx: context)
                  .nextPageOnly(page: const LoginScreen());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
