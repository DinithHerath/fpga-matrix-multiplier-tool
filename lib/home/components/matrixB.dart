import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_bloc.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_event.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class MatrixBWidget extends StatelessWidget {
  MatrixBWidget({Key key}) : super(key: key);

  final Map<int, int> _mat = Map();
  final GlobalKey<FormState> _formKeyB = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => (previous.matB != current.matB) || (previous.isDimAdded != current.isDimAdded),
      builder: (context, state) {
        final rCount = state.rowsB;
        final cCount = state.columnsB;
        final rHeight = (MediaQuery.of(context).size.height - 20 * rCount) * (0.4 / rCount);
        final cWidth = (MediaQuery.of(context).size.width - 302 - (20 * cCount)) / (2 * cCount);
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 500),
          firstCurve: Curves.ease,
          crossFadeState: state.isDimAdded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: Container(),
          secondChild: Container(
            child: Form(
              key: _formKeyB,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < rCount; i++)
                    Row(
                      children: [
                        for (var j = 0; j < cCount; j++)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: rHeight,
                            width: cWidth,
                            child: Center(
                              child: TextFormField(
                                initialValue: state.matB == null || state.matB.isEmpty ? "0" : state.matB[i * cCount + j].toString(),
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: min(rHeight * 0.4, cWidth * 0.4),
                                    color: Constants.kHomeCard,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  fillColor: Constants.kHomeCard.withAlpha(52),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    gapPadding: 0,
                                    borderSide: BorderSide(color: Constants.kHomeCard.withAlpha(52), width: 0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    gapPadding: 0,
                                    borderSide: BorderSide(color: Constants.kHomeCard, width: 2),
                                  ),
                                ),
                                validator: (v) => (v.isNotEmpty && (int.tryParse(v) != null)) ? null : 'ERR',
                                onSaved: (v) => _mat[i * cCount + j] = int.parse(v),
                              ),
                            ),
                          )
                      ],
                    ),
                  TextButton(
                    onPressed: () {
                      if (_formKeyB.currentState.validate()) {
                        _formKeyB.currentState.save();
                        homeBloc.add(FillMatricesEvent(false, _mat));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      elevation: null,
                      minimumSize: Size(400, 25),
                      primary: Constants.kHomeCard,
                      onPrimary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Save B',
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
          ),
        );
      },
    );
  }
}
