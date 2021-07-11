import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_bloc.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_state.dart';
import 'package:fpga_matrix_multiplier/settings/components/core_switcher.dart';
import 'package:fpga_matrix_multiplier/settings/components/num_cores.dart';
import 'package:fpga_matrix_multiplier/settings/components/path.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  iconSize: 52,
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Constants.kHomeCard,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Settings',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 60,
                      color: Constants.kHomeCard,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                PathField(),
                SizedBox(height: 20),
                CoreSwitcher(),
                SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  switchInCurve: Curves.ease,
                  switchOutCurve: Curves.ease,
                  child: state.isMulti ? NumCores() : SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
