import 'package:doacao_leite/provider/auth/auth_provider.dart';
import 'package:doacao_leite/provider/order/receiver/add_order_provider.dart';
import 'package:doacao_leite/provider/order/receiver/update_order_provider.dart';
import 'package:doacao_leite/provider/order/update_user_provider.dart';
import 'package:doacao_leite/provider/storage/storage_provider.dart';
import 'package:doacao_leite/screens/splash/splash_screen.dart';
import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => StorageProvider()),
        ChangeNotifierProvider(create: (_) => AddOrderProvider()),
        ChangeNotifierProvider(create: (_) => UpdateOrderProvider()),
        ChangeNotifierProvider(create: (_) => UpdateUserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doa Leite',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: primaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
