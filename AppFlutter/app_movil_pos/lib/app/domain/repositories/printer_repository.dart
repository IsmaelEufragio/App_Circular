import '../enums.dart';

abstract class PrinterRepository {
  Future<bool> configLcd(ConfigLcd estado);
}
