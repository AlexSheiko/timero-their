import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/settings/logic/settings_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class ChangeEmailWidget extends StatefulWidget {
  const ChangeEmailWidget({super.key});

  @override
  State<ChangeEmailWidget> createState() => _ChangeEmailWidgetState();
}

class _ChangeEmailWidgetState extends State<ChangeEmailWidget> {
  String email = '';
  bool emailSelect = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is EmailReadyState) {
          email = state.email;
        }
        return Container(
          constraints: const BoxConstraints(minHeight: 55, minWidth: 398),
          child: OutlinedButton(
            style: ThemeButtons.menuButtonTheme,
            onPressed: () {
              setState(() {
                emailSelect = !emailSelect;
              });
            },
            child: emailSelect == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.5),
                    child: Column(
                      children: [
                        const Text(
                          'Change email',
                          style: ThemeText.darkTextTheme,
                          maxLines: 1,
                        ),
                        Text(email),
                      ],
                    ),
                  )
                : const Text(
                    'Change email',
                    style: ThemeText.darkTextTheme,
                  ),
          ),
        );
      },
    );
  }
}
