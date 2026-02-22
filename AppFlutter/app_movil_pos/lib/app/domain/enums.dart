enum Preference { darkMode }

enum UserType {
  ong,
  local,
  servicio,
  empresarial,
  microempresa,
  usuarioParticular,
  usuarioConHabilidades
}

enum ConfigLcd {
  init(0),
  wakeup(1),
  sleep(2),
  clear(3),
  reset(4);

  const ConfigLcd(this.value);
  final int value;
}

enum Permisos {
  granted('GRANTED'),
  showRationale('SHOW_RATIONALE'),
  requestPermission('REQUEST_PERMISSION');

  const Permisos(this.value);
  final String value;

  static Permisos fromValue(String value) {
    return Permisos.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Valor inválido: $value'),
    );
  }
}
