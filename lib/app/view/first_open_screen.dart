import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/authentication/view/login_screen.dart';
import 'package:timero/authentication/view/sign_up_screen.dart';
import 'package:timero/current_user/data/current_user.dart';
import 'package:timero/current_user/logic/current_user_cubit.dart';
import 'package:timero/home/view/open_screen.dart';
import 'package:timero/theme/const_theme.dart';

class FirstOpenScreen extends StatefulWidget {
  const FirstOpenScreen({Key? key}) : super(key: key);

  @override
  State<FirstOpenScreen> createState() => _FirstOpenScreenState();
}

class _FirstOpenScreenState extends State<FirstOpenScreen> {
  @override
  void initState() {
    _skipLoginIfNeeded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaSize = MediaQuery.of(context).size.height > 760
        ? MediaQuery.of(context).size.height / 15
        : MediaQuery.of(context).size.height / 18;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor.backGrounColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: ThemeColor.backGrounColor,
            padding: EdgeInsets.fromLTRB(0, mediaSize * 1.8, 0, 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Quit timer',
                    style: ThemeText.labelTextTheme,
                  ),
                  SizedBox(height: mediaSize - 20),
                  const Image(
                    height: 280,
                    image:
                        AssetImage('assets/image_from_first_open_screen.png'),
                  ),
                  SizedBox(height: mediaSize + 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      wideButton(
                        text: 'Sign up',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        buttonColor: ThemeColor.mainColorDark,
                        textColor: ThemeColor.mainColorLight,
                      ),
                      SizedBox(height: mediaSize / 2),
                      wideButton(
                        text: 'Log in',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        buttonColor: ThemeColor.mainColorLight,
                        textColor: ThemeColor.mainColorDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _skipLoginIfNeeded() async {
    final currentUserCubit = context.read<CurrentUserCubit>();
    await currentUserCubit.onPageOpened();
    final isLoggedIn = currentUserCubit.currentUser != CurrentUser.loggedOut();
    if (isLoggedIn) {
      _skipLogin();
    }
  }

  void _skipLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const OpenScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
        (route) => false,
      );
    });
  }
}
