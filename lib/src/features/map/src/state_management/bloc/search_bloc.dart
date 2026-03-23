import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../dormitory/dormitory.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this._dormitoryRepository, required this._logger})
    : super(const .loading(dormitories: [])) {
    onQueryChanged = BehaviorSubject<String>();
    _subscription = onQueryChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) => add(.queyChanged(query: query)));
    on<SearchEvent>(
      (event, emit) async =>
          await event.map(queyChanged: (e) => _queryChanged(e, emit)),
    );
  }

  final IDormitoryRepository _dormitoryRepository;
  final Logger _logger;

  late StreamSubscription _subscription;
  late BehaviorSubject<String> onQueryChanged;

  Future<void> _queryChanged(
    _QueryChangedEvent e,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(.loading(dormitories: state.dormitories));

      final query = e.query.trim();

      if (query.isEmpty) {
        final dormitories = await _dormitoryRepository.getDormitories();
        emit(.loaded(dormitories: dormitories));
        return;
      }

      final dormitories = await _dormitoryRepository.searchDormitories(
        query: query,
      );
      emit(.loaded(dormitories: dormitories));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(dormitories: state.dormitories, error: e));
    }
  }

  void dispose() {
    _subscription.cancel();
    onQueryChanged.close();
  }
}
