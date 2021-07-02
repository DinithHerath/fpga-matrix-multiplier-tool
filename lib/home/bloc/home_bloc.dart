import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(BuildContext context) : super(HomeState.initialState);

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

      case CalculateEvent:
        yield state.clone(index: 1);
        add(UpdateExecEvent('\$ computer matrix calculation started.....'));
        print('${state.matA}\n${state.matB}');
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
        final out = orderedList.map((e) => e.toRadixString(16).padLeft(2, '0')).toList();
        print(out);
        yield state.clone(matComp: matMultipication(state));
        add(UpdateExecEvent('\$ computer resultunt matrix generated.....'));
        // writeMem(out);
        add(UpdateExecEvent('\$ data memory file placed.....'));
        add(UpdateExecEvent('\$ fpga execution started.....'));
        execFPGA(state);
        add(UpdateExecEvent('\$ fpga execution finished.....'));
        add(UpdateExecEvent('\$ reading result file.....'));
        // final fpgaOut = await readMem(state);
        // yield state.clone(matFPGA: fpgaOut, execEnd: true);
        break;

      case ClearEvent:
        readMem(state);
        // yield state.clone(matA: Map(), matB: Map(), isDimAdded: false, isSaved: false);
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
    print(cd);
    final File file = File('${cd}simulation\modelsim\initial_files\data_mem.txt');
    final File fileOut = File('${cd}simulation\modelsim\output_files\res.txt');
    await fileOut.writeAsString('');
    await file.writeAsString('');
    for (var mem in output) {
      await file.writeAsString('$mem\n', mode: FileMode.append);
    }
  }

  Future<Map<int, int>> readMem(HomeState state) async {
    final out = Map<int, int>();
    final directory = Platform.resolvedExecutable;
    final cd = directory.trim().split("fpga_matrix_multiplier.exe")[0];
    print(cd);
    final File file = File('${cd}res.txt');
    final read = await file.readAsLines();
    final trunc = read.sublist(3);
    for (var i = 0; i < state.rowsA * state.columnsB; i++) {
      out[i] = int.parse(trunc[i * 2]) + 256 * int.parse(trunc[i * 2 + 1]);
    }
    return out;
  }

  void execFPGA(HomeState state) async {
    final directory = Platform.resolvedExecutable;
    final cd = directory.trim().split("Release\\fpga_matrix_multiplier.exe")[0];
    final start = 140;
    final end = start + (state.rowsA * state.columnsB) - 1;
    var controller = ShellLinesController();
    var shell = Shell(stdout: controller.sink, verbose: false);
    controller.stream.listen((event) {
      add(UpdateExecEvent('\$ $event'));
    });
    try {
      await shell.run('''
        # cd '${cd}simulation\modelsim'
        # VSIM exec function
        vsim -do "do FPGA_Project_run_msim_rtl_verilog.do; do {wave_files/waves.do}; radix -decimal; restart -force; run -all; mem display -addressradix d -dataradix decimal -wordsperline 10 /processor_tb/dut/data_mem1; mem save -outfile {output_files/res.txt} -dataradix decimal -noaddress -start $start -end $end /processor_tb/dut/data_mem1 -wordsperline 1"
''');
    } on ShellException catch (_) {
      // We might get a shell exception
    }
  }
}
