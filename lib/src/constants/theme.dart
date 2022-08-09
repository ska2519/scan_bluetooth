import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'resources.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

const FlexSchemeData myFlexScheme = FlexSchemeData(
  name: 'flutterDash',
  description: 'Midnight blue theme, custom definition of all colors',
  light: FlexSchemeColor(
    primary: Color(0xff0061a2),
    primaryContainer: Color(0xffcfe4ff),
    secondary: Color(0xff5b5d71),
    secondaryContainer: Color(0xffe0e1fa),
    tertiary: Color(0xff6a5779),
    tertiaryContainer: Color(0xfff2daff),
    error: Color(0xffba1b1b),
  ),
  dark: FlexSchemeColor(
    primary: Color(0xff9acaff),
    primaryContainer: Color(0xff00497c),
    secondary: Color(0xffc4c5dd),
    secondaryContainer: Color(0xff434559),
    tertiary: Color(0xffd5bee5),
    tertiaryContainer: Color(0xff524060),
  ),
);

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.mango,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.mango,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 15,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

final ThemeData flexThemeLightData = FlexThemeData.light(
  colors: myFlexScheme.light,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 3,
  appBarStyle: FlexAppBarStyle.surface,
  appBarOpacity: 0.95,
  appBarElevation: 2,
  subThemesData: const FlexSubThemesData(
    elevatedButtonRadius: 40.0,
  ),
  useMaterial3ErrorColors: true,
  keyColors: const FlexKeyColors(
    useSecondary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black87),
    displayMedium: TextStyle(color: Colors.black87),
    displaySmall: TextStyle(
      color: AppColors.flutterAccentColor,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: TextStyle(
      color: AppColors.flutterAccentColor,
      fontWeight: FontWeight.w500,
    ),
  ),
);

final ThemeData flexThemeDarkData = FlexThemeData.dark(
  colors: myFlexScheme.dark,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 3,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  appBarElevation: 2,
  subThemesData: const FlexSubThemesData(
    elevatedButtonRadius: 40.0,
    blendTextTheme: false,
  ),
  useMaterial3ErrorColors: true,
  keyColors: const FlexKeyColors(
    useSecondary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(
      color: AppColors.flutterPrimaryColor,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(color: Colors.white),
  ),
);
