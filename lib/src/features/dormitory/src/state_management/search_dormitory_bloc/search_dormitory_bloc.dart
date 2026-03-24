import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import '../../../dormitory.dart';

part 'search_dormitory_event.dart';
part 'search_dormitory_state.dart';

class SearchDormitoryBloc
    extends Bloc<SearchDormitoryEvent, SearchDormitoryState> {
  SearchDormitoryBloc({
    required this._dormitoryRepository,
    required this._logger,
  }) : super(const .loading(dormitories: [])) {
    onQueryChanged = BehaviorSubject<String>();
    _subscription = onQueryChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) => add(.fetch(query: query)));
    on<SearchDormitoryEvent>(
      (event, emit) async => await event.map(fetch: (e) => _fetch(e, emit)),
    );
  }

  final IDormitoryRepository _dormitoryRepository;
  final Logger _logger;

  late StreamSubscription _subscription;
  late BehaviorSubject<String> onQueryChanged;

  Future<void> _fetch(
    _FetchDormitoriesEvent e,
    Emitter<SearchDormitoryState> emit,
  ) async {
    try {
      emit(.loading(dormitories: state.dormitories));
      final dormitories = (e.query == null || e.query!.trim().isEmpty)
          ? await _dormitoryRepository.getDormitories()
          : await _dormitoryRepository.getDormitories(query: e.query!.trim());
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
