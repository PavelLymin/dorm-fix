import 'package:ui_kit/ui.dart';

class AppWidgetStateMap<T> implements WidgetStateProperty<T> {
  const AppWidgetStateMap(this._constraints);

  final WidgetStateMap<T> _constraints;

  @override
  T resolve(Set<WidgetState> states) {
    for (final MapEntry(key: constraint, value: value)
        in _constraints.entries) {
      if (constraint.isSatisfiedBy(states)) {
        return value;
      }
    }

    try {
      return null as T;
    } on TypeError {
      throw ArgumentError(
        'The current set of widget states is $states.\n'
        'None of the provided map keys matched this set, '
        'and the type "$T" is non-nullable.\n'
        'Consider using "WidgetStateMapper<$T?>()", '
        'or adding the "WidgetState.any" key to this map.',
      );
    }
  }

  T? maybeResolve(Set<WidgetState> states) {
    for (final MapEntry(key: constraint, value: value)
        in _constraints.entries) {
      if (constraint.isSatisfiedBy(states)) {
        return value;
      }
    }

    return null;
  }

  AppWidgetStateMap<R> map<R>(R Function(T) map) => AppWidgetStateMap<R>({
    for (final MapEntry(key: constraint, value: value) in _constraints.entries)
      constraint: map(value),
  });

  AppWidgetStateMap<T> replaceFirstWhere(
    Set<WidgetState> states,
    T Function(T) replace,
  ) {
    final constraints = {..._constraints};
    for (final key in constraints.keys) {
      if (key.isSatisfiedBy(states)) {
        constraints[key] = replace(constraints[key] as T);
        break;
      }
    }

    return AppWidgetStateMap<T>(constraints);
  }

  AppWidgetStateMap<T> replaceLastWhere(
    Set<WidgetState> states,
    T Function(T) replace,
  ) {
    final constraints = {..._constraints};
    for (final key in constraints.keys.toList().reversed) {
      if (key.isSatisfiedBy(states)) {
        constraints[key] = replace(constraints[key] as T);
        break;
      }
    }

    return AppWidgetStateMap<T>(constraints);
  }

  AppWidgetStateMap<T> replaceAllWhere(
    Set<WidgetState> states,
    T Function(T) replace,
  ) => AppWidgetStateMap<T>({
    for (final MapEntry(key: constraint, value: value) in _constraints.entries)
      constraint: constraint.isSatisfiedBy(states) ? replace(value) : value,
  });

  static AppWidgetStateMap<T> lerpWhere<T>(
    AppWidgetStateMap<T> a,
    AppWidgetStateMap<T> b,
    double t,
    T? Function(T?, T?, double) lerp,
  ) {
    final visited = <WidgetStatesConstraint>{};
    final constraints = <WidgetStatesConstraint, T>{};

    for (final MapEntry(key: constraint, value: value)
        in a._constraints.entries) {
      visited.add(constraint);
      if (lerp(value, b._constraints[constraint], t) case final lerped?) {
        constraints[constraint] = lerped;
      }
    }

    for (final MapEntry(key: constraint, value: value)
        in b._constraints.entries) {
      if (visited.contains(constraint)) continue;
      if (lerp(a._constraints[constraint], value, t) case final lerped?) {
        constraints[constraint] = lerped;
      }
    }

    return AppWidgetStateMap<T>(constraints);
  }

  static AppWidgetStateMap<BoxDecoration> boxDecoration(
    AppWidgetStateMap<BoxDecoration> a,
    AppWidgetStateMap<BoxDecoration> b,
    double t,
  ) => lerpWhere(a, b, t, BoxDecoration.lerp);

  static AppWidgetStateMap<Color> lerpColor(
    AppWidgetStateMap<Color> a,
    AppWidgetStateMap<Color> b,
    double t,
  ) => lerpWhere(a, b, t, Color.lerp);

  static AppWidgetStateMap<IconThemeData> lerpIconThemeData(
    AppWidgetStateMap<IconThemeData> a,
    AppWidgetStateMap<IconThemeData> b,
    double t,
  ) => lerpWhere(a, b, t, IconThemeData.lerp);

  static AppWidgetStateMap<TextStyle> lerpTextStyle(
    AppWidgetStateMap<TextStyle> a,
    AppWidgetStateMap<TextStyle> b,
    double t,
  ) => lerpWhere(a, b, t, TextStyle.lerp);
}

class WidgetStateController extends ValueNotifier<Set<WidgetState>> {
  WidgetStateController([Set<WidgetState>? value])
    : super(<WidgetState>{...?value});

  void update(WidgetState state, bool add) {
    if (add) {
      value.add(state);
      notifyListeners();
    } else {
      value.remove(state);
    }
  }
}
