import 'package:flutter/foundation.dart';

abstract class StateNotifier<State> extends ChangeNotifier {
  StateNotifier(this._state) : _oldState = _state;

  State _state, _oldState;
  bool _mounted = true;

  State get state => _state;
  State get oldState => _oldState;
  bool get mounted => _mounted;

  set state(State newState) {
    _update(newState, notify: true);
  }

  void onlyUpdate(State newState) {
    _update(newState);
  }

  void _update(State newState, {bool notify = false}) {
    if (_state != newState) {
      _oldState = _state;
      _state = newState;
      if (notify) notifyListeners();
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
