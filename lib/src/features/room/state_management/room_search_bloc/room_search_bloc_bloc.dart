import 'dart:async';

import 'package:dorm_fix/src/features/room/model/room.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dorm_fix/src/features/room/data/repository/room_repository.dart';
import 'package:logger/web.dart';
import 'package:rxdart/rxdart.dart';

part 'room_search_event.dart';
part 'room_search_state.dart';

class RoomSearcBloc extends Bloc<RoomSearchEvent, RoomSearchState> {
  RoomSearcBloc({
    required IRoomRepository roomRepository,
    required Logger logger,
  }) : _roomRepository = roomRepository,
       _logger = logger,
       super(const RoomSearchState.noTerm(rooms: [])) {
    onTextChanged = BehaviorSubject<String>();

    _subscription = onTextChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((text) {
          add(RoomSearchEvent.textChanged(text: text));
        });

    on<RoomSearchEvent>(
      (event, emit) => event.map(
        textChanged: (e) => _search(e, emit),
        chooseDormitory: (e) => emit(
          RoomSearchState.dormitoryChosen(
            rooms: [],
            dormitoryId: e.dormitoryId,
          ),
        ),
      ),
    );
  }

  final IRoomRepository _roomRepository;
  final Logger _logger;
  late StreamSubscription _subscription;
  late BehaviorSubject<String> onTextChanged;

  void dispose() {
    onTextChanged.close();
    _subscription.cancel();
  }

  Future<void> _search(
    _SearchEventTextChanged event,
    Emitter<RoomSearchState> emit,
  ) async {
    final searchTerm = event.text.trim();

    final currentDormitoryId = state.dormitoryId;

    if (searchTerm.isEmpty) {
      emit(RoomSearchState.noTerm(rooms: [], dormitoryId: currentDormitoryId));
      return;
    }

    emit(RoomSearchState.loading(rooms: [], dormitoryId: currentDormitoryId));

    try {
      final results = await _roomRepository.searchRoomsByDormitoryId(
        dormitoryId: currentDormitoryId!,
        query: searchTerm,
      );

      if (results.isEmpty) {
        emit(
          RoomSearchState.searchEmpty(
            rooms: [],
            dormitoryId: currentDormitoryId,
          ),
        );
      } else {
        emit(
          RoomSearchState.searchPopulated(
            rooms: [],
            dormitoryId: currentDormitoryId,
          ),
        );
      }
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(
        RoomSearchState.error(
          rooms: [],
          message: e.toString(),
          dormitoryId: currentDormitoryId,
        ),
      );
    }
  }
}
