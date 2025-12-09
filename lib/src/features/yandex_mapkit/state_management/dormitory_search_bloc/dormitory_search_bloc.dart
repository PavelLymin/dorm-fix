import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/repository/dormitory_repository.dart';
import '../../model/dormitory.dart';

part 'dormitory_search_state.dart';
part 'dormitory_search_event.dart';

class DormitorySearchBloc
    extends Bloc<DormitorySearchEvent, DormitorySearchState> {
  DormitorySearchBloc({
    required IDormitoryRepository dormitoryRepository,
    required Logger logger,
  }) : _dormitoryRepository = dormitoryRepository,
       _logger = logger,
       super(const DormitorySearchState.noTerm(dormitories: [])) {
    onTextChanged = BehaviorSubject<String>();

    _subscription = onTextChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((text) {
          add(DormitorySearchEvent.textChanged(text: text));
        });

    on<DormitorySearchEvent>(
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
    Emitter<DormitorySearchState> emit,
  ) async {
    final searchTerm = event.text.trim();
    if (searchTerm.isEmpty) {
      emit(DormitorySearchState.noTerm(dormitories: []));
      return;
    }

    emit(DormitorySearchState.loading(dormitories: state.dormitories));

    try {
      final results = await _dormitoryRepository.searchDormitories(
        query: searchTerm,
      );

      if (results.isEmpty) {
        emit(DormitorySearchState.searchEmpty(dormitories: []));
      } else {
        emit(DormitorySearchState.searchPopulated(dormitories: results));
      }
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(
        DormitorySearchState.error(
          dormitories: state.dormitories,
          message: e.toString(),
        ),
      );
    }
  }
}
