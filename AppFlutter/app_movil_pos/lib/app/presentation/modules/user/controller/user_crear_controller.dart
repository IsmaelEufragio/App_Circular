import 'dart:async';

import '../../../../domain/enums.dart';
import '../../../../domain/models/ubicacion/department/department.dart';
import '../../../../domain/models/user/business_category/business_category.dart';
import '../../../../domain/repositories/geolocator_repository.dart';
import '../../../../domain/repositories/printer_repository.dart';
import '../../../../domain/repositories/scan_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/user_crear_state.dart';

class UserCrearController extends StateNotifier<UserCrearState> {
  UserCrearController(
    super.state, {
    required this.geolocatorRepository,
    required this.scanRepository,
    required this.printerService,
  }) {
    _scanSubscription = scanRepository.scanResults.listen(_handleScanResult);
  }

  final GeolocatorRepository geolocatorRepository;
  final ScanRepository scanRepository;
  final PrinterRepository printerService;

  late final StreamSubscription _scanSubscription;

  void _handleScanResult(String result) {
    print('Código escaneado Controller: $result');
  }

  Future<void> triggerScan() async {
    // Bloquear la UI mientras el trigger se está enviando/esperando
    //state = state.copyWith(isLoading: true, scanMessage: 'Activando escáner...');

    try {
      final response = await scanRepository.triggerScan();
      print('Respuesta triggerScan Controller: $response');
    } catch (e) {
      /*state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        scanMessage: 'Error desconocido al escanear',
      );*/
    }
  }

  Future<void> configLcd() async {
    final succes = await printerService.configLcd(ConfigLcd.sleep);
    print('Respuesta configLcd Controller: $succes');
  }

  Future<void> getCurrentLocation() async {
    await geolocatorRepository.checkPermissions();
    final location = await geolocatorRepository.getCurrentLocation();
    print('Ubicación actual: $location');
  }

  Future<void> openAppSettings() async {
    await geolocatorRepository.openAppSettings();
  }

  Future<void> permisos() async {
    await geolocatorRepository.checkPermissions();
  }

  void onUserNameChanged(String text) {
    onlyUpdate(
      state.copyWith(
        nombre: text,
      ),
    );
  }

  void onDescripcionChanged(String text) {
    onlyUpdate(
      state.copyWith(
        descripcion: text,
      ),
    );
  }

  void onRtnChanged(String text) {
    onlyUpdate(
      state.copyWith(
        rtn: text,
      ),
    );
  }

  void onRtnPersonalChanged(String text) {
    onlyUpdate(
      state.copyWith(
        rtnPersonal: text,
      ),
    );
  }

  void onSelectedCategoriesChanged(List<BusinessCategory> selectedCategories) {
    onlyUpdate(
      state.copyWith(
        selectedCategories: selectedCategories,
      ),
    );
  }

  void onTelefonoChanged(String text) {
    onlyUpdate(
      state.copyWith(
        telefono: text,
      ),
    );
  }

  void onEmailChanged(String text) {
    onlyUpdate(
      state.copyWith(
        email: text,
      ),
    );
  }

  void onFacebookChanged(String text) {
    onlyUpdate(
      state.copyWith(
        facebook: text,
      ),
    );
  }

  void onInstagramChanged(String text) {
    onlyUpdate(
      state.copyWith(
        instagram: text,
      ),
    );
  }

  void onWhatsappChanged(bool value) {
    onlyUpdate(
      state.copyWith(
        whatsapp: value,
      ),
    );
  }

  void onDomicilioChanged(bool value) {
    onlyUpdate(
      state.copyWith(
        domicilio: value,
      ),
    );
  }

  void onSelectedDepartamentoIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedDepartamentoId: value,
      ),
    );
  }

  void onSelectedMunicipioIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedMunicipioId: value,
      ),
    );
  }

  void onSelectedLugarIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedLugarId: value,
      ),
    );
  }

  void onSelectedColonyIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedColonyId: value,
      ),
    );
  }

  void submit() {
    // Aquí puedes agregar la lógica para enviar los datos del formulario
    // Por ejemplo, podrías llamar a un repositorio para guardar el usuario
    print('Nombre: ${state.nombre}');
    print('Descripción: ${state.descripcion}');
    print('RTN: ${state.rtn}');
    print('RTN Personal: ${state.rtnPersonal}');
    print('Teléfono: ${state.telefono}');
    print('Email: ${state.email}');
    print('Facebook: ${state.facebook}');
    print('Instagram: ${state.instagram}');
    print('WhatsApp: ${state.whatsapp}');
    print('Domicilio: ${state.domicilio}');
    print(
        'Categorías seleccionadas: ${state.selectedCategories.map((c) => c.descripcion).join(', ')}');
  }

  void geolocator() async {
    await geolocatorRepository.getCurrentLocation();
  }

  void setOptiondCategories(List<BusinessCategory>? category) {
    onlyUpdate(
      state.copyWith(
        optiondCategories: category ?? [],
      ),
    );
  }

  void setOptiodnDepartamentos(List<Department>? departamentos) {
    onlyUpdate(
      state.copyWith(
        departamentos: departamentos ?? [],
      ),
    );
  }

  @override
  void dispose() {
    // Cancelar la suscripción del Stream al repositorio
    _scanSubscription.cancel();
    // Limpiar los recursos del repositorio nativo
    scanRepository.dispose();
    super.dispose();
  }
}
