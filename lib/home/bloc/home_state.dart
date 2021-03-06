import 'package:flutter/material.dart';

@immutable
class HomeState {
  final String timeCmd;
  final bool randomB;
  final bool randomA;
  final bool execEnd;
  final String execStep;
  final Map<int, int> matFPGA;
  final Map<int, int> matComp;
  final int index;
  final bool isSaved;
  final Map<int, int> matB;
  final Map<int, int> matA;
  final bool isDimAdded;
  final int columnsB;
  final int columnsA;
  final int rowsB;
  final int rowsA;
  final String error;

  HomeState({
    @required this.timeCmd,
    @required this.randomB,
    @required this.randomA,
    @required this.execEnd,
    @required this.execStep,
    @required this.matFPGA,
    @required this.matComp,
    @required this.index,
    @required this.isSaved,
    @required this.matB,
    @required this.matA,
    @required this.isDimAdded,
    @required this.columnsB,
    @required this.columnsA,
    @required this.rowsB,
    @required this.rowsA,
    @required this.error,
  });

  static HomeState get initialState => HomeState(
        timeCmd: '',
        randomB: false,
        randomA: false,
        execEnd: false,
        execStep: '',
        matFPGA: null,
        matComp: null,
        index: 0,
        isSaved: false,
        matB: Map(),
        matA: Map(),
        isDimAdded: false,
        columnsB: 0,
        columnsA: 0,
        rowsB: 0,
        rowsA: 0,
        error: '',
      );

  HomeState clone({
    String timeCmd,
    bool randomB,
    bool randomA,
    bool execEnd,
    String execStep,
    Map<int, int> matFPGA,
    Map<int, int> matComp,
    int index,
    bool isSaved,
    Map<int, int> matB,
    Map<int, int> matA,
    bool isDimAdded,
    int columnsB,
    int columnsA,
    int rowsB,
    int rowsA,
    String error,
  }) {
    return HomeState(
      timeCmd: timeCmd ?? this.timeCmd,
      randomB: randomB ?? this.randomB,
      randomA: randomA ?? this.randomA,
      execEnd: execEnd ?? this.execEnd,
      execStep: execStep ?? this.execStep,
      matFPGA: matFPGA ?? this.matFPGA,
      matComp: matComp ?? this.matComp,
      index: index ?? this.index,
      isSaved: isSaved ?? this.isSaved,
      matB: matB ?? this.matB,
      matA: matA ?? this.matA,
      isDimAdded: isDimAdded ?? this.isDimAdded,
      columnsB: columnsB ?? this.columnsB,
      columnsA: columnsA ?? this.columnsA,
      rowsB: rowsB ?? this.rowsB,
      rowsA: rowsA ?? this.rowsA,
      error: error ?? this.error,
    );
  }
}
