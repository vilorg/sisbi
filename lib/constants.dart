import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// colors
// accent colors
const Color colorAccentBlack = Color(0xFF283244);
const Color colorAccentDarkBlue = Color(0xFF575FCC);
const Color colorAccentLightBlue = Color(0xFF739EF1);
const Color colorAccentGold = Color(0xFFFABF48);
const Color colorAccentSoftGold = Color(0xFFFEF2DA);
const Color colorAccentRed = Color(0xFFFF6D3B);
const Color colorAccentGreen = Color(0xFF8FD8B5);

// text colors
const Color colorText = Color(0xFF283244);
const Color colorTextContrast = Color(0xFFFFFFFF);
const Color colorTextSecondary = Color(0xFF74767A);
const Color colorLink = Color(0xFF575FCC);

// icon colos
const Color colorIcon = Color(0xFF283244);
const Color colorIconContrast = Color(0xFFFFFFFF);
const Color colorIconSecondary = Color(0xFF919399);
const Color colorIconAccent = Color(0xFFFF6D3B);

// controls colors
const Color colorButton = Color(0xFF283244);
const Color colorButtonDisable = Color(0xFFA0A2A8);
const Color colorButtonSecondary = Color(0xFFECEDF0);
const Color colorInput = Color(0xFFF3F3F5);
const Color colorInputContent = Color(0xFF74767A);
const Color colorInputActive = Color(0xFF739EF1);
const Color colorInputError = Color(0xFFFF6D3B);

// divider & border colors
const Color colorBorder = Color(0xFFE0E1E6);
const Color colorDivider = Color(0xFFECEDF0);

// padding and radius
const double defaultPadding = 15.0;
const double borderRadius = 10.0;

// mask Fomatter
final TextInputFormatter phoneMask = MaskTextInputFormatter(
  mask: '+#  │  ### - ### - ## - ##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
