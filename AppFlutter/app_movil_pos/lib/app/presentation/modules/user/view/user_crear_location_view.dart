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
  //final ScannerService _scannerService = ScannerService();
  final String _scanResult = 'Esperando resultado del escaneo';

  void _getScanResult() {
    setState(() {
      // Actualiza el estado con el último resultado de escaneo
      //_scanResult =
      //_scannerService.lastScanResult ?? 'No se ha escaneado nada aún';
    });
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
              Text(_scanResult, style: const TextStyle(color: Colors.black)),
              ElevatedButton(
                onPressed: () {
                  //controller.permisos();
                  controller.triggerScan();
                  //_scannerService.triggerScan();
                },
                child: const Text('Iniciar Scaner'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.configLcd();
                },
                child: const Text('Dormir Pantalla'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.getCurrentLocation();
                },
                child: const Text('Ubicacion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class ScannerService {
  ScannerService() {
    platform.setMethodCallHandler(_handleScanResult);
  }
  static const platform = MethodChannel('com.example.device/scanner');
  String? _lastScanResult;

  Future<void> _handleScanResult(MethodCall call) async {
    if (call.method == 'onScanDataReceived') {
      try {
        dynamic scanResult = call.arguments;
        print('Resultado del escaneo recibido: $scanResult');

        final Json jsonMap = Json.from(scanResult as Map);

        if (jsonMap['data'] is Map) {
          jsonMap['data'] = Json.from(jsonMap['data'] as Map);
        }

        // Ahora sí parsear el resultado
        var result = Response<Scan>.fromJson(
          jsonMap,
          (json) => Scan.fromJson(json as Json),
        );

        // Acceder a los datos
        print('Success: ${result.success}');
        print('Message: ${result.message}');
        print('QSC Code: ${result.data.qscCode}');
      } catch (e) {
        print('Error parsing scan result: $e');
      }
    }
  }

  String? get lastScanResult => _lastScanResult;

  Future<void> unregisterScannerReceiver() async {
    try {
      await platform.invokeMethod('unregisterReceiver');
    } on PlatformException catch (e) {
      print('Error unregistering: ${e.message}');
    }
  }

  Future<void> triggerScan() async {
    try {
      final dynamic result = await platform.invokeMethod('triggerScan');
      print(result); // "Scan triggered successfully"
    } on PlatformException catch (e) {
      print("Failed to trigger scan: '${e.message}'.");
    }
  }

  Future<Map<String, dynamic>?> getPantallaLCD(int stadoLCD) async {
    try {
      final result =
          await platform.invokeMethod('configLcd', {'parametro': stadoLCD});
      print(result);
      // Cast explícito al tipo esperado
      return Map<String, dynamic>.from(result as Map);
    } on PlatformException catch (e) {
      print("Failed to get printer directory: '${e.message}'.");
      return null;
    }
  }
}*/
