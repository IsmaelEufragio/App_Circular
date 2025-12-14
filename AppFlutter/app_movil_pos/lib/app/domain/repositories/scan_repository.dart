abstract class ScanRepository {
  Stream<String> get scanResults;
  Future<bool> triggerScan();
  void dispose();
}
