import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/database/database.dart';
import '../../../../chat/chat.dart';
import '../../../../master/master.dart';
import '../../../../profile/profile.dart';
import '../../../../specialization/specialization.dart';
import '../../../../student/student.dart';
import '../../../repair_request.dart';
import '../dto/status.dart';

abstract interface class IRepairRequestFacade {
  Future<FullRepairRequest> createRequest({
    required String uid,
    required PartialRepairRequest req,
  });

  Stream<List<FullRepairRequest>> watchRequests({
    String? uid,
    int? specId,
    int? dormId,
    String? status,
  });
}

class RepairRequestFacadeImpl implements IRepairRequestFacade {
  RepairRequestFacadeImpl({
    required Database database,
    required this._requestRepository,
    required this._problemRepository,
    required this._specRepository,
    required this._statusRepository,
    required this._assignmentsRepository,
    required this._chatRepository,
    required this._studentRepository,
  }) : _db = database;

  final Database _db;
  final IRequestRepository _requestRepository;
  final IProblemRepository _problemRepository;
  final ISpecializationRepository _specRepository;
  final IStatusRepository _statusRepository;
  final IChatRepository _chatRepository;
  final IAssignmentsRepository _assignmentsRepository;
  final IStudentRepository _studentRepository;

  @override
  Future<FullRepairRequest> createRequest({
    required String uid,
    required PartialRepairRequest req,
  }) async {
    late final Request request;
    late final List<FullProblemDto> problems;
    late final FullChatDto chat;
    late final SpecializationDto specialization;
    late final FullStudentDto student;
    late final StatusDto status;
    await _db.transaction(() async {
      request = await _requestRepository.createRequest(uid: uid, request: req);
      problems = await _problemRepository.createProblems(
        problems: req.problems
            .map((e) => PartialProblem(requestId: request.id, photoPath: e))
            .toList(),
      );
      chat = await _chatRepository.createChat(
        chat: PartialChat(requestId: request.id),
      );
      status = await _statusRepository.createStatus(
        requestId: request.id,
        status: req.currentStatus,
      );
      await _chatRepository.addMember(chatId: chat.id, uid: uid);
      specialization = await _specRepository.getSpecialization(id: req.specId);
      student = await _studentRepository.getStudent(uid: uid);
    });

    final result = FullRepairRequestDto.fromData(
      request: request,
      problems: problems,
      chat: chat,
      specialization: specialization,
      student: student,
      status: [status],
    ).toEntity();

    return result;
  }

  @override
  Stream<List<FullRepairRequest>> watchRequests({
    int page = 1,
    int limit = 10,
    String? uid,
    int? dormId,
    int? specId,
    String? status,
  }) {
    final query = _db.select(_db.requests).join([
      innerJoin(_db.users, _db.users.uid.equalsExp(_db.requests.uid)),
      innerJoin(_db.students, _db.students.uid.equalsExp(_db.users.uid)),
      innerJoin(_db.rooms, _db.rooms.id.equalsExp(_db.students.roomId)),
      innerJoin(
        _db.dormitories,
        _db.dormitories.id.equalsExp(_db.rooms.dormitoryId),
      ),
      innerJoin(
        _db.specializations,
        _db.specializations.id.equalsExp(_db.requests.specId),
      ),
      innerJoin(_db.chats, _db.chats.requestId.equalsExp(_db.requests.id)),
    ]);

    if (uid != null) query.where(_db.requests.uid.equals(uid));
    if (dormId != null) query.where(_db.students.dormitoryId.equals(dormId));
    if (specId != null) query.where(_db.requests.specId.equals(specId));
    if (status != null) query.where(_db.requests.currentStatus.equals(status));

    query.limit(limit, offset: (page - 1) * limit);

    return query.watch().switchMap((rows) {
      if (rows.isEmpty) return .value([]);
      final requestStreams = rows.map((row) {
        final request = row.readTable(_db.requests);

        final problemsStream = _problemRepository.watchProblems(
          requestId: request.id,
        );

        final masterStream = _assignmentsRepository.watchAssignment(
          requestId: request.id,
        );

        final statusStream = _statusRepository.watchStatuses(
          requestId: request.id,
        );

        return Rx.combineLatest3<
          List<Problem>,
          List<Statuse>,
          MasterDto?,
          FullRepairRequest
        >(problemsStream, statusStream, masterStream, (
          problem,
          status,
          master,
        ) {
          return FullRepairRequestDto.fromData(
            request: request,
            student: .fromData(
              row.readTable(_db.students),
              row.readTable(_db.users),
              row.readTable(_db.dormitories),
              row.readTable(_db.rooms),
            ),
            specialization: .fromData(row.readTable(_db.specializations)),
            problems: problem.map((p) => FullProblemDto.fromData(p)).toList(),
            status: status.map((s) => StatusDto.fromData(s)).toList(),
            chat: .fromData(chat: row.readTable(_db.chats)),
            master: master,
          ).toEntity();
        });
      });

      return Rx.combineLatestList(requestStreams.toList());
    });
  }

  // Stream<RequestAggregate> _watchRequestAggregate(int requestId) {
  //   final request = _requestRepository.watchRequest(id: requestId);
  //   final problems = _problemRepository.watchProblems(requestId: requestId);
  //   final master = _assignmentsRepository.watchAssignment(requestId: requestId);
  //   final specialization = _specRepository.watchSpec(requestId: requestId);
  //   final chat = _chatRepository.watchChat(requestId: requestId);
  //   return Rx.combineLatest5(
  //     request,
  //     problems,
  //     master,
  //     specialization,
  //     chat,
  //     (request, problems, master, specialization, chat) => RequestAggregate(
  //       request: request,
  //       problems: problems,
  //       master: master,
  //       specialization: specialization,
  //       chat: chat,
  //     ),
  //   );
  // }

  // @override
  // Stream<List<RequestAggregate>> watchRequests({
  //   String? uid,
  //   int? specId,
  //   int? dormId,
  //   String? status,
  // }) => _requestRepository
  //     .watchRequests(uid: uid, specId: specId, dormId: dormId, status: status)
  //     .switchMap((requests) {
  //       if (requests.isEmpty) return const .empty();

  //       final streams = requests
  //           .map((r) => _watchRequestAggregate(r.id))
  //           .toList();

  //       return Rx.combineLatestList(streams);
  //     });
}
