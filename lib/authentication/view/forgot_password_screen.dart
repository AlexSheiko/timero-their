import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/app/view/loader.dart';
import 'package:timero/authentication/logic/auth_state.dart';
import 'package:timero/authentication/logic/forgot_password_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mediaSize = MediaQuery.of(context).size.height > 760
        ? MediaQuery.of(context).size.height / 15
        : MediaQuery.of(context).size.height / 18;
    return CustomLoaderOverlay(
      child: BlocListener<ForgotPasswordCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        'Forgot password',
                        style: ThemeText.labelTextTheme,
                        textAlign: TextAlign.center,
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
                                : 10,
                          ),
                          SizedBox(
                            width: 338,
                            child: TextFormField(
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                              // validator: (email) => email != null &&
                              //         EmailValidator.validate(email)
                              //     ? null
                              //     : 'Enter a valid email',
                              decoration: ThemeTextField.textFieldEmailTheme,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              autofillHints: const [AutofillHints.email],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mediaSize * 6 - 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wideButton(
                          text: 'Recovery password',
                          onPressed: () {
                            BlocProvider.of<ForgotPasswordCubit>(context)
                                .recoverPassword(
                              email: _emailController.text,
                            );
                          },
                          buttonColor: ThemeColor.mainColorDark,
                          textColor: ThemeColor.mainColorLight,
                        ),
                        SizedBox(height: mediaSize / 3),
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
    );
  }
}
