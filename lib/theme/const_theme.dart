import 'package:flutter/material.dart';

abstract class ThemeColor {
  static const mainColorDark = Color.fromRGBO(58, 58, 58, 1);
  static const mainColorLight = Color.fromRGBO(212, 212, 212, 1);
  static const mainColorGreen = Color.fromRGBO(199, 255, 208, 1);
  static const backGrounColor = Color.fromRGBO(255, 255, 255, 1);
  static const hintTextColor = Color.fromRGBO(58, 58, 58, 0.2);
  static const buttonMainColor = Color.fromRGBO(255, 170, 170, 1);
  static const confirmAgreeColor = Color.fromRGBO(199, 255, 208, 1);
  static const confirmRejectColor = Color.fromRGBO(255, 171, 170, 1);
}

abstract class ThemeFontFamily {
  static const montserratBlack = 'Montserrat-Black';
  static const montserratBold = 'Montserrat-Bold';
  static const montserratRegular = 'Montserrat-Regular';
}

abstract class ThemeText {
  static const labelTextTheme = TextStyle(
      color: ThemeColor.mainColorDark,
      fontFamily: 'Montserrat-Black',
      fontSize: 36);
  static const darkTextTheme = TextStyle(
      color: ThemeColor.mainColorDark,
      fontFamily: 'Montserrat-Regular',
      fontWeight: FontWeight.w400,
      fontSize: 18);
  static const lightTextTheme = TextStyle(
      color: ThemeColor.mainColorLight,
      fontFamily: 'Montserrat-Regular',
      fontWeight: FontWeight.w400,
      fontSize: 18);
  static const hintTextTheme = TextStyle(
      color: ThemeColor.hintTextColor,
      fontSize: 18,
      fontFamily: 'Montserrat-Regular',
      fontWeight: FontWeight.w400);
  static const menuTextTheme = TextStyle(
      color: ThemeColor.mainColorDark,
      fontSize: 18,
      fontFamily: ThemeFontFamily.montserratBold);
}

abstract class ThemeButtons {
  static final darkButtonTheme = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(ThemeColor.mainColorDark),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );

  static final lightButtonTheme = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(ThemeColor.mainColorLight),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );

  static final menuButtonTheme = OutlinedButton.styleFrom(
    side: const BorderSide(color: Colors.transparent),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: Colors.grey[350],
  );
}

abstract class ThemeTextField {
  static final textFieldEmailTheme = InputDecoration(
    isDense: true,
    filled: true,
    fillColor: ThemeColor.mainColorLight,
    hintText: 'Enter email',
    hintStyle: ThemeText.hintTextTheme,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final textFieldPasswordTheme = InputDecoration(
    isDense: true,
    filled: true,
    fillColor: ThemeColor.mainColorLight,
    hintText: 'Enter Password',
    hintStyle: ThemeText.hintTextTheme,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final textFieldPasswordConfirmTheme = InputDecoration(
    isDense: true,
    filled: true,
    fillColor: ThemeColor.mainColorLight,
    hintText: 'Enter Password',
    hintStyle: ThemeText.hintTextTheme,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
