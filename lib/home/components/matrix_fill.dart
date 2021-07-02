import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_bloc.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_event.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_state.dart';
import 'package:fpga_matrix_multiplier/home/components/matrixA.dart';
import 'package:fpga_matrix_multiplier/home/components/matrixB.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

class MatrixFillWidget extends StatefulWidget {
  final bool isA;
  MatrixFillWidget({Key key, this.isA}) : super(key: key);

  @override
  _MatrixWidgetState createState() => _MatrixWidgetState();
}

class _MatrixWidgetState extends State<MatrixFillWidget> {
  int _rows = 0;
  int _preRows = 0;
  int _columns = 0;
  int _preColumns = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.isDimAdded != current.isDimAdded,
      builder: (context, state) {
        return Column(
          children: [
            Text(
              widget.isA ? 'Matrix A' : 'Matrix B',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 50,
                  color: Constants.kHomeCard,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width - 62) / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Text(
                          'Rows:',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 45,
                              color: Constants.kHomeCard,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Constants.kHomeCard.withAlpha(52),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: state.isDimAdded
                                ? null
                                : () {
                                    showCupertinoDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) => CupertinoAlertDialog(
                                        title: Text(
                                          'Pick number of Rows',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 35,
                                              color: Constants.kHomeCard,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        content: StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState) {
                                            return NumberPicker(
                                              value: _rows,
                                              minValue: 0,
                                              maxValue: 8,
                                              textStyle: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 30,
                                                  color: Constants.kHomeCard.withAlpha(72),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              selectedTextStyle: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 30,
                                                  color: Constants.kHomeCard,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() => _rows = value);
                                              },
                                            );
                                          },
                                        ),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: Text(
                                              'Cancel',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Constants.kHomeCard,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _rows = _preRows;
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: Text(
                                              'Pick',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Constants.kHomeCard,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _preRows = _rows;
                                              });
                                              homeBloc.add(widget.isA ? UpdateMatrixAEvent(_rows, _columns) : UpdateMatrixBEvent(_rows, _columns));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                            splashColor: Colors.black26,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              child: Text(
                                '$_rows',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 45,
                                    color: Constants.kHomeCard,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Text(
                          'Columns:',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 45,
                              color: Constants.kHomeCard,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Material(
                          borderRadius: BorderRadius.circular(12),
                          color: Constants.kHomeCard.withAlpha(52),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: state.isDimAdded
                                ? null
                                : () {
                                    showCupertinoDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) => CupertinoAlertDialog(
                                        title: Text(
                                          'Pick number of Columns',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 35,
                                              color: Constants.kHomeCard,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        content: StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState) {
                                            return NumberPicker(
                                              value: _columns,
                                              minValue: 0,
                                              maxValue: 8,
                                              textStyle: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 30,
                                                  color: Constants.kHomeCard.withAlpha(72),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              selectedTextStyle: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 30,
                                                  color: Constants.kHomeCard,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              onChanged: (value) {
                                                setState(() => _columns = value);
                                              },
                                            );
                                          },
                                        ),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: Text(
                                              'Cancel',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Constants.kHomeCard,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _columns = _preColumns;
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            child: Text(
                                              'Pick',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Constants.kHomeCard,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _preColumns = _columns;
                                              });
                                              homeBloc.add(widget.isA ? UpdateMatrixAEvent(_rows, _columns) : UpdateMatrixBEvent(_rows, _columns));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                            splashColor: Colors.black26,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              child: Text(
                                '$_columns',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 45,
                                    color: Constants.kHomeCard,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.isA ? MatrixAWidget() : MatrixBWidget(),
          ],
        );
      },
    );
  }
}
