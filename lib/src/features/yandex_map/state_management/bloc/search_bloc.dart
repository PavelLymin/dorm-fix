import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/repositories/search_repository.dart';
import '../../model/dormitory.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required ISearchRepository searchRepository})
    : _searchRepository = searchRepository,
      super(const SearchState.noTerm(dormitories: [])) {
    onTextChanged = BehaviorSubject<String>();

    _subscription = onTextChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((text) {
          add(SearchEvent.textChanged(text: text));
        });

    on<_SearchEventTextChanged>(
      (event, emit) => event.map(textChanged: (e) => _search(e, emit)),
    );
  }

  final ISearchRepository _searchRepository;
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
      final results = await _searchRepository.searchDormitories(
        query: searchTerm,
      );

      if (results.isEmpty) {
        emit(SearchState.searchEmpty(dormitories: []));
      } else {
        emit(SearchState.searchPopulated(dormitories: results));
      }
    } catch (_) {
      emit(SearchState.error(dormitories: state.dormitories));
    }
  }
}
