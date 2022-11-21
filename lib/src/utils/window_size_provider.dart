import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final windowSizeRepositoryProvider =
    Provider<WindowSizeRepository>((ref) => WindowSizeRepository());

final setWindowSizeProvider = FutureProvider.autoDispose((ref) async =>
    await ref.read(windowSizeRepositoryProvider).setWindowSize());

class WindowSizeRepository {
  Future<void> setWindowSize() async {
    await DesktopWindow.setWindowSize(const Size(1280, 800));
    await DesktopWindow.setMinWindowSize(const Size(400, 400));
    // await DesktopWindow.setMaxWindowSize(const Size(800, 800));
    await DesktopWindow.resetMaxWindowSize();
    await DesktopWindow.setFullScreen(false);
  }

  // final size = await DesktopWindow.getWindowSize();
  //  return size;
}
