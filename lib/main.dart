import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_provider.dart';
import 'package:fpga_matrix_multiplier/theme.dart';

import 'settings/bloc/settings_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(context),
      child: MaterialApp(
        title: 'FPGA Matrix Multiplier',
        theme: buildThemeData(context),
        debugShowCheckedModeBanner: false,
        home: HomeProvider(),
      ),
    );
  }
}
