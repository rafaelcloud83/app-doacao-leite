import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';

void successMessage({String? message, BuildContext? ctx}) {
  ScaffoldMessenger.of(ctx!).showSnackBar(
    SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: white),
      ),
      backgroundColor: greenAlert,
      duration: const Duration(milliseconds: 1300),
    ),
  );
}

void errorMessage({String? message, BuildContext? ctx}) {
  ScaffoldMessenger.of(ctx!).showSnackBar(
    SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: white),
      ),
      backgroundColor: redAlert,
      duration: const Duration(milliseconds: 2500),
    ),
  );
}
