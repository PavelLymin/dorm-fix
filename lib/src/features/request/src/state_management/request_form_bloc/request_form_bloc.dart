import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
      masterId: e.masterId ?? state._masterId,
      date: e.date ?? state._date,
      startTime: e.startTime ?? state._startTime,
      endTime: e.endTime ?? state._endTime,
      description: e.description,
      imageFileList: e.imageFileList ?? state._imageFileList,
    ),
  );
}
