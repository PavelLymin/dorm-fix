import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:rxdart/rxdart.dart';
import '../../../room.dart';

part 'search_room_event.dart';
part 'search_room_state.dart';

class SearcRoomBloc extends Bloc<SearchRoomEvent, SearchRoomState> {
  SearcRoomBloc({
    required this._dormitoryId,
    required this._roomRepository,
    required this._logger,
  }) : super(const .loading(rooms: [])) {
    onQueryChanged = BehaviorSubject<String>();
    _subscription = onQueryChanged.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) => add(.fetch(query: query)));
    on<SearchRoomEvent>(
      (event, emit) => event.map(fetch: (e) => _fetch(e, emit)),
    );
  }

  final int _dormitoryId;
  final IRoomRepository _roomRepository;
  final Logger _logger;

  late StreamSubscription _subscription;
  late BehaviorSubject<String> onQueryChanged;

  Future<void> _fetch(_FetchRoomsEvent e, Emitter<SearchRoomState> emit) async {
    try {
      emit(.loading(rooms: state.rooms));
      final rooms = (e.query == null || e.query!.trim().isEmpty)
          ? await _roomRepository.getRooms(dormitoryId: _dormitoryId)
          : await _roomRepository.getRooms(
              dormitoryId: _dormitoryId,
              query: e.query!.trim(),
            );
      emit(.loaded(rooms: rooms));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(rooms: state.rooms, error: e));
    }
  }

  void dispose() {
    _subscription.cancel();
    onQueryChanged.close();
  }
}
