import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/app/view/loader.dart';
import 'package:timero/authentication/logic/auth_state.dart';
import 'package:timero/authentication/logic/change_password_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  String currentPasswordErrorMessage = '';
  String newPasswordErrorMessage = '';
  String confirmPasswordErrorMessage = '';
  Color isValidCurrentPasswordColor = ThemeColor.mainColorLight;
  Color isValidNewPasswordColor = ThemeColor.mainColorLight;
  Color isValidConfirmPasswordColor = ThemeColor.mainColorLight;
  @override
  Widget build(BuildContext context) {
    double mediaSize = MediaQuery.of(context).size.height > 760
        ? MediaQuery.of(context).size.height / 15
        : MediaQuery.of(context).size.height / 18;
    return CustomLoaderOverlay(
      child: BlocListener<ChangePasswordCubit, AuthState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            context.loaderOverlay.hide();
            Navigator.of(context).pop();
          } else if (state is AuthFailure) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          } else if (state is AuthInProgress) {
            context.loaderOverlay.show();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ThemeColor.backGrounColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, mediaSize * 1.8, 0, 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text('Change password',
                            textAlign: TextAlign.center,
                            style: ThemeText.labelTextTheme),
                      ),
                      SizedBox(height: mediaSize),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 325,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Current password:',
                                    style: ThemeText.darkTextTheme,
                                  ),
                                  Text(
                                    currentPasswordErrorMessage,
                                    style: ThemeText.darkTextTheme.copyWith(
                                        fontFamily:
                                            ThemeFontFamily.montserratRegular),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height > 760
                                    ? 20
                                    : 10),
                            SizedBox(
                              width: 338,
                              child: TextField(
                                decoration: ThemeTextField
                                    .textFieldPasswordTheme
                                    .copyWith(
                                  hintText: 'Enter current password',
                                  suffix: Icon(
                                    Icons.circle,
                                    size: 11,
                                    color: isValidCurrentPasswordColor,
                                  ),
                                ),
                                obscureText: true,
                                controller: _currentPasswordController,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length > 5) {
                                      currentPasswordErrorMessage = 'Valid';
                                      isValidCurrentPasswordColor =
                                          const Color.fromRGBO(
                                              199, 255, 208, 1);
                                    } else {
                                      currentPasswordErrorMessage = 'Weak';
                                      isValidCurrentPasswordColor =
                                          const Color.fromRGBO(
                                              255, 171, 170, 1);
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: mediaSize / 2),
                            SizedBox(
                              width: 325,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'New password:',
                                    style: ThemeText.darkTextTheme,
                                  ),
                                  Text(
                                    newPasswordErrorMessage,
                                    style: ThemeText.darkTextTheme.copyWith(
                                        fontFamily:
                                            ThemeFontFamily.montserratRegular),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height > 760
                                    ? 20
                                    : 10),
                            SizedBox(
                              width: 338,
                              child: TextField(
                                decoration: ThemeTextField
                                    .textFieldPasswordTheme
                                    .copyWith(
                                  hintText: 'Enter new password',
                                  suffix: Icon(
                                    Icons.circle,
                                    size: 11,
                                    color: isValidNewPasswordColor,
                                  ),
                                ),
                                obscureText: true,
                                controller: _newPasswordController,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length > 5) {
                                      newPasswordErrorMessage = 'Valid';
                                      isValidNewPasswordColor =
                                          const Color.fromRGBO(
                                              199, 255, 208, 1);
                                    } else {
                                      newPasswordErrorMessage = 'Weak';
                                      isValidNewPasswordColor =
                                          const Color.fromRGBO(
                                              255, 171, 170, 1);
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: mediaSize / 2),
                            SizedBox(
                              width: 325,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Confirm password:',
                                    style: ThemeText.darkTextTheme,
                                  ),
                                  Text(
                                    confirmPasswordErrorMessage,
                                    style: ThemeText.darkTextTheme.copyWith(
                                        fontFamily:
                                            ThemeFontFamily.montserratRegular),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height > 760
                                    ? 20
                                    : 10),
                            SizedBox(
                              width: 338,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  suffix: Icon(
                                    Icons.circle,
                                    size: 11,
                                    color: isValidConfirmPasswordColor,
                                  ),
                                  isDense: true,
                                  filled: true,
                                  fillColor: ThemeColor.mainColorLight,
                                  hintText: 'Enter Confirm Password',
                                  hintStyle: ThemeText.hintTextTheme,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (_newPasswordController.text == value &&
                                        value.isNotEmpty) {
                                      isValidConfirmPasswordColor =
                                          ThemeColor.confirmAgreeColor;
                                      confirmPasswordErrorMessage = 'Matched';
                                    } else {
                                      isValidConfirmPasswordColor =
                                          ThemeColor.confirmRejectColor;
                                      confirmPasswordErrorMessage = 'Unmatched';
                                    }
                                  });
                                },
                                obscureText: true,
                                controller: _confirmNewPasswordController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mediaSize + 20,
                      ),
                      Column(
                        children: [
                          wideButton(
                            text: 'Change Password',
                            onPressed: () {
                              BlocProvider.of<ChangePasswordCubit>(context)
                                  .changePassword(
                                password: _newPasswordController.text,
                              );
                            },
                            buttonColor: ThemeColor.mainColorDark,
                            textColor: ThemeColor.mainColorLight,
                          ),
                          SizedBox(height: mediaSize / 2),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Back',
                              style: ThemeText.darkTextTheme,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
