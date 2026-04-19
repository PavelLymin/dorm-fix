import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'button_event.dart';
part 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(const .disabled()) {
    on<ButtonEvent>((event, emit) {
      event.map(
        addDisabled: (_) => _addDisabled(emit),
        addEnabled: (_) => _addEnabled(emit),
        addLoading: (_) => _addLoading(emit),
      );
    });
  }

  void _addDisabled(Emitter<ButtonState> emit) => emit(const .disabled());

  void _addEnabled(Emitter<ButtonState> emit) => emit(const .enabled());

  void _addLoading(Emitter<ButtonState> emit) => emit(const .loading());
}
