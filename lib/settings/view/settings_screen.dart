import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timero/app/view/first_open_screen.dart';
import 'package:timero/app/view/loader.dart';
import 'package:timero/settings/logic/settings_cubit.dart';
import 'package:timero/settings/view/components/logo.dart';
import 'package:timero/theme/const_theme.dart';

import 'components/change_email_widget.dart';

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
                children: const [
                  LogoWidget(),
                  SizedBox(height: 10),
                  ChangeEmailWidget(),
                  SizedBox(height: 10),
                  ChangePasswordWidget(),
                  SizedBox(height: 10),
                  LogOutWidget(),
                  SizedBox(height: 20),
                  BackWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 398,
      child: OutlinedButton(
        style: ThemeButtons.menuButtonTheme,
        onPressed: () {},
        child: const Text(
          'Change password',
          style: ThemeText.darkTextTheme,
        ),
      ),
    );
  }
}

class LogOutWidget extends StatefulWidget {
  const LogOutWidget({super.key});

  @override
  State<LogOutWidget> createState() => _LogOutWidgetState();
}

class _LogOutWidgetState extends State<LogOutWidget> {
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
        child: SizedBox(
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
              style: ThemeText.darkTextTheme,
            ),
          ),
        ),
      ),
    );
  }
}

class BackWidget extends StatelessWidget {
  const BackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text(
        'Back',
        style: ThemeText.darkTextTheme,
      ),
    );
  }
}
