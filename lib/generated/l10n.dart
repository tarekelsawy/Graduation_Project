// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: 'Corona app setting',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: 'Corona app mode',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Corona app language',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: 'Corona app en',
      args: [],
    );
  }

  /// `Arabic`
  String get ar {
    return Intl.message(
      'Arabic',
      name: 'ar',
      desc: 'Corona app ar',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: 'Corona app editProfile',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enterYourName {
    return Intl.message(
      'Enter Your Name',
      name: 'enterYourName',
      desc: 'Corona app enterYourName',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enterYourEmail {
    return Intl.message(
      'Enter Your Email',
      name: 'enterYourEmail',
      desc: 'Corona app enterYourEmail',
      args: [],
    );
  }

  /// `Enter Your Phone`
  String get enterYourPhone {
    return Intl.message(
      'Enter Your Phone',
      name: 'enterYourPhone',
      desc: 'Corona app enterYourPhone',
      args: [],
    );
  }

  /// `Enter Your BirthDate`
  String get enterYourBirthDate {
    return Intl.message(
      'Enter Your BirthDate',
      name: 'enterYourBirthDate',
      desc: 'Corona app enterYourBirthDate',
      args: [],
    );
  }

  /// `Enter Your State`
  String get enterYourState {
    return Intl.message(
      'Enter Your State',
      name: 'enterYourState',
      desc: 'Corona app enterYourState',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: 'Corona app updateProfile',
      args: [],
    );
  }

  /// `Country Search`
  String get countrySearch {
    return Intl.message(
      'Country Search',
      name: 'countrySearch',
      desc: 'Corona app countrySearch',
      args: [],
    );
  }

  /// `Start typing to search`
  String get typeCountrySearch {
    return Intl.message(
      'Start typing to search',
      name: 'typeCountrySearch',
      desc: 'Corona app typeCountrySearch',
      args: [],
    );
  }

  /// `Home`
  String get homePage {
    return Intl.message(
      'Home',
      name: 'homePage',
      desc: 'Corona app homePage',
      args: [],
    );
  }

  /// `Questions`
  String get questions {
    return Intl.message(
      'Questions',
      name: 'questions',
      desc: 'Corona app questions',
      args: [],
    );
  }

  /// `Image Processing`
  String get imageProcessing {
    return Intl.message(
      'Image Processing',
      name: 'imageProcessing',
      desc: 'Corona app imageProcessing',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: 'Corona app result',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: 'Corona app help',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Corona app logout',
      args: [],
    );
  }

  /// `Scale body temprature (fever)`
  String get q1 {
    return Intl.message(
      'Scale body temprature (fever)',
      name: 'q1',
      desc: 'Corona app fever',
      args: [],
    );
  }

  /// `Is there any Cough?`
  String get q2 {
    return Intl.message(
      'Is there any Cough?',
      name: 'q2',
      desc: 'Corona app Cough',
      args: [],
    );
  }

  /// `physical fatigue (tiredness)`
  String get q3 {
    return Intl.message(
      'physical fatigue (tiredness)',
      name: 'q3',
      desc: 'Corona app tiredness',
      args: [],
    );
  }

  /// `Loss of Smell and Taste`
  String get q4 {
    return Intl.message(
      'Loss of Smell and Taste',
      name: 'q4',
      desc: 'Corona app Taste',
      args: [],
    );
  }

  /// `Difficulity or shortness of breathe`
  String get q5 {
    return Intl.message(
      'Difficulity or shortness of breathe',
      name: 'q5',
      desc: 'Corona app breathe',
      args: [],
    );
  }

  /// `aches and pains (headache)`
  String get q6 {
    return Intl.message(
      'aches and pains (headache)',
      name: 'q6',
      desc: 'Corona app headache',
      args: [],
    );
  }

  /// `Runny Nose`
  String get q7 {
    return Intl.message(
      'Runny Nose',
      name: 'q7',
      desc: 'Corona app Runny Nose',
      args: [],
    );
  }

  /// `Chest Pain`
  String get q8 {
    return Intl.message(
      'Chest Pain',
      name: 'q8',
      desc: 'Corona app Chest Pain',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: 'Corona app high',
      args: [],
    );
  }

  /// `Normal`
  String get normal {
    return Intl.message(
      'Normal',
      name: 'normal',
      desc: 'Corona app normal',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: 'Corona app no',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: 'Corona app yes',
      args: [],
    );
  }

  /// `Whole Body`
  String get wholeBody {
    return Intl.message(
      'Whole Body',
      name: 'wholeBody',
      desc: 'Corona app wholeBody',
      args: [],
    );
  }

  /// `None Tired`
  String get noneTired {
    return Intl.message(
      'None Tired',
      name: 'noneTired',
      desc: 'Corona app noneTired',
      args: [],
    );
  }

  /// `LOW`
  String get low {
    return Intl.message(
      'LOW',
      name: 'low',
      desc: 'Low',
      args: [],
    );
  }

  /// `Hard`
  String get hard {
    return Intl.message(
      'Hard',
      name: 'hard',
      desc: 'Hard',
      args: [],
    );
  }

  /// `Easy`
  String get easy {
    return Intl.message(
      'Easy',
      name: 'easy',
      desc: 'Easy',
      args: [],
    );
  }

  /// `Painful`
  String get paintful {
    return Intl.message(
      'Painful',
      name: 'paintful',
      desc: 'paintful',
      args: [],
    );
  }

  /// `No Pain`
  String get nopain {
    return Intl.message(
      'No Pain',
      name: 'nopain',
      desc: 'No Pain',
      args: [],
    );
  }

  /// `Runny`
  String get runny {
    return Intl.message(
      'Runny',
      name: 'runny',
      desc: 'Runny',
      args: [],
    );
  }

  /// `Choose MRI Image`
  String get image {
    return Intl.message(
      'Choose MRI Image',
      name: 'image',
      desc: 'Choose MRI Image',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: 'Skip',
      args: [],
    );
  }

  /// `Image Preview`
  String get imagePreview {
    return Intl.message(
      'Image Preview',
      name: 'imagePreview',
      desc: 'Image Preview',
      args: [],
    );
  }

  /// `Gallary`
  String get gallary {
    return Intl.message(
      'Gallary',
      name: 'gallary',
      desc: 'Gallary',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: 'Camera',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: 'Details',
      args: [],
    );
  }

  /// `You should see a doctor`
  String get seeADoc {
    return Intl.message(
      'You should see a doctor',
      name: 'seeADoc',
      desc: 'You should see a doctor',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
