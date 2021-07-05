import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_bloc.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_event.dart';
import 'package:fpga_matrix_multiplier/settings/bloc/settings_state.dart';
import 'package:google_fonts/google_fonts.dart';

class PathField extends StatelessWidget {
  PathField({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Modelsim .do file name',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 40,
                color: Constants.kHomeCard,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 308,
                      child: TextFormField(
                        initialValue: state.doName == null || state.doName.isEmpty ? "" : state.doName,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Constants.kHomeCard,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                        validator: (v) => v.isNotEmpty ? null : 'ERR',
                        onSaved: (v) => settingsBloc.add(UpdateDoFileEvent(v)),
                      ),
                    ),
                    SizedBox(width: 16),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        elevation: null,
                        minimumSize: Size(260, 65),
                        primary: Constants.kHomeCard,
                        onPrimary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Save Name',
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
              );
            },
          )
        ],
      ),
    );
  }
}
