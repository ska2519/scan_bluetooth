// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tick.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Tick {
  Ticker get ticker => throw _privateConstructorUsedError;
  Duration get previouslyElapsed => throw _privateConstructorUsedError;
  Duration get currentlyElapsed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TickCopyWith<Tick> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TickCopyWith<$Res> {
  factory $TickCopyWith(Tick value, $Res Function(Tick) then) =
      _$TickCopyWithImpl<$Res>;
  $Res call(
      {Ticker ticker, Duration previouslyElapsed, Duration currentlyElapsed});
}

/// @nodoc
class _$TickCopyWithImpl<$Res> implements $TickCopyWith<$Res> {
  _$TickCopyWithImpl(this._value, this._then);

  final Tick _value;
  // ignore: unused_field
  final $Res Function(Tick) _then;

  @override
  $Res call({
    Object? ticker = freezed,
    Object? previouslyElapsed = freezed,
    Object? currentlyElapsed = freezed,
  }) {
    return _then(_value.copyWith(
      ticker: ticker == freezed
          ? _value.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as Ticker,
      previouslyElapsed: previouslyElapsed == freezed
          ? _value.previouslyElapsed
          : previouslyElapsed // ignore: cast_nullable_to_non_nullable
              as Duration,
      currentlyElapsed: currentlyElapsed == freezed
          ? _value.currentlyElapsed
          : currentlyElapsed // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
abstract class _$$_TickCopyWith<$Res> implements $TickCopyWith<$Res> {
  factory _$$_TickCopyWith(_$_Tick value, $Res Function(_$_Tick) then) =
      __$$_TickCopyWithImpl<$Res>;
  @override
  $Res call(
      {Ticker ticker, Duration previouslyElapsed, Duration currentlyElapsed});
}

/// @nodoc
class __$$_TickCopyWithImpl<$Res> extends _$TickCopyWithImpl<$Res>
    implements _$$_TickCopyWith<$Res> {
  __$$_TickCopyWithImpl(_$_Tick _value, $Res Function(_$_Tick) _then)
      : super(_value, (v) => _then(v as _$_Tick));

  @override
  _$_Tick get _value => super._value as _$_Tick;

  @override
  $Res call({
    Object? ticker = freezed,
    Object? previouslyElapsed = freezed,
    Object? currentlyElapsed = freezed,
  }) {
    return _then(_$_Tick(
      ticker: ticker == freezed
          ? _value.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as Ticker,
      previouslyElapsed: previouslyElapsed == freezed
          ? _value.previouslyElapsed
          : previouslyElapsed // ignore: cast_nullable_to_non_nullable
              as Duration,
      currentlyElapsed: currentlyElapsed == freezed
          ? _value.currentlyElapsed
          : currentlyElapsed // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$_Tick implements _Tick {
  const _$_Tick(
      {required this.ticker,
      this.previouslyElapsed = Duration.zero,
      this.currentlyElapsed = Duration.zero});

  @override
  final Ticker ticker;
  @override
  @JsonKey()
  final Duration previouslyElapsed;
  @override
  @JsonKey()
  final Duration currentlyElapsed;

  @override
  String toString() {
    return 'Tick(ticker: $ticker, previouslyElapsed: $previouslyElapsed, currentlyElapsed: $currentlyElapsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Tick &&
            const DeepCollectionEquality().equals(other.ticker, ticker) &&
            const DeepCollectionEquality()
                .equals(other.previouslyElapsed, previouslyElapsed) &&
            const DeepCollectionEquality()
                .equals(other.currentlyElapsed, currentlyElapsed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ticker),
      const DeepCollectionEquality().hash(previouslyElapsed),
      const DeepCollectionEquality().hash(currentlyElapsed));

  @JsonKey(ignore: true)
  @override
  _$$_TickCopyWith<_$_Tick> get copyWith =>
      __$$_TickCopyWithImpl<_$_Tick>(this, _$identity);
}

abstract class _Tick implements Tick {
  const factory _Tick(
      {required final Ticker ticker,
      final Duration previouslyElapsed,
      final Duration currentlyElapsed}) = _$_Tick;

  @override
  Ticker get ticker;
  @override
  Duration get previouslyElapsed;
  @override
  Duration get currentlyElapsed;
  @override
  @JsonKey(ignore: true)
  _$$_TickCopyWith<_$_Tick> get copyWith => throw _privateConstructorUsedError;
}
