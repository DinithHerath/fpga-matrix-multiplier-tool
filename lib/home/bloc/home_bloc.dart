import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_bloc.dart';
import 'package:process_run/shell.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Timer timer;

  final SettingsBloc settingsBloc;
  HomeBloc(BuildContext context)
      : this.settingsBloc = BlocProvider.of<SettingsBloc>(context),
        super(HomeState.initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case UpdateMatrixAEvent:
        final rows = (event as UpdateMatrixAEvent).rows;
        final columns = (event as UpdateMatrixAEvent).columns;
        yield state.clone(rowsA: rows, columnsA: columns);
        break;

      case UpdateMatrixBEvent:
        final rows = (event as UpdateMatrixBEvent).rows;
        final columns = (event as UpdateMatrixBEvent).columns;
        yield state.clone(rowsB: rows, columnsB: columns);
        break;

      case DimentionStateEvent:
        final added = (event as DimentionStateEvent).dimAdded;
        if (state.columnsA == state.rowsB) {
          yield state.clone(isDimAdded: added);
        } else {
          add(ErrorEvent('errorInDimentions'));
        }
        break;

      case FillMatricesEvent:
        final a = (event as FillMatricesEvent).isA;
        final map = (event as FillMatricesEvent).map;
        if (a)
          yield state.clone(matA: map);
        else
          yield state.clone(matB: map);
        break;

      case RandomizeMatrixAEvent:
        yield state.clone(randomA: false);
        final matA = Map<int, int>();
        for (var i = 0; i < state.rowsA; i++) {
          for (var j = 0; j < state.columnsA; j++) {
            matA[i * state.columnsA + j] = Random().nextInt(75);
          }
        }
        yield state.clone(matA: matA, randomA: true);
        break;

      case RandomizeMatrixBEvent:
        yield state.clone(randomB: false);
        final matB = Map<int, int>();
        for (var i = 0; i < state.rowsB; i++) {
          for (var j = 0; j < state.columnsB; j++) {
            matB[i * state.columnsB + j] = Random().nextInt(75);
          }
        }
        yield state.clone(matB: matB, randomB: true);
        break;

      case CalculateEvent:
        final empty = Map<int, int>();
        for (var i = 0; i < state.rowsA * state.columnsB; i++) {
          empty[i] = 0;
        }
        yield state.clone(index: 1, matComp: empty, matFPGA: empty);
        add(UpdateExecEvent('\$ computer matrix calculation started.....'));
        print('${state.matA}\n${state.matB}');
        final orderedList = settingsBloc.state.isMulti ? genMulti() : genSingle();
        final out = orderedList.map((e) => e.toRadixString(16).padLeft(2, '0')).toList();
        print(out);
        yield state.clone(matComp: matMultipication(state));
        add(UpdateExecEvent('\$ computer resultunt matrix generated.....'));
        writeMem(out);
        add(UpdateExecEvent('\$ data memory file placed.....'));
        add(UpdateExecEvent('\$ fpga execution started.....'));
        execFPGA(state);
        add(UpdateExecEvent('\$ fpga execution finished.....'));
        final output = Map<int, int>();
        final directory = Platform.resolvedExecutable;
        final cd = directory.trim().split("Release\\fpga_matrix_multiplier.exe")[0];
        final File file = File('${cd}simulation\\modelsim\\output_files\\res.txt');
        add(UpdateExecEvent('\$ reading result file..... ${cd}simulation\\modelsim\\output_files\\res.txt'));
        timer = Timer.periodic(Duration(seconds: 2), (timer) {
          final read = file.readAsLinesSync();
          if (read.isNotEmpty && read.length == (3 + state.rowsA * state.columnsB * 2)) {
            timer.cancel();
            final trunc = read.sublist(3);
            for (var i = 0; i < state.rowsA * state.columnsB; i++) {
              output[i] = int.parse(trunc[i * 2]) + 256 * int.parse(trunc[i * 2 + 1]);
            }
            add(FinalOutputEvent(output));
          }
        });
        break;

      case FinalOutputEvent:
        final data = (event as FinalOutputEvent).out;
        yield state.clone(matFPGA: data, execEnd: true);
        break;

      case ClearEvent:
        yield state.clone(matA: Map(), matB: Map(), isDimAdded: false, isSaved: false);
        break;

      case RestartEvent:
        yield state.clone(matA: Map(), matB: Map(), isDimAdded: false, isSaved: false, index: 0, execStep: '', execEnd: false);
        break;

      case SavedAllEvent:
        final save = (event as SavedAllEvent).saved;
        yield state.clone(isSaved: save);
        break;

      case UpdateExecEvent:
        final exec = (event as UpdateExecEvent).exec;
        yield state.clone(execStep: exec);
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    timer.cancel();
    await super.close();
  }

  void _addErr(e) {
    if (e is StateError) return;
    try {
      add(ErrorEvent((e is String) ? e : (e.message ?? "Something went wrong. Please try again!")));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again!"));
    }
  }

  Map<int, int> matMultipication(HomeState state) {
    final out = Map<int, int>();
    final trans = Map();
    int m = state.rowsA, n = state.columnsA, l = state.columnsB;
    for (var i = 0; i < l; i++) {
      for (var j = 0; j < n; j++) {
        trans[i * n + j] = state.matB[i + (j * l)];
      }
    }
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < l; j++) {
        int sum = 0;
        for (int k = 0; k < n; k++) sum += state.matA[i * n + k] * trans[j * n + k];
        out[j + i * l] = sum;
      }
    }
    return out;
  }

  Future<void> writeMem(List<String> output) async {
    final directory = Platform.resolvedExecutable;
    final cd = directory.trim().split("Release\\fpga_matrix_multiplier.exe")[0];
    final File file = File('${cd}simulation\\modelsim\\initial_files\\data_mem.txt');
    final File fileOut = File('${cd}simulation\\modelsim\\output_files\\res.txt');
    await fileOut.writeAsString('');
    await file.writeAsString('');
    for (var mem in output) {
      await file.writeAsString('$mem\n', mode: FileMode.append);
    }
  }

  List<int> genSingle() {
    final orderedList = <int>[];
    orderedList.addAll([state.rowsA, 0]);
    orderedList.addAll([state.columnsA, 0]);
    orderedList.addAll([state.columnsB, 0]);
    orderedList.addAll([0, 0, 0, 0, 0, 0, 15, 0, 70]);
    orderedList.addAll(state.matA.values.toList());
    for (var i = 0; i < state.columnsB; i++) {
      for (var j = 0; j < state.rowsB; j++) {
        orderedList.add(state.matB[i + (j * state.columnsB)]);
      }
    }
    return orderedList;
  }

  List<int> genMulti() {
    final orderedList = <int>[];
    orderedList.addAll([state.rowsA]);
    orderedList.addAll([state.columnsA]);
    orderedList.addAll([state.columnsB]);
    orderedList.addAll([4, 0, 0, 0, 0, 10, 70]);
    orderedList.addAll(state.matA.values.toList());
    for (var i = 0; i < state.columnsB; i++) {
      for (var j = 0; j < state.rowsB; j++) {
        orderedList.add(state.matB[i + (j * state.columnsB)]);
      }
    }
    return orderedList;
  }

  // Future<Map<int, int>> readMem(HomeState state) async {
  //   final out = Map<int, int>();
  //   final directory = Platform.resolvedExecutable;
  //   final cd = directory.trim().split("fpga_matrix_multiplier.exe")[0];
  //   print(cd);
  //   final File file = File('${cd}res.txt');
  //   timer = Timer.periodic(Duration(seconds: 2), (timer) {
  //     final read = file.readAsLinesSync();
  //     if (read.isNotEmpty && read.length == (3 + state.rowsA * state.columnsB * 2)) {
  //       timer.cancel();
  //       final trunc = read.sublist(3);
  //       for (var i = 0; i < state.rowsA * state.columnsB; i++) {
  //         out[i] = int.parse(trunc[i * 2]) + 256 * int.parse(trunc[i * 2 + 1]);
  //       }
  //     }
  //     return out;
  //   });
  //   return out;
  // }

  void execFPGA(HomeState state) async {
    final directory = Platform.resolvedExecutable;
    final cd = directory.trim().split("Release\\fpga_matrix_multiplier.exe")[0];
    final start = 140;
    final end = start + (state.rowsA * state.columnsB * 2) - 1;
    print(settingsBloc.state.doName);
    var controller = ShellLinesController();
    var shell = Shell(stdout: controller.sink, verbose: false, workingDirectory: '${cd}simulation\\modelsim');
    controller.stream.listen((event) {
      add(UpdateExecEvent('\$ $event'));
      print(event);
    });
    try {
      await shell.run('''
        # VSIM exec function
        vsim -do "do ${settingsBloc.state.doName}; do {wave_files/waves.do}; radix -decimal; restart -force; run -all; mem display -addressradix d -dataradix unsigned -wordsperline 10 /processor_tb/dut/data_mem1; mem save -outfile {output_files/res.txt} -dataradix unsigned -noaddress -start $start -end $end /processor_tb/dut/data_mem1 -wordsperline 1"
        exit()
''');
    } on ShellException catch (_) {
      // We might get a shell exception
    }
  }
}
