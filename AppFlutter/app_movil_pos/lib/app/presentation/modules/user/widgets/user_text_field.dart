import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  const UserTextField({
    super.key,
    required this.label,
    this.maxLines = 1,
    this.onChanged,
  });
  final String label;
  final int maxLines;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12), // curva sutil a la derecha
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12),
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
