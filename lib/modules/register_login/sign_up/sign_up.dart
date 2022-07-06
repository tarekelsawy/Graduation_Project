import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
import 'package:corona_test_project/modules/register_login/cubit/cubit.dart';
import 'package:corona_test_project/modules/register_login/cubit/states.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/network/local/cashe_helper.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../shared/components/constants.dart';

final formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController birthDateController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          showToast(
            message: state.errorMessage,
            toastStatus: ToastStatus.FAILD,
          );
        }
        if (state is RegisterSuccessCreateUserState) {
          CasheHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            showToast(
              message: 'Registration Complete Successfully',
              toastStatus: ToastStatus.SUCCESS,
            );
            navigateAndFinish(context: context, widget: QuestionTestScreen());
          }).catchError((onError) {
            print('cashehelper Error:${onError.toString()}');
          });
        }
      },
      builder: (context, state) {
        LoginAndRegisterCubit cubit = LoginAndRegisterCubit.get(context);
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up with',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFF3D657),
                  height: 2,
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
                  color: Color(0xFFF3D657),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              defaultRegisterTextField(
                controller: nameController,
                label: 'Enter Your Name',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'required field!';
                  }
                },
                keyboardType: TextInputType.name,
                prefixIcon: Icons.person,
              ),
              SizedBox(
                height: 16,
              ),
              defaultRegisterTextField(
                controller: emailController,
                label: 'Enter Your Email',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'required field!';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: passController,
                onChanged: (String value) {
                  cubit.calcPassStrength(value.length);
                },
                keyboardType: TextInputType.visiblePassword,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'required field!';
                  }
                },
                obscureText: cubit.isRegisterPassSecure,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.password,
                    color: Color(0xFF3F3C31),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      cubit.isRegisterPassSecure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color(0xFF3F3C31),
                    ),
                    onPressed: () {
                      cubit.registerChangeObsecure();
                    },
                  ),
                  labelText: 'Enter Your Password',
                  labelStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF3F3C31),
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
                  fillColor: Colors.grey.withOpacity(0.1),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                ),
                cursorColor: colorBlack,
              ),
              SizedBox(
                height: 16,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            if (cubit.length >= 1)
                              Container(
                                height: 4,
                                width: 30,
                                color: Color.fromARGB(255, 252, 18, 1),
                              ),
                            if (cubit.length >= 2)
                              Container(
                                  height: 4,
                                  width: 20,
                                  color: Color.fromARGB(255, 251, 100, 89)),
                            if (cubit.length >= 4)
                              Container(
                                  height: 4,
                                  width: 20,
                                  color: Color.fromARGB(255, 247, 150, 143)),
                            if (cubit.length >= 6)
                              Container(
                                height: 4,
                                width: 20,
                                color: Colors.orange,
                              ),
                            if (cubit.length >= 8)
                              Container(
                                height: 4,
                                width: 20,
                                color: Color.fromARGB(255, 252, 189, 94),
                              ),
                            if (cubit.length >= 10)
                              Container(
                                  height: 4,
                                  width: 20,
                                  color: Color.fromARGB(255, 160, 244, 163)),
                            if (cubit.length >= 12)
                              Container(
                                  height: 4,
                                  width: 20,
                                  color: Color.fromARGB(255, 85, 251, 90)),
                            if (cubit.length >= 14)
                              Container(
                                  height: 4,
                                  width: 30,
                                  color: Color.fromARGB(255, 2, 252, 10)),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            if (cubit.length >= 1 && cubit.length < 4)
                              Text(
                                'So Weak',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Color.fromARGB(255, 252, 18, 1),
                                      fontSize: 8.0,
                                    ),
                              ),
                            if (cubit.length >= 4 && cubit.length < 8)
                              Text(
                                'Weak',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Color.fromARGB(255, 252, 189, 94),
                                      fontSize: 8.0,
                                    ),
                              ),
                            if (cubit.length >= 8 && cubit.length < 12)
                              Text(
                                'Medium',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Color.fromARGB(255, 160, 244, 163),
                                      fontSize: 8.0,
                                    ),
                              ),
                            if (cubit.length >= 12)
                              Text(
                                'Strong',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: Color.fromARGB(255, 2, 252, 10),
                                      fontSize: 8.0,
                                    ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              defaultRegisterTextField(
                controller: phoneController,
                label: 'Enter Phone Number',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'required field!';
                  }
                },
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
              ),
              SizedBox(
                height: 16,
              ),
              defaultRegisterTextField(
                controller: birthDateController,
                label: 'Enter Your BirthData',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'required field!';
                  }
                },
                showCursor: true,
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.parse('1920-01-01'),
                    lastDate: DateTime.now(),
                  ).then((DateTime? value) {
                    birthDateController.text = DateFormat.yMd().format(value!);
                  }).catchError((onError) {
                    print('Error');
                  });
                },
                keyboardType: TextInputType.datetime,
                prefixIcon: Icons.date_range,
              ),
              SizedBox(
                height: 16,
              ),
              defaultRegisterTextField(
                controller: addressController,
                label: 'Enter Your State',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'required field!';
                  }
                },
                showCursor: true,
                readOnly: true,
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Color(0xFF1C1C1C),
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3F3C31),
                      ),
                      bottomSheetHeight: 500,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        hintStyle: TextStyle(
                          color: Color(0xFF3F3C31),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    onSelect: (Country country) {
                      print('Select country: ${country.name}');
                      addressController.text = country.name;
                    },
                  );
                },
                keyboardType: TextInputType.name,
                prefixIcon: Icons.location_city,
              ),
              SizedBox(
                height: 24,
              ),
              state is! RegisterLoadingState
                  ? Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFF3D657),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF3D657).withOpacity(0.1),
                            spreadRadius: 3.0,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.acceptRegisterData(
                              email: emailController.text,
                              name: nameController.text,
                              password: passController.text,
                              birthDate: birthDateController.text,
                              country: addressController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1C1C1C),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF3F3C31),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
