import 'package:doacao_leite/utils/colors.dart';
import 'package:flutter/material.dart';

Widget customButton({
  VoidCallback? tap,
  bool? status = false,
  String? text = 'Save',
  BuildContext? context,
}) {
  return GestureDetector(
    onTap: status == true ? null : tap,
    child: Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: status == false ? primaryColor : grey,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context!).size.width,
      child: Text(
        status == false ? text! : 'Aguarde...',
        style: TextStyle(
          color: black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
