import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/user_crear_controller.dart';
import '../widgets/user_dropdow.dart';

class UserCrearLocationView extends StatefulWidget {
  const UserCrearLocationView({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  @override
  State<UserCrearLocationView> createState() => _UserCrearLocationViewState();
}

class _UserCrearLocationViewState extends State<UserCrearLocationView> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserCrearController>();
    final optionDeparta = controller.state.departamentos.map((departamento) {
      return DropdownMenuEntry(
          value: departamento.id, label: departamento.nombre);
    }).toList();
    final optionMunicipio = controller.state.departamentos
        .where((dep) => dep.id == controller.state.selectedDepartamentoId)
        .expand((dep) => dep.municipios)
        .map((municipio) {
      return DropdownMenuEntry(
          value: municipio.id, label: municipio.descripcion);
    }).toList();

    final optionLugar = controller.state.departamentos
        .where((dep) => dep.id == controller.state.selectedDepartamentoId)
        .expand((dep) => dep.municipios)
        .where((mun) => mun.id == controller.state.selectedMunicipioId)
        .expand((mun) => mun.lugares)
        .map((lugar) {
      return DropdownMenuEntry(value: lugar.id, label: lugar.descripcion);
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserDropdow(
                optionDeparta: optionDeparta,
                label: 'Departamento',
                selectedValue: controller.state.selectedDepartamentoId,
                onSelected: (value) {
                  if (value == null) return;
                  setState(() {
                    controller.onSelectedDepartamentoIdChanged(value);
                  });
                },
              ),
              UserDropdow(
                optionDeparta: optionMunicipio,
                label: 'Municipio',
                selectedValue: controller.state.selectedMunicipioId,
                onSelected: (value) {
                  if (value == null) return;
                  setState(() {
                    controller.onSelectedMunicipioIdChanged(value);
                  });
                },
              ),
              UserDropdow(
                optionDeparta: optionLugar,
                label: 'Mas Conocido',
                selectedValue: controller.state.selectedLugarId,
                onSelected: (value) {
                  if (value == null) return;
                  controller.onSelectedLugarIdChanged(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
