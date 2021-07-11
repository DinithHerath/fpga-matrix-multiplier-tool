import 'package:flutter/material.dart';

@immutable
class SettingsState {
  final int cores;
  final bool isMulti;
  final String doName;
  final String error;

  SettingsState({
    @required this.cores,
    @required this.isMulti,
    @required this.doName,
    @required this.error,
  });

  static SettingsState get initialState => SettingsState(
        cores: 1,
        isMulti: false,
        doName: null,
        error: '',
      );

  SettingsState clone({
    int cores,
    bool isMulti,
    String doName,
    String error,
  }) {
    return SettingsState(
      cores: cores ?? this.cores,
      isMulti: isMulti ?? this.isMulti,
      doName: doName ?? this.doName,
      error: error ?? this.error,
    );
  }
}
