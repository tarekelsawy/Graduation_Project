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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  static List<double> qCounters = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ];
  static double qPresult = 0;

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

  static String? imageCovidPercent;
  uploadImage({File? imageFile}) async {
    emit(CoronaUploadImageToServerLoadingState());
    print("before link");
    final request = http.MultipartRequest(
        'POST', Uri.parse('https://cb92-197-135-125-140.eu.ngrok.io/upload'));
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

        imageCovidPercent = resJson['Covid'];
        print('percent1:$imageCovidPercent');
        FirebaseFirestore.instance.collection('image').doc(uId).update({
          'covid_percent': resJson['Covid'],
          'normal_percent': resJson['Normal'],
        }).then((value) {
          emit(CoronaUploadImageToServerSuccessState());
        }).onError((error, stackTrace) {
          print(
              'error in upload percent covid to firebase ${onError.toString()}');
        });
      }).onError((error, stackTrace) {
        print("error in stream${error.toString()}");
      });
    }).onError((error, stackTrace) {
      print("error in request${error.toString()}");
    });
  }

  //firebase get user
  static UserModel? userModel;
  void getUserData() {
    emit(CoronaGetUserLoadingState());
    print('uIdgetUser:$uId');
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      print('uId:$uId');
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

  void uploadQuestionDataToFireStore() {
    emit(CoronaUploadQuestionToFirebaseLoadingState());
    print('uid Error q:$uId');
    FirebaseFirestore.instance.collection('questions').doc(uId).update({
      'temprature': qResult[0],
      'cough': qResult[1],
      'tiredness': qResult[2],
      'smell_taste': qResult[3],
      'breathe': qResult[4],
      'headache': qResult[5],
      'runny_nose': qResult[6],
      'chest_pain': qResult[7],
    }).then((value) {
      print('Question successfully Uploaded');
      emit(CoronaUploadQuestionToFirebaseSuccessState());
    }).catchError((onError) {
      print('Error upload question:${onError.toString()}');
      emit(CoronaUploadQuestionToFirebaseErrorState());
    });
  }

  void uploadTestResultDataToFireStore({required String res}) {
    emit(CoronaUploadTestResultToFirebaseLoadingState());
    FirebaseFirestore.instance.collection('test_result').doc(uId).update({
      'infected': res,
    }).then((value) {
      print('TestResult successfully Uploaded');
      emit(CoronaUploadTestResultToFirebaseSuccessState());
    }).catchError((onError) {
      print('Error upload TestResult:${onError.toString()}');
      emit(CoronaUploadTestResultToFirebaseErrorState());
    });
  }

  void uploadFeedbackDataToFireStore({
    required String feedback,
    required String positive,
    required String negative,
  }) {
    emit(CoronaUploadFeedbackToFirebaseLoadingState());
    FirebaseFirestore.instance.collection('feedback').doc(uId).update({
      'feedback': feedback,
      'negative_percent': negative,
      'positive_percent': positive,
    }).then((value) {
      print('feedback successfully Uploaded');
      emit(CoronaUploadFeedbackToFirebaseSuccessState());
    }).catchError((onError) {
      print('Error upload feedback:${onError.toString()}');
      emit(CoronaUploadFeedbackToFirebaseErrorState());
    });
  }

  String? positive;
  String? negative;
  void sendReview(String input) {
    emit(CoronaUploadReviewToPythonLoadingState());
    print('input:$input');
    final url = 'https://b4e1-197-40-217-105.eu.ngrok.io/review';
    final response = http
        .post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'review': input.toString(),
      }),
    )
        .then((value) {
      print('value http: ${value.reasonPhrase}');

      // final res = jsonDecode(value.body) as Map<String, dynamic>;
      // print('res:${res['positive']}');
      positive = jsonDecode(value.body)['positive'].toString();
      negative = jsonDecode(value.body)['negative'].toString();
      uploadFeedbackDataToFireStore(
        feedback: input,
        positive: positive ?? '0.7',
        negative: negative ?? '0.0',
      );
      print('result from review: ${jsonDecode(value.body)['positive']}');
      print('result from review: ${jsonDecode(value.body)['negative']}');
      emit(CoronaUploadReviewToPythonSuccessState());
    }).catchError((onError) {
      print('${onError.toString()}');
      emit(CoronaUploadReviewToPythonErrorState());
    });
    ;
  }
}
