import 'package:flutter/material.dart';
import '../../../theme/const_theme.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
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
    );
  }
}
