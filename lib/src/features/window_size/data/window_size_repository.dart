import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WindowSizeRepository {
  Future<Size> getSize() async {
    late Size size;
    size = await DesktopWindow.getWindowSize();
    print(size.toString());

    await DesktopWindow.setWindowSize(const Size(500, 800));
    await DesktopWindow.setMinWindowSize(const Size(400, 400));
    await DesktopWindow.setMaxWindowSize(const Size(800, 800));
    await DesktopWindow.resetMaxWindowSize();
    await DesktopWindow.setFullScreen(false);

    return size;
  }
}

final windowSizeRepositoryProvider = Provider<WindowSizeRepository>(
  (ref) => WindowSizeRepository(),
);

final windowSizeProvider = FutureProvider.autoDispose<Size>(
  (ref) async => await ref.read(windowSizeRepositoryProvider).getSize(),
);
