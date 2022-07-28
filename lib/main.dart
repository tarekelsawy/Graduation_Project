import 'dart:io';

import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/layout/home/home_screen.dart';
import 'package:corona_test_project/modules/register_login/cubit/cubit.dart';
import 'package:corona_test_project/modules/result/result_screen.dart';
import 'package:corona_test_project/modules/review/review.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/modules/start_test/start.dart';
import 'package:corona_test_project/modules/test_completed/test_completed.dart';
import 'package:corona_test_project/shared/bloc_observer.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:corona_test_project/shared/network/local/cashe_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'modules/corona_splash_screen/corona_splash_screen.dart';
import 'modules/corona_test_screens/questions_screen.dart';
import 'modules/edit_profile_screen/edit_profile_screen.dart';
import 'modules/on_boarding/onboarding_screen.dart';
import 'modules/register_login/login_screen/login_screen.dart';
import 'modules/setting/setting_screen.dart';

void main() async {
  BlocOverrides.runZoned(
    () async {
      HttpOverrides.global = MyHttpOverrides();
      WidgetsFlutterBinding.ensureInitialized();
      await CasheHelper.init();
      await Firebase.initializeApp();
      Widget startWidget = LoginScreen();

      uId = CasheHelper.getData(key: 'uId') ?? uId;
      print('$uId');
      isDark = CasheHelper.getData(key: 'isDark') ?? true;

      currentLanguage = CasheHelper.getData(key: 'language') ?? currentLanguage;
      if (uId != null) {
        startWidget = HomeScreen();
      } else {
        startWidget = LoginScreen();
      }
      runApp(MyApp(startWidget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startScreen;

  MyApp(this.startScreen);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => CoronaCubit()..getUserData()),
        ),
        BlocProvider(
          create: ((context) => LoginAndRegisterCubit()),
        ),
      ],
      child: BlocConsumer<CoronaCubit, CoronaStates>(
        listener: (context, state) {
          if (state is CoronaChangeAppModeState) {
            print('state of mode');
          }
        },
        builder: (context, state) {
          return MaterialApp(
            locale: Locale('$currentLanguage'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
              Locale('ar', ''), // Arabic, no country code
            ],
            home: CoronaTestSplashScreen(startScreen: startScreen),
            debugShowCheckedModeBanner: false,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              primaryColorDark: colorPurple,
              primarySwatch: Colors.deepPurple,
              iconTheme: const IconThemeData(
                color: colorBlack,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: colorWhite,
              ),
              drawerTheme: DrawerThemeData(
                backgroundColor: colorWhite,
                elevation: 10.0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
              ),
              scaffoldBackgroundColor: colorWhite,
              sliderTheme: const SliderThemeData(
                inactiveTrackColor: Colors.deepPurple,
                thumbColor: Colors.deepPurple,
                overlayColor: Colors.deepPurple,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
              ),
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarIconBrightness: Brightness.dark,
                ),
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),
                backgroundColor: Colors.white,
              ),
              fontFamily: 'Lato',
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                bodyText2: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primaryColorDark: colorYellow,
              primarySwatch: Colors.yellow,
              iconTheme: IconThemeData(
                color: colorWhite,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: colorYellow,
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: colorBlack,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
              ),
              scaffoldBackgroundColor: colorBlack,
              sliderTheme: const SliderThemeData(
                inactiveTrackColor: colorBlack,
                thumbColor: colorBlack,
                overlayColor: colorBlack,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 17.0),
              ),
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.light,
                ),
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  fontFamily: 'Lato',
                ),
                backgroundColor: colorBlack,
              ),
              fontFamily: 'Lato',
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                bodyText2: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
