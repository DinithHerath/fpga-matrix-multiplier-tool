import 'package:flutter/material.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_provider.dart';
import 'package:fpga_matrix_multiplier/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FPGA Matrix Multiplier',
      theme: buildThemeData(context),
      debugShowCheckedModeBanner: false,
      home: HomeProvider(),
    );
  }
}
