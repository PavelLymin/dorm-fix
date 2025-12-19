import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../room.dart';

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
        chooseDormitory: (e) => _chooseDormitory(e, emit),
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

  void _chooseDormitory(
    _SearchEventChooseDormitory event,
    Emitter<RoomSearchState> emit,
  ) {
    onTextChanged.add('');
    emit(
      RoomSearchState.dormitoryChosen(
        rooms: [],
        dormitoryId: event.dormitoryId,
      ),
    );
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
            rooms: results,
            dormitoryId: currentDormitoryId,
          ),
        );
      }
    } on RestClientException catch (e, stackTrace) {
      _logger.e(e.message, stackTrace: stackTrace);
      emit(RoomSearchState.error(rooms: state.rooms, message: e.message));
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
