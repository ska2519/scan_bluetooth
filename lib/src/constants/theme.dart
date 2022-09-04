import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../layout/letter_spacing.dart';
import '../supplemental/cut_corners_border.dart';
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

final base = ThemeData.light();

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.aquaBlue,
  // colors: myFlexScheme.light,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 10,
  appBarStyle: FlexAppBarStyle.material,
  appBarOpacity: 0.44,
  // appBarElevation: 1,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
    blendOnColors: false,
    defaultRadius: 11,
    // elevatedButtonRadius: 40.0,
  ),

  keyColors: const FlexKeyColors(
      // keepPrimary: true,
      // useSecondary: true,

      ),
  // useMaterial3: true,
  // useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: _buildShrineTextTheme(base.textTheme),
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.aquaBlue,
  // colors: myFlexScheme.dark,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 3,
  // appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  appBarElevation: 1,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
    elevatedButtonRadius: 40.0,
    blendTextTheme: false,
  ),
  useMaterial3ErrorColors: true,
  keyColors: const FlexKeyColors(
      // keepPrimary: true,
      // useSecondary: true,
      ),
  // useMaterial3: true,
  // useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: _buildShrineTextTheme(base.textTheme),
);

// -------------------------------------------------------------
final ThemeData flexThemeLightData = FlexThemeData.light(
  colors: myFlexScheme.light,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 3,
  appBarStyle: FlexAppBarStyle.material,
  appBarOpacity: 0.44,
  // appBarElevation: 2,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
    elevatedButtonRadius: 40.0,
    // dialogBackgroundSchemeColor: SchemeColor.onPrimary,
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
  // appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  appBarElevation: 2,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
    elevatedButtonRadius: 40.0,
    blendTextTheme: false,
    // dialogBackgroundSchemeColor: SchemeColor.onPrimary,
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

const defaultLetterSpacing = 0.03;
const mediumLetterSpacing = 0.04;
const largeLetterSpacing = 1.0;

final ThemeData shrineTheme = _buildShrineTheme();

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

ThemeData _buildShrineTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
    ),
    colorScheme: _shrineColorScheme,
    primaryColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    errorColor: shrineErrorRed,
    primaryIconTheme: _customIconTheme(base.iconTheme),
    inputDecorationTheme: const InputDecorationTheme(
      border: CutCornersBorder(
        borderSide: BorderSide(color: shrineBrown900, width: 0.5),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: shrinePink100,
    ),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return GoogleFonts.rubikTextTheme(base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        bodyText2: base.bodyText2!.copyWith(
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        subtitle1: base.subtitle1!.copyWith(
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        headline4: base.headline4!.copyWith(
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
        button: base.button!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: letterSpacingOrNone(defaultLetterSpacing),
        ),
      )
      .apply(
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      ));
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryContainer: shrineBrown900,
  secondary: shrinePink50,
  secondaryContainer: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);
