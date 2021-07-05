import 'package:flutter/material.dart';

@immutable
abstract class SettingsEvent {}

class ErrorEvent extends SettingsEvent {
  final String error;

  ErrorEvent(this.error);
}

class UpdateDoFileEvent extends SettingsEvent {
  final String name;

  UpdateDoFileEvent(this.name);
}

class ToggleCoresEvent extends SettingsEvent {}
