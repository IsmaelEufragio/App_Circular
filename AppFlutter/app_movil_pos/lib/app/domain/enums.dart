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

  final int value;
  const ConfigLcd(this.value);
}

enum Permisos {
  granted('GRANTED'),
  showRationale('SHOW_RATIONALE'),
  requestPermission('REQUEST_PERMISSION');

  final String value;
  const Permisos(this.value);

  static Permisos fromValue(String value) {
    return Permisos.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Valor inválido: $value'),
    );
  }
}
