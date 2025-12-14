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
