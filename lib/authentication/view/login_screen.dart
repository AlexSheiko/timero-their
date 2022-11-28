import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/app/view/loader.dart';
import 'package:timero/authentication/logic/auth_state.dart';
import 'package:timero/authentication/logic/login_cubit.dart';
import 'package:timero/authentication/view/forgot_password_screen.dart';
import 'package:timero/home/view/open_screen.dart';
import 'package:timero/theme/const_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    double mediaSize = MediaQuery.of(context).size.height > 760
        ? MediaQuery.of(context).size.height / 15
        : MediaQuery.of(context).size.height / 18;
    return CustomLoaderOverlay(
      child: BlocListener<LoginCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const OpenScreen(),
              ),
            );
          } else if (state is AuthFailure) {
            setState(() {
              if (state.errorMessage.isNotEmpty) {
                errorMessage = 'Email and / or password incorrect';
              } else {
                errorMessage = '';
              }
            });
          }
          if (state is AuthInProgress) {
            context.loaderOverlay.show();
            setState(() {
              errorMessage = '';
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
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(0, mediaSize * 1.8, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Log in',
                        style: ThemeText.labelTextTheme,
                      ),
                    ),
                    SizedBox(height: mediaSize),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email:',
                            style: ThemeText.darkTextTheme,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height > 760
                                  ? 20
                                  : 10),
                          SizedBox(
                            width: 338,
                            child: TextFormField(
                              // key: UniqueKey(),
                              decoration: ThemeTextField.textFieldEmailTheme,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              autofillHints: const [AutofillHints.email],
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(height: mediaSize / 2),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height > 760
                                    ? 20
                                    : 10),
                            child: const Text(
                              'Password:',
                              style: ThemeText.darkTextTheme,
                            ),
                          ),
                          SizedBox(
                            width: 338,
                            child: TextField(
                              decoration: ThemeTextField.textFieldPasswordTheme,
                              obscureText: true,
                              controller: _passwordController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height > 770 ? 0 : 20),
                    SizedBox(
                      height: mediaSize * 2 - 14,
                      child: Center(
                        child: Text(
                          errorMessage.toString(),
                          style: const TextStyle(
                            fontFamily: ThemeFontFamily.montserratRegular,
                            fontSize: 18,
                            color: Color.fromRGBO(255, 171, 170, 1),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        wideButton(
                          text: 'Log in',
                          onPressed: () {
                            BlocProvider.of<LoginCubit>(context).login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                          buttonColor: ThemeColor.mainColorDark,
                          textColor: ThemeColor.mainColorLight,
                        ),
                        SizedBox(height: mediaSize / 2 + 2),
                        wideButton(
                          text: 'Forgot password',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          buttonColor: ThemeColor.mainColorLight,
                          textColor: ThemeColor.mainColorDark,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: mediaSize / 3),
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
