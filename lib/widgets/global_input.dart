// lib/widgets/global_input.dart

import 'package:flutter/material.dart';

class GlobalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType keyboardType;

  // ⬅️ AJOUTEZ CE NOUVEAU PARAMÈTRE !
  final String? Function(String? value)? validator;

  const GlobalTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    // ⬅️ INITIALISEZ-LE DANS LE CONSTRUCTEUR
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // ⚠️ IMPORTANT : Le widget doit utiliser TextFormField (pas juste TextField)
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      // ⬅️ PASSEZ LA PROPRIÉTÉ AU WIDGET INTERNE
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}