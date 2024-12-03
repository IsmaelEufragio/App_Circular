import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScannerScreen(),
    );
  }
}

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ScannerService _scannerService = ScannerService();
  String _scanResult = "Esperando resultado del escaneo";

  void _getScanResult() {
    setState(() {
      // Actualiza el estado con el último resultado de escaneo
      _scanResult =
          _scannerService.lastScanResult ?? "No se ha escaneado nada aún";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _scanResult,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _getScanResult, // Llama al método cuando se presiona el botón
              child: const Text('Obtener resultado de escaneo'),
            ),
            ElevatedButton(
                onPressed: () async {
                  _scannerService.triggerScan();
                },
                child: const Text('Inicial Escaneo')),
            ElevatedButton(
                onPressed: () async {
                  _scannerService.getPantallaLCD(1);
                },
                child: const Text('Invernar la pantalla')),
          ],
        ),
      ),
    );
  }
}

class ScannerService {
  static const platform = MethodChannel('com.example.device/infrared');
  String? _lastScanResult;

  ScannerService() {
    platform.setMethodCallHandler(_handleScanResult);
  }

  Future<void> _handleScanResult(MethodCall call) async {
    if (call.method == "onScanResult") {
      String scanResult = call.arguments;
      _lastScanResult = scanResult;
      print("Scan result: $scanResult");
      // Aquí puedes manejar el resultado del escaneo
    }
  }

  String? get lastScanResult => _lastScanResult;

  Future<void> unregisterScannerReceiver() async {
    try {
      await platform.invokeMethod('unregisterReceiver');
    } on PlatformException catch (e) {
      print("Error unregistering: ${e.message}");
    }
  }

  Future<void> triggerScan() async {
    try {
      final String result = await platform.invokeMethod('triggerScan');
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
}
