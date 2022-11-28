import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timero/app/view/first_open_screen.dart';
import 'package:timero/app/view/loader.dart';
import 'package:timero/authentication/view/change_password_screen.dart';
import 'package:timero/settings/logic/settings_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SettingsCubit>(context).getEmail();
    return CustomLoaderOverlay(
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is LogOutState) {
            context.loaderOverlay.hide();
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is SettingsFailure) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          } else if (state is SettingsInProgress) {
            context.loaderOverlay.show();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 28, bottom: 28, left: 20),
                    child: SizedBox(
                      height: 55,
                      width: 398,
                      child: Text(
                        'Quit timer',
                        style: TextStyle(
                            fontFamily: ThemeFontFamily.montserratRegular,
                            fontSize: 20,
                            color: ThemeColor.mainColorDark),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      String? email;
                      if (state is EmailReadyState) {
                        email = state.email;
                      }
                      return SizedBox(
                        width: 398,
                        height: 55,
                        child: OutlinedButton(
                          style: ThemeButtons.menuButtonTheme,
                          onPressed: () {},
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                email.toString(),
                                style: ThemeText.darkTextTheme,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 55,
                    width: 398,
                    child: OutlinedButton(
                      style: ThemeButtons.menuButtonTheme,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Change password',
                        style: ThemeText.menuTextTheme,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 55,
                    width: 398,
                    child: OutlinedButton(
                      style: ThemeButtons.menuButtonTheme,
                      onPressed: () {
                        BlocProvider.of<SettingsCubit>(context).logOut();
                        // Show login screen
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const FirstOpenScreen(),
                            ),
                            (route) => false);
                      },
                      child: const Text(
                        'Log out',
                        style: ThemeText.menuTextTheme,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Back',
                        style: ThemeText.darkTextTheme,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
