import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/app/view/loader.dart';
import 'package:timero/authentication/logic/auth_state.dart';
import 'package:timero/authentication/logic/sign_up_cubit.dart';
import 'package:timero/home/view/open_screen.dart';
import 'package:timero/theme/const_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? errorMessage;
  String mailErrorMessage = '';
  String passwordErrorMessage = '';
  String confirmPasswordErrorMessage = '';
  Color isValidEmailColor = ThemeColor.mainColorLight;
  Color isValidPasswordColor = ThemeColor.mainColorLight;
  Color isValidConfirmPasswordColor = ThemeColor.mainColorLight;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (kDebugMode) {
      //   _emailController.text = 'alexsheikodev@gmail.com';
      //   _passwordController.text = 'mytestpass';
      //   _confirmPasswordController.text = 'mytestpass';
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaSize = MediaQuery.of(context).size.height > 760
        ? MediaQuery.of(context).size.height / 15
        : MediaQuery.of(context).size.height / 18;
    return CustomLoaderOverlay(
      child: BlocListener<SignUpCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const OpenScreen(),
              ),
            );
          } else if (state is AuthFailure) {
            setState(() {
              errorMessage = state.errorMessage;
              if (state.errorMessage.contains('email-already-in-use')) {
                mailErrorMessage = 'email-already-in-use';
              } else {
                mailErrorMessage = 'Valid';
              }

              // if (state.errorMessage.contains('wrong-password') ||
              //     state.errorMessage.contains('weak-password')) {
              //   errorPassword = errorMessage;
              // } else {
              //   errorPassword = null;
              // }
              // Color isValidColor = state.errorMessage.isEmpty
              //     ? const Color.fromRGBO(199, 255, 208, 1)
              //     : const Color.fromRGBO(255, 171, 170, 1);
            });
          }
          if (state is AuthInProgress) {
            context.loaderOverlay.show();
            setState(() {
              errorMessage = null;
            });
          } else {
            context.loaderOverlay.hide();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ThemeColor.backGrounColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                color: ThemeColor.backGrounColor,
                padding: EdgeInsets.fromLTRB(0, mediaSize * 1.8, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Sign up',
                        style: ThemeText.labelTextTheme,
                      ),
                    ),
                    SizedBox(height: mediaSize),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 325,
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height > 760
                                    ? 20
                                    : 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Email:',
                                  style: ThemeText.darkTextTheme,
                                ),
                                Text(mailErrorMessage),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 338,
                            child: TextFormField(
                              decoration:
                                  ThemeTextField.textFieldEmailTheme.copyWith(
                                suffix: Icon(
                                  Icons.circle,
                                  size: 11,
                                  color: isValidEmailColor,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              autofillHints: const [AutofillHints.email],
                              textInputAction: TextInputAction.next,
                              onChanged: ((value) {
                                setState(() {
                                  if (value.contains('mail.com') &&
                                      value.contains('@')) {
                                    isValidEmailColor =
                                        const Color.fromRGBO(199, 255, 208, 1);
                                    mailErrorMessage = 'Valid';
                                  } else {
                                    isValidEmailColor =
                                        const Color.fromRGBO(255, 171, 170, 1);
                                    mailErrorMessage = 'Invalid';
                                  }
                                });
                              }),
                            ),
                          ),
                          SizedBox(height: mediaSize / 2),
                          Container(
                            width: 325,
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height > 760
                                    ? 20
                                    : 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Password:',
                                  style: ThemeText.darkTextTheme,
                                ),
                                Text(passwordErrorMessage),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 338,
                            child: TextField(
                              decoration: ThemeTextField.textFieldPasswordTheme
                                  .copyWith(
                                suffix: Icon(
                                  Icons.circle,
                                  size: 11,
                                  color: isValidPasswordColor,
                                ),
                              ),
                              obscureText: true,
                              controller: _passwordController,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                setState(() {
                                  if (value.length > 5) {
                                    passwordErrorMessage = 'Valid';
                                    isValidPasswordColor =
                                        const Color.fromRGBO(199, 255, 208, 1);
                                  } else {
                                    passwordErrorMessage = 'Weak';
                                    isValidPasswordColor =
                                        const Color.fromRGBO(255, 171, 170, 1);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(height: mediaSize / 2),
                          Container(
                            width: 325,
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height > 760
                                    ? 20
                                    : 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Confirm password:',
                                  style: ThemeText.darkTextTheme,
                                ),
                                Text(confirmPasswordErrorMessage),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 338.0,
                            child: TextFormField(
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                hintText: 'Enter Password',
                                fillColor: ThemeColor.mainColorLight,
                                hintStyle: ThemeText.hintTextTheme,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                suffix: Icon(
                                  Icons.circle,
                                  size: 11,
                                  color: isValidConfirmPasswordColor,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  if (_passwordController.text == value &&
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
                              controller: _confirmPasswordController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mediaSize + 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        wideButton(
                          text: 'Sign up',
                          onPressed: () {
                            if (mailErrorMessage == 'Valid' &&
                                passwordErrorMessage == 'Valid' &&
                                confirmPasswordErrorMessage == 'Matched') {
                              BlocProvider.of<SignUpCubit>(context).signUp(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            } else {
                              null;
                            }
                          },
                          buttonColor: (mailErrorMessage == 'Valid' &&
                                  confirmPasswordErrorMessage == 'Matched')
                              ? ThemeColor.mainColorDark
                              : ThemeColor.mainColorDark.withOpacity(0.6),
                          textColor: ThemeColor.mainColorLight,
                        ),
                        SizedBox(height: mediaSize / 3),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(58, 58, 58, 1),
                                fontWeight: FontWeight.w400),
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
    );
  }
}
