import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:hooks_riverpod/hooks_riverpod.dart';

export '../../../../generated/flutter_gen/assets.gen.dart';
export '../common_widgets/async_value_widget.dart';
export '../localization/string_hardcoded.dart';
export '../routing/app_router.dart';
export 'app_colors.dart';
export 'app_sizes.dart';
export 'breakpoints.dart';

ThemeData theme(BuildContext context) => Theme.of(context);

ColorScheme colorScheme(BuildContext context) => Theme.of(context).colorScheme;
