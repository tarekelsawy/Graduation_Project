import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_test_project/modules/register_login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model/user_model.dart';

class LoginAndRegisterCubit extends Cubit<LoginAndRegisterStates> {
  LoginAndRegisterCubit() : super(LoginAndRegisterInitialState());

  static LoginAndRegisterCubit get(context) => BlocProvider.of(context);

  bool login = true;

  void loginToggleScreen() {
    login = !login;
    emit(LoginAndRegisterToggleScreenState());
  }

  bool isLoginPassSecure = true;
  void loginChangeObsecure() {
    isLoginPassSecure = !isLoginPassSecure;

    emit(LoginChangeObsecureState());
  }

  bool isRegisterPassSecure = true;
  void registerChangeObsecure() {
    isRegisterPassSecure = !isRegisterPassSecure;

    emit(RegisterChangeObsecureState());
  }

  void acceptRegisterData({
    required String email,
    required String name,
    required String password,
    required String birthDate,
    required String country,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(
        email: email,
        name: name,
        birthDate: birthDate,
        country: country,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((onError) {
      print(onError);
      emit(RegisterErrorState(onError.toString().substring(29)));
    });
  }

  UserModel? userModel;
  void createUser({
    required String email,
    required String name,
    required String birthDate,
    required String country,
    required String phone,
    required String uId,
    String profileImage =
        'https://firebasestorage.googleapis.com/v0/b/corona-test-1f5d5.appspot.com/o/default-profile-image.jpg?alt=media&token=0b5b1579-957f-46c4-8a5a-3ce3a34c3945',
  }) {
    userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      country: country,
      birthDate: birthDate,
      uId: uId,
      profileImage: profileImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc('$uId')
        .set(userModel!.asMap())
        .then((value) {
      emit(RegisterSuccessCreateUserState(uId.toString()));
    }).catchError((onError) {
      print(onError);
      emit(RegisterErrorCreateUserState(onError.toString().substring(29)));
    });
  }

  void acceptLoginData({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print('uId: ${value.user!.uid}');
      emit(LoginSuccessState(value.user!.uid.toString()));
    }).catchError((onError) {
      print(onError);
      emit(LoginErrorState(onError.toString()));
    });
  }
}
