import 'package:flutter/material.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/settings/components/core_switcher.dart';
import 'package:fpga_matrix_multiplier/settings/components/path.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}
