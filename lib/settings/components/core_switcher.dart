import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_bloc.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_event.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_state.dart';
import 'package:google_fonts/google_fonts.dart';

class CoreSwitcher extends StatelessWidget {
  const CoreSwitcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Multicore Mode',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 40,
                  color: Constants.kHomeCard,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 40),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return CupertinoSwitch(
                value: state.isMulti,
                onChanged: (v) => settingsBloc.add(ToggleCoresEvent()),
                activeColor: Constants.kHomeCard,
              );
            },
          )
        ],
      ),
    );
  }
}
