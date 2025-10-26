import '../../../global/state_notifier.dart';
import 'state/user_crear_state.dart';

class UserCrearController extends StateNotifier<UserCrearState> {
  UserCrearController(super.state);

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

  void onIdRubroChanged(int idRubro) {
    onlyUpdate(
      state.copyWith(
        IdRubro: idRubro,
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
    print('ID Rubro: ${state.IdRubro}');
  }
}
