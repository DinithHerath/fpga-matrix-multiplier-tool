import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_event.dart';
import 'package:fpga_matrix_multiplier/home/components/matrix_fill.dart';
import 'package:fpga_matrix_multiplier/settings/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class MainPage extends StatelessWidget {
  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.isDimAdded != current.isDimAdded || previous.isSaved != current.isSaved,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit, color: Colors.white, size: 26),
            tooltip: 'Reset Matrices',
            backgroundColor: Constants.kHomeCard,
            onPressed: () {
              homeBloc.add(ClearEvent());
            },
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                    },
                    iconSize: 32,
                    color: Constants.kHomeCard,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'FPGA Matrix Multiplier',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 70,
                        color: Constants.kHomeCard,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    state.isDimAdded && state.isSaved ? 'Calcuate Resultant Matrix' : 'Select Matrix Dimentions',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 55,
                        color: Constants.kHomeCard,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MatrixFillWidget(isA: true),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 1.0,
                      color: Constants.kDivider,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    MatrixFillWidget(isA: false),
                  ],
                ),
                SizedBox(height: 30),
                if (!state.isDimAdded)
                  TextButton(
                    onPressed: () {
                      homeBloc.add(DimentionStateEvent(true));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      elevation: null,
                      minimumSize: Size(600, 25),
                      primary: Constants.kHomeCard,
                      onPrimary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add Matrix Dimentions',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                if (state.isDimAdded && state.isSaved)
                  TextButton(
                    onPressed: () {
                      homeBloc.add(CalculateEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      elevation: null,
                      minimumSize: Size(650, 25),
                      primary: Constants.kHomeCard,
                      onPrimary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Start Calculation Using FPGA',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
