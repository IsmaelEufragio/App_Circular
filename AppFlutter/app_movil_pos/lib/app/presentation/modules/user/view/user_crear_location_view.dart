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

class _UserCrearLocationViewState extends State<UserCrearLocationView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    final controller = context.read<UserCrearController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.state.isPermissionGranted) {
        _sowDialogoPermiso();
      } else {
        controller.getCurrentLocation();
      }
    });
    WidgetsBinding.instance.addObserver(this);
  }

  _sowDialogoPermiso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permiso de Ubicación'),
          content: const Text(
              'Por favor, habilita el permiso de ubicación en la configuración de la aplicación.  Es neceario para mostrar al ubicacion de su negocio.'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<UserCrearController>().openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text('Abrir Configuración'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        // App visible y activa (usuario regresó)
        print('App resumida - Usuario regresó');
        final controller = context.read<UserCrearController>();
        final permiso = await controller.permisos();
        if (!permiso) {
          _sowDialogoPermiso();
        } else {
          controller.getCurrentLocation();
        }
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
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserDropdow<String>(
                isIcon: true,
                option: optionDeparta,
                label: 'Departamento',
                selectedValue: controller.state.selectedDepartamentoId,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validDepartamento,
                onSelected: (value) {
                  if (value == null ||
                      value == controller.state.selectedDepartamentoId) return;
                  setState(() {
                    controller.onSelectedDepartamentoIdChanged(value);
                    controller.onSelectedMunicipioIdChanged('');
                    controller.onSelectedLugarIdChanged('');
                    controller.onSelectedColonyIdChanged('');
                  });
                },
              ),
              UserDropdow<String>(
                key: ValueKey(
                    'municipio_${controller.state.selectedDepartamentoId}'),
                isIcon: true,
                option: optionMunicipio,
                label: 'Municipio',
                selectedValue: controller.state.selectedMunicipioId,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validMinicipio,
                onSelected: (value) {
                  if (value == null ||
                      value == controller.state.selectedMunicipioId) return;
                  setState(() {
                    controller.onSelectedMunicipioIdChanged(value);
                    controller.onSelectedLugarIdChanged('');
                    controller.onSelectedColonyIdChanged('');
                  });
                },
              ),
              UserDropdow<String>(
                key: ValueKey('lugar_${controller.state.selectedMunicipioId}'),
                isIcon: true,
                option: optionLugar,
                label: 'Mas Conocido',
                selectedValue: controller.state.selectedLugarId,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validLugar,
                onSelected: (value) {
                  if (value == null ||
                      value == controller.state.selectedLugarId) return;
                  setState(() {
                    controller.onSelectedLugarIdChanged(value);
                    controller.onSelectedColonyIdChanged('');
                  });
                },
              ),
              UserDropdow(
                key: ValueKey('colonia_${controller.state.selectedLugarId}'),
                isIcon: true,
                option: optionColonia,
                label: 'Colonia',
                selectedValue: controller.state.selectedColonyId,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: controller.validColinia,
                onSelected: (value) {
                  if (value == null) return;
                  controller.onSelectedColonyIdChanged(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
