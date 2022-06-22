import 'package:corona_test_project/modules/register_login/cubit/cubit.dart';
import 'package:corona_test_project/modules/register_login/cubit/states.dart';
import 'package:corona_test_project/modules/register_login/login_screen/login_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../sign_up/sign_up.dart';
import '../sign_up/signup_option.dart';
import 'login_option.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginAndRegisterCubit(),
      child: BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginAndRegisterCubit cubit = LoginAndRegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xFF1C1C1C),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      cubit.loginToggleScreen();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: cubit.login
                          ? MediaQuery.of(context).size.height * 0.6
                          : MediaQuery.of(context).size.height * 0.4,
                      child: CustomPaint(
                        painter: CurvePainter(cubit.login),
                        child: Container(
                          padding:
                              EdgeInsets.only(bottom: cubit.login ? 0 : 55),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 16.0,
                                ),
                                child: cubit.login
                                    ? LoginContainer()
                                    : LoginOption(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.loginToggleScreen();
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      height: cubit.login
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.6,
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 0.0,
                              ),
                              child: !cubit.login
                                  ? SignUpScreen()
                                  : SignUpOption(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  bool outterCurve = true;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xFFF3D657);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5,
        outterCurve ? size.height + 110 : size.height - 110,
        size.width,
        size.height);
    path.lineTo(size.width, 0);
    path.close;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
