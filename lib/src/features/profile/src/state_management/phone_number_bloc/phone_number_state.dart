part of 'phone_number_bloc.dart';

typedef PhoneNumberStateMatch<R, S extends PhoneNumberState> =
    R Function(S state);

sealed class PhoneNumberState {
  const PhoneNumberState();

  factory PhoneNumberState.initial() => PhoneInitialState();
  factory PhoneNumberState.loading() => PhoneLoadingState();
  factory PhoneNumberState.smsCodeSent({
    required String verificationId,
    required String phoneNumber,
  }) => PhoneSmsCodeSentState(
    verificationId: verificationId,
    phoneNumber: phoneNumber,
  );
  factory PhoneNumberState.success() => PhoneSuccessState();
  factory PhoneNumberState.error({required Object message}) =>
      PhoneErrorState(message: message);

  R map<R>({
    required PhoneNumberStateMatch<R, PhoneInitialState> initial,
    required PhoneNumberStateMatch<R, PhoneLoadingState> loading,
    required PhoneNumberStateMatch<R, PhoneSmsCodeSentState> smsCodeSent,
    required PhoneNumberStateMatch<R, PhoneSuccessState> success,
    required PhoneNumberStateMatch<R, PhoneErrorState> error,
  }) => switch (this) {
    PhoneInitialState s => initial(s),
    PhoneLoadingState s => loading(s),
    PhoneSmsCodeSentState s => smsCodeSent(s),
    PhoneSuccessState s => success(s),
    PhoneErrorState s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    PhoneNumberStateMatch<R, PhoneInitialState>? initial,
    PhoneNumberStateMatch<R, PhoneLoadingState>? loading,
    PhoneNumberStateMatch<R, PhoneSmsCodeSentState>? smsCodeSent,
    PhoneNumberStateMatch<R, PhoneSuccessState>? success,
    PhoneNumberStateMatch<R, PhoneErrorState>? error,
  }) => map(
    initial: initial ?? (_) => orElse(),
    loading: loading ?? (_) => orElse(),
    smsCodeSent: smsCodeSent ?? (_) => orElse(),
    success: success ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    PhoneNumberStateMatch<R, PhoneInitialState>? initial,
    PhoneNumberStateMatch<R, PhoneLoadingState>? loading,
    PhoneNumberStateMatch<R, PhoneSmsCodeSentState>? smsCodeSent,
    PhoneNumberStateMatch<R, PhoneSuccessState>? success,
    PhoneNumberStateMatch<R, PhoneErrorState>? error,
  }) => map(
    initial: initial ?? (_) => null,
    loading: loading ?? (_) => null,
    smsCodeSent: smsCodeSent ?? (_) => null,
    success: success ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class PhoneInitialState extends PhoneNumberState {}

final class PhoneLoadingState extends PhoneNumberState {}

final class PhoneSmsCodeSentState extends PhoneNumberState {
  const PhoneSmsCodeSentState({
    required this.verificationId,
    required this.phoneNumber,
  });

  final String verificationId;
  final String phoneNumber;
}

final class PhoneSuccessState extends PhoneNumberState {}

final class PhoneErrorState extends PhoneNumberState {
  const PhoneErrorState({required this.message});

  final Object message;
}
