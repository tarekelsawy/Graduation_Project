import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
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

class LoginContainer extends StatelessWidget {
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
            navigateAndFinish(context: context, widget: QuestionTestScreen());
          }).catchError((onError) {
            print('casheHelper Error ${onError.toString()}');
          });
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
              Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1C1C1C),
                  height: 1.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Corona Test',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  letterSpacing: 0.2,
                  color: Color(0xFF1C1C1C),
                ),
              ),
              Text(
                'Please login to continue',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1C1C1C),
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              defaultTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                label: 'Email/Username',
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
                cursorColor: Color(0xFF1C1C1C),
              ),
              SizedBox(
                height: 24,
              ),
              state is! LoginLoadingState
                  ? Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF1C1C1C),
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
                            cubit.acceptLoginData(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        child: Text(
                          'Login',
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
                onPressed: () {},
                child: Text(
                  'Forget Password?',
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
