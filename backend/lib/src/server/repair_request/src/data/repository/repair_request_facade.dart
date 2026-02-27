import 'package:drift/drift.dart';

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

  Future<List<RequestAggregate>> getRequests({required String uid});
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
       _specializationRepository = specializationRepository,
       _chatRepository = chatRepository,
       _assignmentsRepository = assignmentsRepository;

  final Database _database;
  final IRequestRepository _requestRepository;
  final IProblemRepository _problemRepository;
  final ISpecializationRepository _specializationRepository;
  final IChatRepository _chatRepository;
  final IAssignmentsRepository _assignmentsRepository;

  @override
  Future<RequestAggregate> createRequest({
    required String uid,
    required PartialRepairRequest request,
  }) async {
    late final FullRepairRequest requestData;
    late final List<FullProblem> problems;
    late final FullChat chat;
    late final SpecializationEntity specialization;
    late final MasterEntity? master;
    await _database.transaction(() async {
      requestData = await _requestRepository.createRequest(
        uid: uid,
        request: request,
      );
      problems = await _problemRepository.createProblems(
        problems: request.problems,
      );
      chat = await _chatRepository.createChat(
        chat: PartialChat(requestId: requestData.id),
      );
      await _chatRepository.addMember(chatId: chat.id, uid: uid);
      specialization = await _specializationRepository.getSpecialization(
        id: request.specializationId,
      );
      master = await _assignmentsRepository.getAssignment(
        requestId: requestData.id,
      );
    });

    final result = RequestAggregate(
      request: requestData,
      problems: problems,
      chat: chat,
      specialization: specialization,
      master: master,
    );

    return result;
  }

  @override
  Future<List<RequestAggregate>> getRequests({required String uid}) async {
    final requestsData = await _database
        .customSelect(
          '''SELECT 
            json_object(
              'id', r.id,
              'uid', r.uid,
              'description', r.description,
              'priority', r.priority,
              'status', r.status,
              'student_absent', r.student_absent,
              'date', r.date,
              'start_time', r.start_time,
              'end_time', r.end_time,
              'created_at', r.created_at
            ) AS request,
            json_object(
              'id', s.id,
              'title', s.title,
              'description', s.description,
              'photo_url', s.photo_url
            ) AS specialization,
            COALESCE(
              json_group_array(
                json_object(
                  'id', p.id,
                  'request_id', p.request_id,
                  'photo_path', p.photo_path
                )
              ) FILTER (WHERE p.id IS NOT NULL),
              '[]'
            ) AS problems,
            json_object(
              'id', c.id,
              'request_id', c.request_id,
              'created_at', c.created_at
            ) AS chat,
            (
              SELECT json_object(
                'id', m.id,
                'user', json_object(
                  'uid', u.uid,
                  'display_name', u.display_name,
                  'photo_url', u.photo_url,
                  'email', u.email,
                  'phone_number', u.phone_number,
                  'role', u.role
                ),
                'dormitory', json_object(
                  'id', d.id,
                  'number', d.number,
                  'name', d.name,
                  'address', d.address,
                  'long', d.long,
                  'lat', d.lat
                ),
                'specialization', json_object(
                  'id', spec.id,
                  'title', spec.title,
                  'description', spec.description,
                  'photo_url', spec.photo_url
                )
              )
              FROM assignments a
              INNER JOIN masters m ON m.uid = a.uid
              INNER JOIN users u ON u.uid = m.uid
              INNER JOIN dormitories d ON d.id = m.dormitory_id
              INNER JOIN specializations spec ON spec.id = m.specialization_id
              WHERE a.request_id = r.id
              ORDER BY a.created_at DESC
              LIMIT 1
            ) AS master
          FROM requests r
          INNER JOIN specializations s ON s.id = r.specialization_id
          LEFT JOIN problems p ON p.request_id = r.id
          LEFT JOIN chats c ON c.request_id = r.id
          WHERE r.uid = ?
          GROUP BY r.id, c.id
          ''',
          variables: [Variable<String>(uid)],
          readsFrom: {
            _database.requests,
            _database.specializations,
            _database.problems,
            _database.chats,
            _database.assignments,
            _database.masters,
            _database.users,
            _database.dormitories,
          },
        )
        .get();

    final result = requestsData
        .map((row) => RequestAggregateDto.fromJson(row.data).toEntity())
        .toList();

    return result;
  }
}
