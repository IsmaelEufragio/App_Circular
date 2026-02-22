import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/models/ubicacion/department/department.dart';
import '../../../../domain/models/user/business_category/business_category.dart';
import '../../../../domain/models/user/schedule/schedule.dart';
import '../../../../domain/models/user/user_create/user_create_request.dart';
import '../../../../domain/repositories/geolocator_repository.dart';
import '../../../../domain/repositories/user_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/user_crear_state.dart';

class UserCrearController extends StateNotifier<UserCrearState> {
  UserCrearController(
    super.state, {
    required this.geolocatorRepository,
    required this.userRepository,
  });

  final GeolocatorRepository geolocatorRepository;
  final UserRepository userRepository;
  final ImagePicker _picker = ImagePicker();

  // # Formulario Imagen
  Future<void> pickLogoFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        state = state.copyWith(logo: File(image.path));
      }
    } catch (e) {
      print('Error al seleccionar imagen: $e');
    }
  }

  void removeLogo() {
    state = state.copyWith(logo: null);
  }
  //# end Imagen

  //# informcacion del local.
  void onNombreComercialChanged(String text) {
    onlyUpdate(
      state.copyWith(
        nombreComercial: text,
      ),
    );
  }

  String? validNombreComercial(String? text) {
    text = text?.trim() ?? '';
    if (text.isEmpty) {
      return 'El nombre comercial es obligatorio';
    }
    return null;
  }

  void onDescripcionChanged(String text) {
    onlyUpdate(
      state.copyWith(
        descripcion: text,
      ),
    );
  }

  String? validDescripcion(String? text) {
    text = text?.trim() ?? '';
    if (text.isEmpty || text.length < 10) {
      return 'la descripcion deve tener al menos 10 caracteres.';
    }
    return null;
  }

  void onRtnChanged(String text) {
    onlyUpdate(
      state.copyWith(
        rtn: text,
      ),
    );
  }

  String? validRtn(String? text) {
    text = text?.trim() ?? '';
    if (text.isEmpty) {
      return 'Es necesario agregar un rtn';
    }
    return null;
  }

  void onSelectedCategoriesChanged(List<BusinessCategory> selectedCategories) {
    onlyUpdate(
      state.copyWith(
        selectedCategories: selectedCategories,
      ),
    );
  }

  String? validCategories(List<BusinessCategory>? selectedCategories) {
    if (selectedCategories?.isEmpty ?? false) {
      return 'Es necesario agregar almenos una categoria';
    }
    return null;
  }

  List<String> validFormUsuario() {
    List<String> errores = [];
    String? error;

    if (state.logo == null) {
      errores.add('Es necesario agregar un logo');
    }

    error = validNombreComercial(state.nombreComercial);
    if (error != null) {
      errores.add(error);
    }

    error = validDescripcion(state.descripcion);
    if (error != null) {
      errores.add(error);
    }

    error = validRtn(state.rtn);
    if (error != null) {
      errores.add(error);
    }

    error = validCategories(state.selectedCategories);
    if (error != null) {
      errores.add(error);
    }
    return errores;
  }
  // # end informacion del local.

  // # informacion de contacto
  void onTelefonoChanged(String text) {
    onlyUpdate(
      state.copyWith(
        telefono: text,
      ),
    );
  }

  String? validPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un número';
    }

    // Verificar que tenga el formato completo
    if (value.length != 9 || !value.contains('-')) {
      return 'Formato inválido (use ####-####)';
    }

    // Obtener solo los dígitos
    final digits = value.replaceAll('-', '');
    if (digits.length != 8) {
      return 'Debe tener 8 dígitos';
    }

    return null;
  }

  void onEmailChanged(String text) {
    onlyUpdate(
      state.copyWith(
        email: text,
      ),
    );
  }

  String? validEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un correo electrónico';
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }

    return null;
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

  List<String> validFormContacto() {
    List<String> errores = [];
    String? error;

    if (state.logo == null) {
      errores.add('Es necesario agregar un logo');
    }

    error = validPhone(state.telefono);
    if (error != null) {
      errores.add(error);
    }

    error = validEmail(state.email);
    if (error != null) {
      errores.add(error);
    }

    return errores;
  }
  // # end informacion de contacto

  // # informacion de ubicacion
  Future<void> getCurrentLocation() async {
    final permiso = await geolocatorRepository.checkPermissions();
    if (permiso == Permisos.granted) {
      final location = await geolocatorRepository.getCurrentLocation();

      onlyUpdate(
        state.copyWith(
          latitude: location.data.latitude,
          longitude: location.data.longitude,
          isPermissionGranted: true,
        ),
      );
    } else {
      onlyUpdate(
        state.copyWith(
          isPermissionGranted: false,
        ),
      );
    }
  }

  Future<void> openAppSettings() async {
    await geolocatorRepository.openAppSettings();
  }

  Future<bool> permisos() async {
    final permiso = await geolocatorRepository.checkPermissions();
    onlyUpdate(
      state.copyWith(
        isPermissionGranted: permiso == Permisos.granted,
      ),
    );
    return permiso == Permisos.granted;
  }

  void onSelectedDepartamentoIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedDepartamentoId: value,
      ),
    );
  }

  String? validDepartamento(String? id) {
    id = id?.trim() ?? '';
    if (id.isEmpty) {
      return 'Es necesario seleccionar un departamento.';
    }
    return null;
  }

  void onSelectedMunicipioIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedMunicipioId: value,
      ),
    );
  }

  String? validMinicipio(String? id) {
    id = id?.trim() ?? '';
    if (id.isEmpty) {
      return 'Es necesario seleccionar un municipio.';
    }
    return null;
  }

  void onSelectedLugarIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedLugarId: value,
      ),
    );
  }

  String? validLugar(String? id) {
    id = id?.trim() ?? '';
    if (id.isEmpty) {
      return 'Es necesario seleccionar el lugar mas conocido.';
    }
    return null;
  }

  void onSelectedColonyIdChanged(String value) {
    onlyUpdate(
      state.copyWith(
        selectedColonyId: value,
      ),
    );
  }

  String? validColinia(String? id) {
    id = id?.trim() ?? '';
    if (id.isEmpty) {
      return 'Es necesario seleccionar colonia.';
    }
    return null;
  }

  List<String> validFormUbicacion() {
    List<String> errores = [];
    String? error;

    if (state.logo == null) {
      errores.add('Es necesario agregar un logo');
    }

    error = validDepartamento(state.selectedDepartamentoId);
    if (error != null) {
      errores.add(error);
    }

    error = validMinicipio(state.selectedMunicipioId);
    if (error != null) {
      errores.add(error);
    }

    error = validLugar(state.selectedLugarId);
    if (error != null) {
      errores.add(error);
    }

    error = validColinia(state.selectedColonyId);
    if (error != null) {
      errores.add(error);
    }

    return errores;
  }
  // # end informacion de ubicacion

  // # informacion de horario
  void onScheduleChanged(List<Schedule> nuevoHorario) {
    onlyUpdate(
      state.copyWith(
        horarios: nuevoHorario,
      ),
    );
  }

  String? validHorario() {
    if (state.horarios.isEmpty) {
      return 'Es necesario definir por lo menos un dia de atencion.';
    }
    return null;
  }

  List<String> validFormHorario() {
    List<String> errores = [];
    String? error;

    if (state.logo == null) {
      errores.add('Es necesario agregar un logo');
    }

    error = validHorario();
    if (error != null) {
      errores.add(error);
    }

    return errores;
  }
  // # end informacion de horario

  // # informacion de cuenta de usuario
  void onUserNameChanged(String text) {
    onlyUpdate(
      state.copyWith(
        nombreUsuario: text,
      ),
    );
  }

  String? validUserNama(String? text) {
    text = text?.trim() ?? '';
    if (text.isEmpty) {
      return 'Es necesario el nombre del usuario';
    }

    if (text.length < 7) {
      return 'El nombre de usuario tiene que ser mas largo';
    }

    return null;
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(
        password: text,
      ),
    );
  }

  String? validPassword(String? text) {
    text = text?.trim() ?? '';

    if (text.isEmpty) {
      return 'La contraseña es requerida';
    }
    final RegExp hasUppercase = RegExp(r'[A-Z]');
    final RegExp hasLowercase = RegExp(r'[a-z]');
    final RegExp hasDigits = RegExp(r'\d');
    final RegExp hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (text.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!hasUppercase.hasMatch(text)) {
      return 'Debe contener al menos una letra mayúscula';
    }
    if (!hasLowercase.hasMatch(text)) {
      return 'Debe contener al menos una letra minúscula';
    }
    if (!hasDigits.hasMatch(text)) {
      return 'Debe contener al menos un número';
    }
    if (!hasSpecialCharacters.hasMatch(text)) {
      return 'Debe contener al menos un carácter especial (!@#\$%^&*, etc.)';
    }

    return null;
  }

  List<String> validFormLogin() {
    List<String> errores = [];
    String? error;

    if (state.logo == null) {
      errores.add('Es necesario agregar un logo');
    }

    error = validUserNama(state.nombreUsuario);
    if (error != null) {
      errores.add(error);
    }

    error = validPassword(state.password);
    if (error != null) {
      errores.add(error);
    }

    return errores;
  }

  // # end informacion de cuenta de usuario

  // # Data de los select..
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

  //Accion de guardar.
  void submit() async {
    final errores = validarPagina(4);
    if (errores.isNotEmpty) return;

    final request = UserCreateRequest(
      idTipoUsuario: '928B1B2A-227A-4E54-9F3C-866930FAFB07',
      idTipoIdentidad: 'f0932129-5a5c-4b93-ae15-5922c3875e07',
      nombreComercial: state.nombreComercial,
      descripcion: state.descripcion,
      rtn: state.rtn,
      telefono: state.telefono,
      email: state.email,
      facebook: state.facebook.isEmpty ? null : state.facebook,
      instagram: state.instagram.isEmpty ? null : state.instagram,
      whatsapp: state.whatsapp,
      domicilio: state.domicilio,
      categorias: state.selectedCategories,
      departamentoId: state.selectedDepartamentoId,
      municipioId: state.selectedMunicipioId,
      lugarId: state.selectedLugarId,
      coloniaId: state.selectedColonyId,
      latitude: state.latitude,
      longitude: state.longitude,
      horarios: state.horarios,
      nombreUsuario: state.nombreUsuario,
      password: state.password,
      logo: state.logo!, // ya validado que no es null
    );

    print('Nombre de usuario: ${state.nombreUsuario}');
    print('Nombre comercial: ${state.nombreComercial}');
    print('Descripción: ${state.descripcion}');
    print('RTN: ${state.rtn}');
    print('Teléfono: ${state.telefono}');
    print('Email: ${state.email}');
    print('Facebook: ${state.facebook}');
    print('Instagram: ${state.instagram}');
    print('WhatsApp: ${state.whatsapp}');
    print('Domicilio: ${state.domicilio}');
    print(
        'Categorías seleccionadas: ${state.selectedCategories.map((c) => c.descripcion).join(', ')}');
    print('Colonia ID: ${state.selectedColonyId}');
    print('latitude: ${state.latitude}');
    print('longitude: ${state.longitude}');
    print('Horarios: ${state.horarios.map((h) => h.toString()).join(', ')}');

    await userRepository.createUser(request);
  }

  //validador Por pagina
  List<String> validarPagina(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return validFormUsuario();
      case 1:
        return validFormContacto();
      case 2:
        return validFormUbicacion();
      case 3:
        return validFormHorario();
      case 4:
        return validFormLogin();
      default:
        return [];
    }
  }
}
