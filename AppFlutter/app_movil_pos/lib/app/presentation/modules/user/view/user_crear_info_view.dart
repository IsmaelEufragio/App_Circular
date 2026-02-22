import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/user/business_category/business_category.dart';
import '../../../global/colors.dart';
import '../controller/user_crear_controller.dart';
import '../widgets/user_text_field.dart';

class CrearUserInfoView extends StatelessWidget {
  const CrearUserInfoView({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserCrearController>();
    final items = controller.state.optiondCategories.map((category) {
      return DropdownItem<BusinessCategory>(
        label: category.descripcion,
        value: category,
        selected: controller.state.selectedCategories.contains(category),
      );
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserField(
                label: 'Nombre Comercial',
                maxLines: 1,
                onChanged: controller.onNombreComercialChanged,
                value: controller.state.nombreComercial,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validNombreComercial,
              ),
              UserField(
                label: 'Description',
                maxLines: 1,
                onChanged: controller.onDescripcionChanged,
                value: controller.state.descripcion,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validDescripcion,
              ),
              UserField(
                label: 'RTN - Institucion o del fundadador',
                maxLines: 1,
                onChanged: controller.onRtnChanged,
                value: controller.state.rtn,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validRtn,
              ),
              // Selector múltiple de categorías usando el widget genérico
              const SizedBox(height: 20),
              MultiDropdown<BusinessCategory>(
                searchDecoration: const SearchFieldDecoration(
                  hintText: 'Buscar categoría',
                ),
                items: items,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: true,
                searchEnabled: true,
                chipDecoration: const ChipDecoration(
                  backgroundColor: AppColors.sucess,
                  wrap: true,
                  runSpacing: 2,
                  spacing: 10,
                ),
                fieldDecoration: const FieldDecoration(
                  hintText: 'Rubro del negocio',
                  hintStyle: TextStyle(
                    color: AppColors.info,
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(Icons.business, color: AppColors.sucess),
                  showClearIcon: false,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.info, width: 2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.info, width: 2),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
                dropdownDecoration: const DropdownDecoration(
                  backgroundColor: AppColors.info,
                  marginTop: 2,
                  maxHeight: 500,
                ),
                dropdownItemDecoration: const DropdownItemDecoration(
                  backgroundColor: AppColors.info,
                  selectedBackgroundColor: AppColors.primary,
                  selectedTextColor: AppColors.fondo,
                  textColor: AppColors.fondo,
                  selectedIcon: Icon(Icons.check_box, color: AppColors.fondo),
                ),
                validator: (dropdownItems) {
                  if (dropdownItems == null) {
                    return controller.validCategories(null);
                  }
                  final categories = <BusinessCategory>[];
                  for (final item in dropdownItems) {
                    categories.add(item.value);
                  }
                  return controller.validCategories(categories);
                },
                onSelectionChange: (selectedItems) {
                  controller.onSelectedCategoriesChanged(selectedItems);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
