import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/home/bloc/home_event.dart';
import 'package:fpga_matrix_multiplier/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_bloc.dart';
import 'home_state.dart';

class HomeProvider extends BlocProvider<HomeBloc> {
  HomeProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => HomeBloc(context),
          child: HomeView(),
        );
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              if (state.error == 'errorInDimentions') {
                return showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text(
                        'Error In Dimentions',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 24,
                            color: Constants.kHomeCard,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      content: Text(
                        'You can only multiply two matrices if their dimensions are compatible, which means the number of columns in the first matrix is the same as the number of rows in the second matrix.',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Constants.kHomeCard,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                print("ERROR: ${state.error}");
              }
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) => previous.matA != current.matA || previous.matB != current.matB,
          listener: (context, state) {
            if (state.matA.isNotEmpty && state.matB.isNotEmpty) homeBloc.add(SavedAllEvent(true));
          },
          child: Container(),
        )
      ],
      child: HomePage(),
    );
  }
}
