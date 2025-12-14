import '../../domain/enums.dart';
import '../../domain/repositories/printer_repository.dart';
import '../services/local/printer_service.dart';

class PrinterRepositoryImpl implements PrinterRepository {
  PrinterRepositoryImpl({
    required this.printerService,
  });

  final PrinterService printerService;

  @override
  Future<bool> configLcd(ConfigLcd estado) {
    return printerService.configLcd(estado);
  }
}
