import 'package:flutter/material.dart';

Widget customTextField({
  String? hint,
  TextEditingController? controller,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(hintText: hint, border: InputBorder.none),
  );
}
