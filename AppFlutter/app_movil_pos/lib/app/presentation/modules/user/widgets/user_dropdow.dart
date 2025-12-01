import 'package:flutter/material.dart';

import '../../../global/colors.dart';

class UserDropdow extends StatelessWidget {
  const UserDropdow({
    super.key,
    required this.optionDeparta,
    this.onSelected,
    this.selectedValue,
    required this.label,
  });

  final List<DropdownMenuEntry<String>> optionDeparta;
  final String? selectedValue;
  final String label;
  final Function(String?)? onSelected;
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: selectedValue,
      onSelected: onSelected,
      label: Text(label),
      width: MediaQuery.of(context).size.width - 80,
      dropdownMenuEntries: optionDeparta,
      inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.info, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.info, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.info, width: 2),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12),
          ),
        ),
        // Eliminar cualquier relleno que pueda crear bordes visibles
        contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        // Fondo transparente para evitar bordes no deseados
        filled: false,
        // Eliminar cualquier decoración de enfoque que agregue bordes
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      hintText: 'Seleccione un $label',
      leadingIcon: const Icon(
        Icons.business,
        color: Colors.blue,
      ),
      trailingIcon: Icon(
        Icons.arrow_drop_down,
        color: Colors.blue.shade700,
      ),
    );
  }
}
