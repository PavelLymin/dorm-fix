import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/repository/dormitory_repository.dart';
import '../../model/dormitory.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required IDormitoryRepository dormitoryRepository,
    required Logger logger,
  }) : _dormitoryRepository = dormitoryRepository,
       _logger = logger,
       super(const SearchState.noTerm(dormitories: [])) {
    onTextChanged = BehaviorSubject<String>();

    _subscription = onTextChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((text) {
          add(_SearchEventTextChanged(text: text));
        });

    on<_SearchEventTextChanged>(
      (event, emit) => event.map(textChanged: (e) => _search(e, emit)),
    );
  }

  final IDormitoryRepository _dormitoryRepository;
  final Logger _logger;
  late StreamSubscription _subscription;
  late BehaviorSubject<String> onTextChanged;

  void dispose() {
    onTextChanged.close();
    _subscription.cancel();
  }

  Future<void> _search(
    _SearchEventTextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.text.trim();
    if (searchTerm.isEmpty) {
      emit(SearchState.noTerm(dormitories: []));
      return;
    }

    emit(SearchState.loading(dormitories: state.dormitories));

    try {
      final results = await _dormitoryRepository.searchDormitories(
        query: searchTerm,
      );

      if (results.isEmpty) {
        emit(SearchState.searchEmpty(dormitories: []));
      } else {
        emit(SearchState.searchPopulated(dormitories: results));
      }
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(
        SearchState.error(
          dormitories: state.dormitories,
          message: e.toString(),
        ),
      );
    }
  }
}
