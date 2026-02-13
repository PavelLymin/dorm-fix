import 'dart:convert';

import '../../../../chat/chat.dart';
import '../../../../profile/profile.dart';
import '../../../../specialization/specialization.dart';
import '../../../repair_request.dart';

class RequestAggregateDto {
  const RequestAggregateDto({
    required this.request,
    required this.specialization,
    required this.problems,
    required this.chat,
    this.master,
  });

  final FullRepairRequestDto request;
  final SpecializationDto specialization;
  final List<FullProblemDto> problems;
  final FullChatDto chat;
  final MasterDto? master;

  RequestAggregate toEntity() => RequestAggregate(
    request: request.toEntity(),
    specialization: specialization.toEntity(),
    problems: problems.map((e) => e.toEntity()).toList(),
    chat: chat.toEntity(),
    master: master?.toEntity(),
  );

  Map<String, Object?> toJson() => {
    ...request.toJson(),
    'specialization': specialization.toJson(),
    'problems': problems.map((e) => e.toJson()).toList(),
    'chat': chat.toJson(),
    'master': master?.toJson(),
  };

  factory RequestAggregateDto.fromEntity(RequestAggregate entity) =>
      RequestAggregateDto(
        request: .fromEntity(entity.request),
        specialization: .fromEntity(entity.specialization),
        problems: entity.problems.map(FullProblemDto.fromEntity).toList(),
        chat: .fromEntity(entity.chat),
        master: entity.master != null ? .fromEntity(entity.master!) : null,
      );

  factory RequestAggregateDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'request': final String request,
      'specialization': final String specialization,
      'problems': final String problems,
      'chat': final String chat,
      'master': final String? master,
    }) {
      final requestRaw = jsonDecode(request);
      final specializationRaw = jsonDecode(specialization);
      final List<dynamic> problemsRaw = jsonDecode(problems);
      final chatRaw = jsonDecode(chat);
      final masterRaw = master != null ? jsonDecode(master) : null;

      return RequestAggregateDto(
        request: .fromJson(requestRaw),
        specialization: .fromJson(specializationRaw),
        problems: problemsRaw
            .whereType<Map<String, Object?>>()
            .map(FullProblemDto.fromJson)
            .toList(),
        chat: .fromJson(chatRaw),
        master: master != null ? .fromJson(masterRaw) : null,
      );
    }

    throw ArgumentError('Invalid JSON format for RequestAggregateDto: $json');
  }
}
