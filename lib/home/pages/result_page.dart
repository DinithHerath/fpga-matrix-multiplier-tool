import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_bloc.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_event.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_state.dart';
import 'package:fpga_matrix_multiplier/home/components/matrix_res.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(Icons.refresh, color: Colors.white, size: 26),
                tooltip: 'Restart Calculation',
                backgroundColor: Constants.kHomeCard,
                onPressed: () {
                  homeBloc.add(RestartEvent());
                },
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                child: Icon(Icons.beenhere_rounded, color: Colors.white, size: 26),
                tooltip: 'Save Matrix',
                backgroundColor: Constants.kHomeCard,
                onPressed: () {
                  homeBloc.add(SaveEvent());
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
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
                    'Resultant Matrices',
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
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MatrixResWidget(isComp: true),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: 1.0,
                            color: Constants.kDivider,
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                          ),
                          MatrixResWidget(isComp: false),
                        ],
                      ),
                      if (state.execEnd)
                        UnconstrainedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Material(
                              borderRadius: BorderRadius.circular(8),
                              color: Constants.kHomeCard.withAlpha(52),
                              clipBehavior: Clip.antiAlias,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                child: Text(
                                  'Time Elapsed:  ${state.timeCmd.substring(1).trim().split(" ").sublist(1, 3).join(" ")}',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 28,
                                      color: Constants.kHomeCard,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                if (!state.execEnd)
                  Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 50),
                      Expanded(
                        child: Text(
                          '${state.execStep}',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Constants.kHomeCard.withAlpha(72),
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
