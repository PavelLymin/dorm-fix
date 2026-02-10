part of 'profile_bloc.dart';

typedef ProfileStateMatch<R, S extends ProfileState> = R Function(S state);

sealed class ProfileState {
  const ProfileState();

  const factory ProfileState.loadedStudent({required FullStudent student}) =
      _ProfileLoadedStudentState;

  const factory ProfileState.loadedMaster({required MasterEntity master}) =
      _ProfileLoadedMasterState;

  const factory ProfileState.loading({required ProfileEntity profile}) =
      _ProfileLoadingState;

  const factory ProfileState.error({
    required ProfileEntity profile,
    required String message,
  }) = _ProfileErrorState;

  bool get isLoading => maybeMap(orElse: () => false, loading: (_) => true);

  ProfileEntity get currentProfile => map(
    loadedStudent: (state) => state.student,
    loadedMaster: (state) => state.master,
    loading: (state) => state.profile,
    error: (state) => state.profile,
  );

  R map<R>({
    required ProfileStateMatch<R, _ProfileLoadedStudentState> loadedStudent,
    required ProfileStateMatch<R, _ProfileLoadedMasterState> loadedMaster,
    required ProfileStateMatch<R, _ProfileLoadingState> loading,
    required ProfileStateMatch<R, _ProfileErrorState> error,
  }) => switch (this) {
    _ProfileLoadedStudentState s => loadedStudent(s),
    _ProfileLoadedMasterState s => loadedMaster(s),
    _ProfileLoadingState s => loading(s),
    _ProfileErrorState s => error(s),
  };

  R maybeMap<R>({
    required R Function() orElse,
    ProfileStateMatch<R, _ProfileLoadedStudentState>? loadedStudent,
    ProfileStateMatch<R, _ProfileLoadedMasterState>? loadedMaster,
    ProfileStateMatch<R, _ProfileLoadingState>? loading,
    ProfileStateMatch<R, _ProfileErrorState>? error,
  }) => map<R>(
    loadedStudent: loadedStudent ?? (_) => orElse(),
    loadedMaster: loadedMaster ?? (_) => orElse(),
    loading: loading ?? (_) => orElse(),
    error: error ?? (_) => orElse(),
  );

  R? mapOrNull<R>({
    ProfileStateMatch<R, _ProfileLoadedStudentState>? loadedStudent,
    ProfileStateMatch<R, _ProfileLoadedMasterState>? loadedMaster,
    ProfileStateMatch<R, _ProfileLoadingState>? loading,
    ProfileStateMatch<R, _ProfileErrorState>? error,
  }) => map<R?>(
    loadedStudent: loadedStudent ?? (_) => null,
    loadedMaster: loadedMaster ?? (_) => null,
    loading: loading ?? (_) => null,
    error: error ?? (_) => null,
  );
}

final class _ProfileLoadedStudentState extends ProfileState {
  const _ProfileLoadedStudentState({required this.student});

  final FullStudent student;
}

final class _ProfileLoadedMasterState extends ProfileState {
  const _ProfileLoadedMasterState({required this.master});

  final MasterEntity master;
}

final class _ProfileLoadingState extends ProfileState {
  const _ProfileLoadingState({required this.profile});

  final ProfileEntity profile;
}

final class _ProfileErrorState extends ProfileState {
  const _ProfileErrorState({required this.profile, required this.message});

  final ProfileEntity profile;
  final String message;
}
