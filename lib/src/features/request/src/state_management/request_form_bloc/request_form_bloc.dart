import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_form_event.dart';
part 'request_form_state.dart';

class RequestFormBloc extends Bloc<RequestFormEvent, RequestFormState> {
  RequestFormBloc() : super(RequestFormState()) {
    on<RequestFormEvent>((event, emit) {
      switch (event) {
        case _SetRequestFormValue e:
          _setRequestFormValue(emit, e);
      }
    });
  }

  void _setRequestFormValue(
    Emitter<RequestFormState> emit,
    _SetRequestFormValue e,
  ) => emit(
    RequestFormState(
      masterId: e.masterId ?? state.masterId,
      date: e.date ?? state.date,
      startTime: e.startTime ?? state.startTime,
      endTime: e.endTime ?? state.endTime,
      description: e.description,
    ),
  );
}
