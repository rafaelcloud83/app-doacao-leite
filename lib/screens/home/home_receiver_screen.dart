import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class HomeReceiverScreen extends StatefulWidget {
  const HomeReceiverScreen({super.key});

  @override
  State<HomeReceiverScreen> createState() => _HomeReceiverScreenState();
}

class _HomeReceiverScreenState extends State<HomeReceiverScreen> {
  String? receiverName;

  @override
  void initState() {
    super.initState();
    _loadReceiverName();
  }

  Future<void> _loadReceiverName() async {
    String? name = await StorageProvider().getUserName();
    setState(() {
      receiverName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Recebedor $receiverName' ?? 'Recebedor'),
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
