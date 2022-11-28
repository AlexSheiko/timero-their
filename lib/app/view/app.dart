import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:timero/app/view/colors.dart';
import 'package:timero/app/view/first_open_screen.dart';
import 'package:timero/authentication/data/repository/change_password_repository.dart';
import 'package:timero/authentication/data/repository/forgot_password_repository.dart';
import 'package:timero/authentication/data/repository/login_repository.dart';
import 'package:timero/authentication/data/repository/sign_up_repository.dart';
import 'package:timero/authentication/logic/change_password_cubit.dart';
import 'package:timero/authentication/logic/forgot_password_cubit.dart';
import 'package:timero/authentication/logic/login_cubit.dart';
import 'package:timero/authentication/logic/sign_up_cubit.dart';
import 'package:timero/current_user/data/current_user_repository.dart';
import 'package:timero/current_user/logic/current_user_cubit.dart';
import 'package:timero/home/data/goals_repository.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/premium/data/premium_repository.dart';
import 'package:timero/premium/logic/premium_cubit.dart';
import 'package:timero/settings/data/settings_repository.dart';
import 'package:timero/settings/logic/settings_cubit.dart';

class App extends StatelessWidget {
  App({
    this.initialPage = const FirstOpenScreen(),
    required this.goalsRepository,
    required this.currentUserRepository,
    required this.premiumRepository,
    super.key,
  });

  final Widget initialPage;
  final GoalsRepository goalsRepository;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final PremiumRepository premiumRepository;

  //final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final CurrentUserRepository currentUserRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: AppView(initialPage),
    );
  }

  List<SingleChildWidget> get allProviders {
    return [
      BlocProvider(
          create: (context) =>
              GoalsCubit(goalsRepository, currentUserRepository)),
      BlocProvider(
          create: (context) =>
              SignUpCubit(SignUpRepository(auth), currentUserRepository)),
      BlocProvider(
          create: (context) =>
              LoginCubit(LoginRepository(auth), currentUserRepository)),
      BlocProvider(
          create: (context) => CurrentUserCubit(currentUserRepository)),
      BlocProvider(
          create: (context) =>
              ForgotPasswordCubit(ForgotPasswordRepository(auth))),
      BlocProvider(
          create: (context) =>
              SettingsCubit(SettingsRepository(auth), currentUserRepository)),
      BlocProvider(
          create: (context) => ChangePasswordCubit(
              ChangePasswordRepository(auth), currentUserRepository)),
      BlocProvider(create: (context) => PremiumCubit(premiumRepository)),
    ];
  }
}

class AppView extends StatelessWidget {
  const AppView(
    this.initialPage, {
    super.key,
  });

  final Widget initialPage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        textTheme: GoogleFonts.montserratTextTheme(),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: ComponentColors.error,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: initialPage,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
    );
  }
}
