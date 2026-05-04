import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../../../core/rest_api/rest_api.dart';
import '../../instruction.dart';

part 'instruction.g.dart';

class InstructionService {
  const InstructionService({required this.restApi, required this.repository});

  Router get handler => _$InstructionServiceRouter(this);

  final RestApi restApi;
  final IInstructionRepository repository;

  @Route.get('/instructions')
  Future<Response> getInstructions(Request request) async {
    final List<InstructionEntity> instructions;

    instructions = await repository.getAllInstructions();

    final json = instructions
        .map((e) => InstructionDto.fromEntity(e).toJson())
        .toList();

    return restApi.send(
      statusCode: 200,
      responseBody: {
        'data': {'instructions': json},
      },
    );
  }

  @Route.get('/instructions/<id>')
  Future<Response> getInstructionById(Request request, String id) async {
    final instructionId = int.tryParse(id);
    if (instructionId == null) {
      throw BadRequestException(
        error: {'description': 'Invalid instruction ID', 'field': 'id'},
      );
    }

    final instruction = await repository.getInstructionById(instructionId);
    if (instruction == null) {
      throw NotFoundException(
        error: {'description': 'Instruction not found', 'field': 'id'},
      );
    }

    final json = InstructionDto.fromEntity(instruction).toJson();

    return restApi.send(statusCode: 200, responseBody: {'data': json});
  }
}
