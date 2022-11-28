import 'package:flutter/material.dart';
import 'package:timero/theme/const_theme.dart';

Widget wideButton({
  required String text,
  required VoidCallback onPressed,
  required Color? buttonColor,
  required Color? textColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 67),
    child: Container(
      constraints: const BoxConstraints(maxWidth: 338),
      height: 60,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.transparent),
            // elevation: 4,
            // shadowColor: ThemeColor.mainColorDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            fixedSize: const Size(255, 60),
            backgroundColor: buttonColor),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            fontFamily: 'Montserrat-Regular',
          ),
        ),
      ),
    ),
  );
}

Widget narrowButton({
  required String text,
  required VoidCallback onPressed,
  required Color? buttonColor,
  required Color? textColor,
}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        shadowColor: Colors.grey,
        fixedSize: const Size(210, 60),
        backgroundColor: buttonColor),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          fontFamily: ThemeFontFamily.montserratRegular),
    ),
  );
}

Widget optionsMenuButton({
  required String text,
  required VoidCallback onPressed,
  required Color? buttonColor,
  required Color? textColor,
}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        shadowColor: Colors.grey,
        fixedSize: const Size(120, 60),
        backgroundColor: buttonColor),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          fontFamily: ThemeFontFamily.montserratRegular),
    ),
  );
}
