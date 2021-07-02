import 'package:flutter/material.dart';

@immutable
abstract class HomeEvent {}

class ErrorEvent extends HomeEvent {
  final String error;

  ErrorEvent(this.error);
}

class UpdateMatrixAEvent extends HomeEvent {
  final int rows;
  final int columns;

  UpdateMatrixAEvent(this.rows, this.columns);
}

class UpdateMatrixBEvent extends HomeEvent {
  final int rows;
  final int columns;

  UpdateMatrixBEvent(this.rows, this.columns);
}

class DimentionStateEvent extends HomeEvent {
  final bool dimAdded;

  DimentionStateEvent(this.dimAdded);
}

class FillMatricesEvent extends HomeEvent {
  final bool isA;
  final Map map;

  FillMatricesEvent(this.isA, this.map);
}

class CalculateEvent extends HomeEvent {}

class ClearEvent extends HomeEvent {}

class RestartEvent extends HomeEvent {}

class SavedAllEvent extends HomeEvent {
  final bool saved;

  SavedAllEvent(this.saved);
}