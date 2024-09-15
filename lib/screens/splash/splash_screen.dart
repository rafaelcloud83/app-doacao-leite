import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/admin/home_admin_screen.dart';
import 'package:doacao_leite/screens/auth/login_screen.dart';
import 'package:doacao_leite/screens/order/donor/home_donor_screen.dart';
import 'package:doacao_leite/screens/order/receiver/home_receiver_screen.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DOA LEITE',
              style: GoogleFonts.oleoScript(
                textStyle: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Image.asset("imagens/LeiteLogo150.png"),
          ],
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        StorageProvider().getToken().then((value) {
          if (value == '') {
            PageNavigator(ctx: context).nextPageOnly(
              page: const LoginScreen(),
            );
          } else {
            StorageProvider().getUserRole().then((value) {
              if (value == 'DOADOR') {
                PageNavigator(ctx: context).nextPageOnly(
                  page: const HomeDonorScreen(),
                );
              } else if (value == 'RECEBEDOR') {
                PageNavigator(ctx: context).nextPageOnly(
                  page: const HomeReceiverScreen(),
                );
              } else if (value == 'ADMIN') {
                PageNavigator(ctx: context).nextPageOnly(
                  page: const HomeAdminScreen(),
                );
              }
            });
          }
        });
      },
    );
  }
}
