import 'package:flutter/material.dart';

class ComponentColors {
  static const primaryColor = _CustomColors.electricViolet;
  static const focusColor = _CustomColors.emerald;
  static const textColorPrimary = Colors.black;
  static final textColorSecondary = Colors.black.withOpacity(0.5);
  static const textColorInverted = Colors.white;
  static const gradientStart = _CustomColors.electricViolet;
  static const gradientEnd = _CustomColors.outrageousOrange;
  static const windowBackgroundLight = _CustomColors.concrete;
  static const windowBackgroundDark = _CustomColors.mineShaft;
  static const cardColorLight = Colors.white;
  static const cardColorDark = Colors.black;
  static const success = _CustomColors.fern;
  static const warning = _CustomColors.coral;
  static const error = _CustomColors.pomegranade;
  static const status = Colors.purple;
  static const link = _CustomColors.mineShaft;
  static const disabled = Colors.grey;
}

// Color names are from https://chir.ag/projects/name-that-color
class _CustomColors {
  static const emerald = Color(0xFF56CC94);
  static const electricViolet = Color(0xFF8C32FF);
  static const outrageousOrange = Color(0xFFFF5732);
  static const wildSand = Color(0xFFF6F6F6);
  static const concrete = Color(0xFFF2F2F2);
  static const mineShaft = Color(0xFF3E3E3E);
  static const alabaster = Color(0xFFF8F8F8);
  static const fern = Color(0xFF66BB6A);
  static const pomegranade = Color(0xFFF44336);
  static const coral = Color(0xFFFF8642);
}
