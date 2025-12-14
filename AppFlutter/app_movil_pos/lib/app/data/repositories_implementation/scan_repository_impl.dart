import '../../domain/repositories/scan_repository.dart';
import '../services/local/scan_service.dart';

class ScanRepositoryImpl implements ScanRepository {
  ScanRepositoryImpl(this._scanService);

  final ScanService _scanService;

  @override
  Stream<String> get scanResults => _scanService.scanResults;

  @override
  Future<bool> triggerScan() async {
    return await _scanService.triggerScan();
  }

  @override
  void dispose() {
    _scanService.dispose();
  }
}
