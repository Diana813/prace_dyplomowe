import 'package:flutter/material.dart';

class MyColors {
  MyColors._();

  static const _appOrange = 0xFFFF7055;
  static const _appBlue = 0xFF0066FF;
  static const _appGreen = 0xFF00D39F;

  static const MaterialColor orange = const MaterialColor(
    _appOrange,
    const <int, Color>{
      100: const Color(0x33FF7055),
      200: const Color(0x4DFF7055),
      300: const Color(0x66FF7055),
      400: const Color(0x80FF7055),
      500: const Color(0x99FF7055),
      600: const Color(0xB3FF7055),
      700: const Color(0xCCFF7055),
      800: const Color(0xE6FF7055),
      900: const Color(_appOrange),
    },
  );

  static const MaterialColor blue = const MaterialColor(
    _appBlue,
    const <int, Color>{
      100: const Color(0x330066FF),
      200: const Color(0x4D0066FF),
      300: const Color(0x660066FF),
      400: const Color(0x800066FF),
      500: const Color(0x990066FF),
      600: const Color(0xB30066FF),
      700: const Color(0xCC0066FF),
      800: const Color(0xE60066FF),
      900: const Color(_appBlue),
    },
  );

  static const MaterialColor green = const MaterialColor(
    _appGreen,
    const <int, Color>{
      100: const Color(0x3300D39F),
      200: const Color(0x4D00D39F),
      300: const Color(0x6600D39F),
      400: const Color(0x8000D39F),
      500: const Color(0x9900D39F),
      600: const Color(0xB300D39F),
      700: const Color(0xCC00D39F),
      800: const Color(0xE600D39F),
      900: const Color(_appGreen),
    },
  );
}
