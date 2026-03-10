import 'package:rxdart/rxdart.dart';
import '../../../../../core/database/database.dart';
import '../../../../chat/chat.dart';
import '../../../../profile/profile.dart';
import '../../../../specialization/specialization.dart';
import '../../../repair_request.dart';

abstract interface class IRepairRequestFacade {
  Future<void> createRequest({
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
    required Database database,
    required IRequestRepository requestRepository,
    required IProblemRepository problemRepository,
    required ISpecializationRepository specializationRepository,
    required IChatRepository chatRepository,
    required IAssignmentsRepository assignmentsRepository,
  }) : _database = database,
       _requestRepository = requestRepository,
       _problemRepository = problemRepository,
       _specRepository = specializationRepository,
       _chatRepository = chatRepository,
       _assignmentsRepository = assignmentsRepository;

  final Database _database;
  final IRequestRepository _requestRepository;
  final IProblemRepository _problemRepository;
  final ISpecializationRepository _specRepository;
  final IChatRepository _chatRepository;
  final IAssignmentsRepository _assignmentsRepository;

  @override
  Future<void> createRequest({
    required String uid,
    required PartialRepairRequest request,
  }) async {
    late final FullRepairRequest requestData;
    late final FullChat chat;
    await _database.transaction(() async {
      requestData = await _requestRepository.createRequest(
        uid: uid,
        request: request,
      );
      chat = await _chatRepository.createChat(
        chat: PartialChat(requestId: requestData.id),
      );
      await _chatRepository.addMember(chatId: chat.id, uid: uid);
    });
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
