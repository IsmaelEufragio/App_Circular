import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../global/colors.dart';

class UserField extends StatelessWidget {
  const UserField({
    super.key,
    required this.label,
    this.value = '',
    this.maxLines = 1,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.autovalidateMode,
    this.inputFormatters,
  });

  final String label;
  final String value;
  final int maxLines;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: AppColors.sucess,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.info,
          fontSize: 16,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.info, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12), // curva sutil a la derecha
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.info, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12),
          ),
        ),
      ),
      obscureText: keyboardType == TextInputType.visiblePassword,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
    );
  }
}
