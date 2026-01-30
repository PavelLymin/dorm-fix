import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../profile.dart';

part 'phone_number_event.dart';
part 'phone_number_state.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  PhoneNumberBloc({
    required IFirebaseUserRepository firebaseUserRepository,
    required IUserRepository userRepository,
    required Logger logger,
  }) : _logger = logger,
       _userRepository = userRepository,
       _firebaseUserRepository = firebaseUserRepository,
       super(PhoneNumberState.initial()) {
    on<PhoneNumberEvent>((event, emit) async {
      await event.map(
        verifyPhone: (event) => _verifyPhone(event, emit),
        submitSmsCode: (event) => _submitSmsCode(event, emit),
      );
    });
  }

  final IFirebaseUserRepository _firebaseUserRepository;
  final IUserRepository _userRepository;
  final Logger _logger;

  Future<void> _verifyPhone(
    _VerifyPhoneEvent event,
    Emitter<PhoneNumberState> emit,
  ) async {
    try {
      emit(.loading());
      final result = await _firebaseUserRepository.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
      );
      result.maybeMap(
        orElse: () => null,
        smsCodeSent: (verificationId) {
          emit(
            .smsCodeSent(
              verificationId: verificationId,
              phoneNumber: event.phoneNumber,
            ),
          );
        },
      );
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(message: e));
    }
  }

  Future<void> _submitSmsCode(
    _SubmitSmsCodeEvent event,
    Emitter<PhoneNumberState> emit,
  ) async {
    try {
      emit(.loading());
      await Future.wait([
        _firebaseUserRepository.updatePhoneNumber(
          smsCode: event.smsCode,
          verificationId: event.verificationId,
        ),
        _userRepository.updatePhoneNumber(phoneNumber: event.phoneNumber),
      ]);
      emit(.success());
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(message: e));
    }
  }
}
