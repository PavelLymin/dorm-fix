import 'package:rxdart/rxdart.dart';
import '../../../../../core/database/database.dart';
import '../../../../chat/chat.dart';
import '../../../../profile/profile.dart';
import '../../../../specialization/specialization.dart';
import '../../../repair_request.dart';

abstract interface class IRepairRequestFacade {
  Future<RequestAggregate> createRequest({
    required String uid,
    required PartialRepairRequest request,
  });

  Stream<List<RequestAggregate>> watchRequests({
    String? uid,
    int? specId,
    int? dormId,
    String? status,
  });
}

class RepairRequestFacadeImpl implements IRepairRequestFacade {
  RepairRequestFacadeImpl({
    required this._database,
    required this._requestRepository,
    required this._problemRepository,
    required this._specRepository,
    required this._assignmentsRepository,
    required this._chatRepository,
  });

  final Database _database;
  final IRequestRepository _requestRepository;
  final IProblemRepository _problemRepository;
  final ISpecializationRepository _specRepository;
  final IChatRepository _chatRepository;
  final IAssignmentsRepository _assignmentsRepository;

  @override
  Future<RequestAggregate> createRequest({
    required String uid,
    required PartialRepairRequest request,
  }) async {
    late final FullRepairRequest requestData;
    late final List<FullProblem> problems;
    late final SpecializationEntity specialization;
    late final FullChat chat;
    await _database.transaction(() async {
      requestData = await _requestRepository.createRequest(
        uid: uid,
        request: request,
      );
      problems = await _problemRepository.createProblems(
        problems: request.problems
            .map((e) => PartialProblem(requestId: requestData.id, photoPath: e))
            .toList(),
      );
      chat = await _chatRepository.createChat(
        chat: PartialChat(requestId: requestData.id),
      );
      specialization = await _specRepository.getSpecialization(
        id: request.specId,
      );
      await _chatRepository.addMember(chatId: chat.id, uid: uid);
    });

    return RequestAggregate(
      request: requestData,
      specialization: specialization,
      problems: problems,
      chat: chat,
    );
  }

  Stream<RequestAggregate> _watchRequestAggregate(int requestId) {
    final request = _requestRepository.watchRequest(id: requestId);
    final problems = _problemRepository.watchProblems(requestId: requestId);
    final master = _assignmentsRepository.watchAssignment(requestId: requestId);
    final specialization = _specRepository.watchSpec(requestId: requestId);
    final chat = _chatRepository.watchChat(requestId: requestId);
    return Rx.combineLatest5(
      request,
      problems,
      master,
      specialization,
      chat,
      (request, problems, master, specialization, chat) => RequestAggregate(
        request: request,
        problems: problems,
        master: master,
        specialization: specialization,
        chat: chat,
      ),
    );
  }

  @override
  Stream<List<RequestAggregate>> watchRequests({
    String? uid,
    int? specId,
    int? dormId,
    String? status,
  }) => _requestRepository
      .watchRequests(uid: uid, specId: specId, dormId: dormId, status: status)
      .switchMap((requests) {
        if (requests.isEmpty) return const .empty();

        final streams = requests
            .map((r) => _watchRequestAggregate(r.id))
            .toList();

        return Rx.combineLatestList(streams);
      });
}
