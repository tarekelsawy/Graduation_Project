import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController birthDateController = TextEditingController();
TextEditingController addressController = TextEditingController();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {
        if (state is CoronaUploadProfileURLToFireStoreSuccessState) {
          showToast(
              message: 'Profile Image Uploaded Successfully',
              toastStatus: ToastStatus.SUCCESS);
        } else if (state is CoronaUploadProfileURLToFireStoreErrorState) {
          showToast(message: state.message, toastStatus: ToastStatus.FAILD);
        }
        if (state is CoronaUpdateProfileSuccessState) {
          showToast(
              message: 'Your Profile is Edited Successfully',
              toastStatus: ToastStatus.SUCCESS);
        } else if (state is CoronaUpdateProfileErrorState) {
          showToast(message: state.message, toastStatus: ToastStatus.FAILD);
        }
      },
      builder: (context, state) {
        var locale = S.of(context);
        CoronaCubit cubit = CoronaCubit.get(context);
        emailController.text =
            CoronaCubit.userModel!.email ?? 'type your email';
        nameController.text = CoronaCubit.userModel!.name ?? 'type your name';
        phoneController.text =
            CoronaCubit.userModel!.phone ?? 'type your phone';

        birthDateController.text =
            CoronaCubit.userModel!.birthDate ?? 'type your birthDate';
        addressController.text =
            CoronaCubit.userModel!.country ?? 'type your address';

        return Scaffold(
          drawer: SideBarScreen(),
          appBar: AppBar(
            title: Text(
              locale.editProfile,
            ),
          ),
          body: CoronaCubit.userModel != null
              ? Column(
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(backgroundImage),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: cubit.profileImagefile != null
                                    ? CircleAvatar(
                                        radius: 48,
                                        backgroundImage:
                                            FileImage(cubit.profileImagefile),
                                      )
                                    : CircleAvatar(
                                        radius: 48,
                                        backgroundImage: NetworkImage(
                                            '${CoronaCubit.userModel!.profileImage}'),
                                      ),
                              ),
                              Container(
                                height: 31,
                                width: 31,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    cubit.catchImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 17.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state == CoronaUploadProfileURLToFireStoreLoadingState)
                      Center(
                        child: LinearProgressIndicator(),
                      ),
                    Form(
                      key: formKey,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                defaultRegisterTextField(
                                  controller: nameController,
                                  label: locale.enterYourName,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'required field!';
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  prefixIcon: Icons.person,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultRegisterTextField(
                                  controller: emailController,
                                  label: locale.enterYourEmail,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'required field!';
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email_outlined,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultRegisterTextField(
                                  controller: phoneController,
                                  label: locale.enterYourPhone,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'required field!';
                                    }
                                  },
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: Icons.phone,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultRegisterTextField(
                                  controller: birthDateController,
                                  label: locale.enterYourBirthDate,
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
                                      birthDateController.text =
                                          DateFormat.yMd().format(value!);
                                    }).catchError((onError) {
                                      print('Error');
                                    });
                                  },
                                  keyboardType: TextInputType.datetime,
                                  prefixIcon: Icons.date_range,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultRegisterTextField(
                                  controller: addressController,
                                  label: locale.enterYourState,
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
                                        // backgroundColor: Color(0xFF1C1C1C),
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 16,
                                              color: Color(0xFF3F3C31),
                                            ),
                                        bottomSheetHeight: 500,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        inputDecoration: InputDecoration(
                                          labelText: locale.countrySearch,
                                          hintText: locale.typeCountrySearch,
                                          prefixIcon: const Icon(Icons.search),
                                          hintStyle: TextStyle(
                                            color: Color(0xFF3F3C31),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: const Color(0xFF8C98A8)
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country country) {
                                        print(
                                            'Select country: ${country.name}');
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
                                state is! CoronaGetUserLoadingState
                                    ? Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Color(0xFFF3D657)
                                              : colorPurple,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: isDark
                                                  ? Color(0xFFF3D657)
                                                      .withOpacity(0.1)
                                                  : colorBlack.withOpacity(0.2),
                                              spreadRadius: 3.0,
                                              blurRadius: 4,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit.updateProfile(
                                                name: nameController.text,
                                                email: emailController.text,
                                                phone: phoneController.text,
                                                birthDate:
                                                    birthDateController.text,
                                                country: addressController.text,
                                              );
                                            }
                                          },
                                          child: Text(
                                            locale.updateProfile,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 18,
                                                  // fontWeight: FontWeight.bold,
                                                  color: isDark
                                                      ? Color(0xFF1C1C1C)
                                                      : colorWhite,
                                                ),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.grey,
                                        ),
                                      ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  ),
                ),
        );
      },
    );
  }
}
