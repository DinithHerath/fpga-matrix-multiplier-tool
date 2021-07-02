import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpga_matrix_multiplier/home/pages/main_page.dart';
import 'package:fpga_matrix_multiplier/home/pages/result_page.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<HomeBloc, HomeState>(
        listenWhen: (previous, current) => previous.index != current.index,
        listener: (context, state) {
          _pageController.animateToPage(
            state.index,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        },
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            MainPage(),
            ResultPage(),
          ],
        ),
      ),
    );
  }
}
