import 'package:corona_test_project/modules/result_screen/details_screen.dart';
import 'package:corona_test_project/modules/result_screen/result_option.dart';
import 'package:corona_test_project/modules/result_screen/result_screen.dart';
import 'package:corona_test_project/modules/result_screen/details_option.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

import '../clip_path/clip_paths.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool login = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBarScreen(),
      backgroundColor: isDark ? colorBlack : colorPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      login = true;
                    },
                  );
                },
                onTapDown: (tapDownDetails) {
                  setState(
                    () {
                      login = true;
                    },
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                  height: login
                      ? MediaQuery.of(context).size.height * 0.6
                      : MediaQuery.of(context).size.height * 0.3,
                  child: CustomPaint(
                    painter: CurvePainter(login),
                    child: Container(
                      color: isDark ? colorYellow : colorWhite,
                      padding: EdgeInsets.only(bottom: login ? 0 : 55),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                            child: login ? ResultIndicator() : ResultOption(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    login = false;
                  });
                },
                onTapUp: (tapUpDetails) {
                  setState(() {
                    login = false;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                  height: login
                      ? MediaQuery.of(context).size.height * 0.4
                      : MediaQuery.of(context).size.height * 0.6,
                  child: Container(
                    color: Colors.transparent,
                    child: !login ? DetailsScreen() : DetailsOption(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
