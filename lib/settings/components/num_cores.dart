import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_bloc.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_event.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_state.dart';
import 'package:google_fonts/google_fonts.dart';

class NumCores extends StatelessWidget {
  const NumCores({Key key}) : super(key: key);

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
              'Number of Cores',
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
              return CupertinoSlider(
                value: state.cores.toDouble(),
                min: 1.0,
                max: 4.0,
                divisions: 4,
                activeColor: Constants.kHomeCard,
                onChanged: (v) => settingsBloc.add(UpdateCoreCountEvent(v.round())),
              );
            },
          ),
          SizedBox(width: 20),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return Material(
                borderRadius: BorderRadius.circular(12),
                color: Constants.kHomeCard.withAlpha(52),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    '${state.cores}',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 30,
                        color: Constants.kHomeCard,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
