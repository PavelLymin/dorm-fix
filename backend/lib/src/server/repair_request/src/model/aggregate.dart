import '../../../chat/chat.dart';
import '../../../profile/profile.dart';
import '../../../specialization/specialization.dart';
import '../../repair_request.dart';

class RequestAggregate {
  const RequestAggregate({
    required this.request,
    required this.specialization,
    required this.problems,
    required this.chat,
    this.master,
  });

  final FullRepairRequest request;
  final SpecializationEntity specialization;
  final List<FullProblem> problems;
  final FullChat chat;
  final MasterEntity? master;
}
