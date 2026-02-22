import 'package:flutter/material.dart';

import '../../../global/colors.dart';

class UserDropdow<T> extends StatelessWidget {
  const UserDropdow({
    super.key,
    required this.option,
    this.onSelected,
    this.validator,
    this.selectedValue,
    required this.label,
    this.isIcon = false,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  final List<DropdownMenuEntry<T>> option;
  final T? selectedValue;
  final String label;
  final Function(T?)? onSelected;
  final String? Function(T?)? validator;
  final AutovalidateMode autovalidateMode;
  final bool isIcon;
  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField<T>(
      initialSelection: selectedValue,
      onSelected: onSelected,
      label: isIcon ? Text(label) : null,
      width: isIcon ? MediaQuery.of(context).size.width - 80 : null,
      dropdownMenuEntries: option,
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
      leadingIcon: isIcon
          ? const Icon(
              Icons.business,
              color: Colors.blue,
            )
          : null,
      trailingIcon: Icon(
        Icons.arrow_drop_down,
        color: Colors.blue.shade700,
      ),
      validator: validator,
      autovalidateMode: autovalidateMode,
    );
  }
}
