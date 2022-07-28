import 'package:corona_test_project/layout/home/home_screen.dart';
import 'package:corona_test_project/modules/register_login/cubit/cubit.dart';
import 'package:corona_test_project/modules/register_login/cubit/states.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/network/local/cashe_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final globalKey = GlobalKey<FormState>();

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginContainer extends StatefulWidget {
  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 3,
        ));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showToast(
              message: state.errorMessage, toastStatus: ToastStatus.FAILD);
        }
        if (state is LoginSuccessState) {
          CasheHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            print('success uId:$uId');
            navigateAndFinish(context: context, widget: HomeScreen());
          }).catchError((onError) {
            print('casheHelper Error ${onError.toString()}');
          });
        }
        if (state is LoginResetPasswordSuccessState) {
          showToast(
              message: 'see your email message to reset password',
              toastStatus: ToastStatus.SUCCESS);
        }
      },
      builder: (context, state) {
        LoginAndRegisterCubit cubit = LoginAndRegisterCubit.get(context);
        return Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 12,
                                      color: colorBlack,
                                      height: 1.8,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            'Corona Test',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      letterSpacing: 0.2,
                                      color: colorBlack,
                                    ),
                          ),
                          Text(
                            'Please login to continue',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 12,
                                      color: colorBlack,
                                      height: 1.2,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: RotationTransition(
                      turns: animation,
                      child: Container(
                        height: 90.0,
                        child: Image.asset(
                          'assets/icons/virus_alt_Large.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              defaultTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: 'Type your Email',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'type your email';
                  }
                },
                preFixIcon: Icons.email_outlined,
              ),
              SizedBox(
                height: 8,
              ),
              if (!cubit.isResetPass)
                TextFormField(
                  controller: passwordController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'type your password';
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: cubit.isLoginPassSecure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        cubit.loginChangeObsecure();
                      },
                      icon: Icon(
                        cubit.isLoginPassSecure
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: colorBlack,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.password_sharp,
                      color: colorBlack,
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFFECC845),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                  ),
                  cursorColor: colorBlack,
                ),
              SizedBox(
                height: 24,
              ),
              (state is! LoginLoadingState &&
                      state is! LoginResetPasswordLoadingState)
                  ? Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorBlack,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF1C1C1C).withOpacity(0.2),
                            spreadRadius: 3.0,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (globalKey.currentState!.validate()) {
                            if (!cubit.isResetPass) {
                              print('acceptlog');
                              cubit.acceptLoginData(
                                  email: emailController.text,
                                  password: passwordController.text);
                            } else {
                              print('resetEmail');
                              cubit.resetEmail(email: emailController.text);
                            }
                          }
                        },
                        child: Text(
                          !cubit.isResetPass ? 'Login' : 'Reset',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF3D657),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: colorBlack,
                      ),
                    ),
              TextButton(
                onPressed: () {
                  cubit.isReset(!cubit.isResetPass);
                },
                child: Text(
                  cubit.isResetPass ? 'Login' : 'Forget Password?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C1C1C),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
