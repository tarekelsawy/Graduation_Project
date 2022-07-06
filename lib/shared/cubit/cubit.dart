import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corona_test_project/models/user_model/user_model.dart';
import 'package:corona_test_project/modules/register_login/login_screen/login_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:corona_test_project/shared/network/local/cashe_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class CoronaCubit extends Cubit<CoronaStates> {
  CoronaCubit() : super(CoronaInitState());

  static CoronaCubit get(context) => BlocProvider.of(context);

  static int questionPageIndex = 0;
  static double sliderValue = 0;
  static List<dynamic> qResult = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<double> qValues = [
    37.5,
    0.2,
    0.2,
    0.2,
    0.2,
    0.2,
    0.2,
    0.2,
  ];
  List<int> counters = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  void onChangeQuestionPageIndex({required int newIndex}) {
    questionPageIndex = newIndex;
    emit(CoronaOnChangeQuestionPageIndexState());
  }

  void onChangeSliderValue({required double newValue, required int index}) {
    qValues[index] = newValue;
    emit(CoronaOnChangeSliderValueState());
  }

  //image picker
  static var imageFile;
  Future<void> getImage({required ImageSource source}) async {
    try {
      final file = await ImagePicker().pickImage(source: source);

      if (file!.path != null) {
        imageFile = File(file.path);
        print('accepted');
        emit(CoronaOnPickedImageState());
      }
    } on PlatformException catch (e) {
      print('failed to make image: $e');
    }
  }

  String? message;
  uploadImage({File? imageFile}) async {
    emit(CoronaUploadImageToServerLoadingState());
    print("before link");
    final request = http.MultipartRequest(
        'POST', Uri.parse('https://da27-156-219-219-228.eu.ngrok.io/upload'));
    print("after link");
    final headers = {'content-type': 'multipart/form-data'};
    print("after link1");
    request.files.add(
      http.MultipartFile(
          'image', imageFile!.readAsBytes().asStream(), imageFile.lengthSync(),
          filename: imageFile.path.split('/').last),
    );
    request.headers.addAll(headers);
    late StreamedResponse response;
    request.send().then((value) {
      response = value;

      late http.Response res;
      http.Response.fromStream(response).then((value) {
        res = value;

        final resJson = jsonDecode(res.body);

        message = resJson['message'];

        emit(CoronaUploadImageToServerSuccessState());
      }).onError((error, stackTrace) {
        print("error in stream${error.toString()}");
      });
    }).onError((error, stackTrace) {
      print("error in request${error.toString()}");
    });

    // rpint("status $message");
  }

  //firebase get user
  static UserModel? userModel;
  void getUserData() {
    emit(CoronaGetUserLoadingState());
    print('uIdgetUser:$uId');
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());

      print('all user data:${value.data()}');
      emit(CoronaGetUserSuccessState());
    }).catchError((onError) {
      print('get User Error:$onError');
      emit(CoronaGetUserErrorState());
    });
  }

  //suffix password Icon in edit profile
  bool isPasswordSecure = true;
  void showEditProfilePassword() {
    isPasswordSecure = !isPasswordSecure;
    emit(CoronaShowPasswordState());
  }

  //image picker in edit Profile
  var profileImagefile;

  void catchImage() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      profileImagefile = File(value!.path);
      uploadProfileImage(profileImagefile);
      // emit(CoronaPickProfileImageState());
    }).catchError((onError) {
      print('onError:$onError');
    });
  }

  // upload image to firebase storage

  void uploadProfileImage(File file) {
    emit(CoronaUploadProfileURLToFireStoreLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${file.uri.pathSegments.last}')
        .putFile(file)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .update({'profileImage': value}).then((value) {
          getUserData();
          emit(CoronaUploadProfileURLToFireStoreSuccessState());
        }).catchError((onError) {
          emit(CoronaUploadProfileURLToFireStoreErrorState(onError.toString()));
        });
        print(value);
      }).catchError((onError) {});
      emit(CoronaUploadProfileImageSuccessState());
    }).catchError((onError) {
      print('upload error:${onError.toString()}');
      emit(CoronaUploadProfileImageErrorState(onError.toString()));
    });
  }

  // update profile
  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String birthDate,
    required String country,
  }) {
    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'name': name,
      'email': email,
      'phone': phone,
      'birthDate': birthDate,
      'country': country,
    }).then((value) {
      getUserData();
      emit(CoronaUpdateProfileSuccessState());
    }).catchError((onError) {
      emit(CoronaUpdateProfileErrorState(onError.toString()));
    });
  }

  // sign out
  void signOut({
    required BuildContext context,
  }) {
    emit(CoronaSignOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) async {
      await CasheHelper.removeData(key: 'uId').then((value) {
        navigateAndFinish(context: context, widget: LoginScreen());
      }).catchError((onError) {});
      emit(CoronaSignOutSuccessState());
    }).catchError((onError) {
      emit(CoronaSignOutErrorState(onError.toString()));
    });
  }

  void changeAppMode() {
    isDark = !isDark;
    print('isDark: $isDark');
    emit(CoronaChangeAppModeState());
  }

  void onChangeDropDownButtonValue(String language) {
    CasheHelper.saveData(key: 'language', value: '$language').then((value) {
      currentLanguage = language;
      emit(CoronaChangeDropDownButtonValueState());
    }).catchError((onError) {
      print('onCasheHelperError:$onError');
    });
  }
}
