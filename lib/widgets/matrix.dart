import 'package:flutter/material.dart';
import 'package:fpga_matrix_multiplier/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class MatrixWidget extends StatelessWidget {
  const MatrixWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
