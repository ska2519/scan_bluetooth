import 'package:flutter/scheduler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'tick.g.dart';
part 'tick.freezed.dart';

@freezed
class Tick with _$Tick {
  const factory Tick({
    required Ticker ticker,
    @Default(Duration.zero) Duration previouslyElapsed,
    @Default(Duration.zero) Duration currentlyElapsed,
  }) = _Tick;

  // Duration get _elapsed => previouslyElapsed + currentlyElapsed;
  // factory Tick.fromJson(Map<String, dynamic> json) => _$TickFromJson(json);
}
