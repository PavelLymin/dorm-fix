part of 'phone_number_bloc.dart';

typedef PhoneNumberEventMatch<R, E extends PhoneNumberEvent> =
    FutureOr<R> Function(E event);

sealed class PhoneNumberEvent {
  const PhoneNumberEvent();

  factory PhoneNumberEvent.verifyPhone({required String phoneNumber}) =
      _VerifyPhoneEvent;

  factory PhoneNumberEvent.submitSmsCode({
    required String smsCode,
    required String verificationId,
    required String phoneNumber,
  }) = _SubmitSmsCodeEvent;

  FutureOr<R> map<R>({
    required PhoneNumberEventMatch<R, _VerifyPhoneEvent> verifyPhone,
    required PhoneNumberEventMatch<R, _SubmitSmsCodeEvent> submitSmsCode,
  }) => switch (this) {
    _VerifyPhoneEvent e => verifyPhone(e),
    _SubmitSmsCodeEvent e => submitSmsCode(e),
  };
}

final class _VerifyPhoneEvent extends PhoneNumberEvent {
  _VerifyPhoneEvent({required this.phoneNumber});

  final String phoneNumber;
}

final class _SubmitSmsCodeEvent extends PhoneNumberEvent {
  _SubmitSmsCodeEvent({
    required this.smsCode,
    required this.verificationId,
    required this.phoneNumber,
  });

  final String smsCode;
  final String verificationId;
  final String phoneNumber;
}
