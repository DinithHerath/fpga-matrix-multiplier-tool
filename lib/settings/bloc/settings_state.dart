import 'package:flutter/material.dart';

@immutable
class SettingsState {
  final bool isMulti;
  final String doName;
  final String error;

  SettingsState({
    @required this.isMulti,
    @required this.doName,
    @required this.error,
  });

  static SettingsState get initialState => SettingsState(
        isMulti: false,
        doName: null,
        error: '',
      );

  SettingsState clone({
    bool isMulti,
    String doName,
    String error,
  }) {
    return SettingsState(
      isMulti: isMulti ?? this.isMulti,
      doName: doName ?? this.doName,
      error: error ?? this.error,
    );
  }
}
