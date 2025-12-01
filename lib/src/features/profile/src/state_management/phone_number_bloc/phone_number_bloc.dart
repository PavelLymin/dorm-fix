import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../../../core/firebase/firebase.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../data/repository/firebase_user_repository.dart';
import '../../data/repository/user_repository.dart';

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

  Future<void> runSafe(
    Emitter<PhoneNumberState> emit,
    Future<void> Function() body,
  ) async {
    try {
      await body();
    } on AuthException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(PhoneNumberState.error(message: e.message));
    } on StructuredBackendException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(PhoneNumberState.error(message: e.message));
    } on RestClientException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(PhoneNumberState.error(message: e.message));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(PhoneNumberState.error(message: e.toString()));
    }
  }

  Future<void> _verifyPhone(
    _VerifyPhoneEvent event,
    Emitter<PhoneNumberState> emit,
  ) async {
    emit(PhoneNumberState.loading());
    await runSafe(emit, () async {
      final result = await _firebaseUserRepository.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
      );
      result.maybeMap(
        orElse: () => null,
        smsCodeSent: (verificationId) {
          emit(
            PhoneNumberState.smsCodeSent(
              verificationId: verificationId,
              phoneNumber: event.phoneNumber,
            ),
          );
        },
      );
    });
  }

  Future<void> _submitSmsCode(
    _SubmitSmsCodeEvent event,
    Emitter<PhoneNumberState> emit,
  ) async {
    emit(PhoneNumberState.loading());
    runSafe(emit, () async {
      await Future.wait([
        _firebaseUserRepository.updatePhoneNumber(
          smsCode: event.smsCode,
          verificationId: event.verificationId,
        ),
        _userRepository.updatePhoneNumber(phoneNumber: event.phoneNumber),
      ]);
      emit(PhoneNumberState.success());
    });
  }
}
