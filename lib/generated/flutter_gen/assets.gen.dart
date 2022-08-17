/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/bomb_1024.png
  AssetGenImage get bomb1024 =>
      const AssetGenImage('assets/logo/bomb_1024.png');

  /// File path: assets/logo/bomb_1024_white.png
  AssetGenImage get bomb1024White =>
      const AssetGenImage('assets/logo/bomb_1024_white.png');

  /// File path: assets/logo/bomb_dev_1024.png
  AssetGenImage get bombDev1024 =>
      const AssetGenImage('assets/logo/bomb_dev_1024.png');

  /// File path: assets/logo/bomb_ios_1024.jpg
  AssetGenImage get bombIos1024 =>
      const AssetGenImage('assets/logo/bomb_ios_1024.jpg');
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/google.svg
  SvgGenImage get google => const SvgGenImage('assets/svg/google.svg');

  /// File path: assets/svg/ic_signal_fair_ska_144.svg
  SvgGenImage get icSignalFairSka144 =>
      const SvgGenImage('assets/svg/ic_signal_fair_ska_144.svg');

  /// File path: assets/svg/ic_signal_good_ska_144.svg
  SvgGenImage get icSignalGoodSka144 =>
      const SvgGenImage('assets/svg/ic_signal_good_ska_144.svg');

  /// File path: assets/svg/ic_signal_ska_144.svg
  SvgGenImage get icSignalSka144 =>
      const SvgGenImage('assets/svg/ic_signal_ska_144.svg');

  /// File path: assets/svg/ic_signal_strong_ska_144.svg
  SvgGenImage get icSignalStrongSka144 =>
      const SvgGenImage('assets/svg/ic_signal_strong_ska_144.svg');

  /// File path: assets/svg/ic_signal_weak_ska_144.svg
  SvgGenImage get icSignalWeakSka144 =>
      const SvgGenImage('assets/svg/ic_signal_weak_ska_144.svg');

  /// File path: assets/svg/icon-dart.svg
  SvgGenImage get iconDart => const SvgGenImage('assets/svg/icon-dart.svg');

  /// File path: assets/svg/icon-day-mode.svg
  SvgGenImage get iconDayMode =>
      const SvgGenImage('assets/svg/icon-day-mode.svg');

  /// File path: assets/svg/icon-figma.svg
  SvgGenImage get iconFigma => const SvgGenImage('assets/svg/icon-figma.svg');

  /// File path: assets/svg/icon-firebase.svg
  SvgGenImage get iconFirebase =>
      const SvgGenImage('assets/svg/icon-firebase.svg');

  /// File path: assets/svg/icon-flutter-white.svg
  SvgGenImage get iconFlutterWhite =>
      const SvgGenImage('assets/svg/icon-flutter-white.svg');

  /// File path: assets/svg/icon-flutter.svg
  SvgGenImage get iconFlutter =>
      const SvgGenImage('assets/svg/icon-flutter.svg');

  /// File path: assets/svg/icon-night-mode.svg
  SvgGenImage get iconNightMode =>
      const SvgGenImage('assets/svg/icon-night-mode.svg');

  /// File path: assets/svg/icon-star.svg
  SvgGenImage get iconStar => const SvgGenImage('assets/svg/icon-star.svg');
}

class Assets {
  Assets._();

  static const $AssetsLogoGen logo = $AssetsLogoGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
