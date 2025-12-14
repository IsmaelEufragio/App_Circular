import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/colors.dart';
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

class _UserCrearLocationViewState extends State<UserCrearLocationView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<UserCrearController>().permisos();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App visible y activa (usuario regresó)
        print('App resumida - Usuario regresó');
        context.read<UserCrearController>().permisos();
        setState(() {});
        break;

      case AppLifecycleState.inactive:
        // App inactiva (llamada entrante, notificación)
        print('App inactiva');
        break;

      case AppLifecycleState.paused:
        // App en segundo plano (usuario salió)
        print('App pausada - Usuario salió');
        //_onAppPaused();
        break;

      case AppLifecycleState.detached:
        // App destruida por el sistema
        print('App detached');
        break;

      case AppLifecycleState.hidden:
        // App oculta (nuevo en algunas versiones)
        print('App oculta');
        break;
    }
  }

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

    final optionColonia = controller.state.departamentos
        .where((dep) => dep.id == controller.state.selectedDepartamentoId)
        .expand((dep) => dep.municipios)
        .where((mun) => mun.id == controller.state.selectedMunicipioId)
        .expand((mun) => mun.lugares)
        .where((lugar) => lugar.id == controller.state.selectedLugarId)
        .expand((lugar) => lugar.colonias)
        .map((colonia) {
      return DropdownMenuEntry(value: colonia.id, label: colonia.nombre);
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
                  setState(() {
                    controller.onSelectedLugarIdChanged(value);
                  });
                },
              ),
              UserDropdow(
                optionDeparta: optionColonia,
                label: 'Colonia',
                selectedValue: controller.state.selectedColonyId,
                onSelected: (value) {
                  if (value == null) return;
                  controller.onSelectedColonyIdChanged(value);
                },
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (controller.state.isPermissionGranted) {
                        controller.getCurrentLocation();
                      } else {
                        controller.openAppSettings();
                      }
                    },
                    icon: const Icon(Icons.my_location),
                    color: controller.state.isPermissionGranted
                        ? AppColors.sucess
                        : AppColors.info,
                  ),
                  Text(
                    controller.state.isPermissionGranted
                        ? ''
                        : 'Es necesario otorgar permisos de ubicación',
                    style: const TextStyle(color: AppColors.alert),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
