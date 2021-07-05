import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_bloc.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class MatrixResWidget extends StatelessWidget {
  final bool isComp;
  MatrixResWidget({Key key, this.isComp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      // buildWhen: (previous, current) => previous.matA != current.matA || previous.isDimAdded != current.isDimAdded,
      builder: (context, state) {
        final rCount = state.rowsA;
        final cCount = state.columnsB;
        final rHeight = (MediaQuery.of(context).size.height - 20 * rCount) * (0.4 / rCount);
        final cWidth = (MediaQuery.of(context).size.width - 302 - (20 * cCount)) / (2 * cCount);
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 500),
          firstCurve: Curves.ease,
          crossFadeState: state.isDimAdded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: Container(),
          secondChild: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isComp ? 'Computer\'s Matrix' : 'FPGA\'s Matrix',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 50,
                      color: Constants.kHomeCard,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                for (var i = 0; i < rCount; i++)
                  Row(
                    children: [
                      for (var j = 0; j < cCount; j++)
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Constants.kHomeCard.withAlpha(52),
                          ),
                          height: rHeight,
                          width: cWidth,
                          child: Center(
                            child: Text(
                              isComp ? state.matComp[i * cCount + j].toString() : state.matFPGA[i * cCount + j].toString(),
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: min(rHeight * 0.4, cWidth * 0.25),
                                  color: Constants.kHomeCard,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
