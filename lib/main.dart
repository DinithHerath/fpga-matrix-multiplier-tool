import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:fpga_matrix_multiplier/theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FPGA Matrix Multiplier',
      theme: buildThemeData(context),
      debugShowCheckedModeBanner: false,
      home: MatrixPage(),
    );
  }
}

class MatrixPage extends StatelessWidget {
  const MatrixPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Matrix A',
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
                                    onTap: () {},
                                    splashColor: Colors.black26,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      child: Text(
                                        '3',
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
                                    onTap: () {},
                                    splashColor: Colors.black26,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      child: Text(
                                        '3',
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
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: 2.0,
                  color: Constants.kDivider,
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                ),
                Column(
                  children: [
                    Text(
                      'Matrix B',
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
                                    onTap: () {},
                                    splashColor: Colors.black26,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      child: Text(
                                        '3',
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
                                    onTap: () {},
                                    splashColor: Colors.black26,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      child: Text(
                                        '3',
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
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
