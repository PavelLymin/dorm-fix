import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/rest_client/rest_client.dart';
import '../../../instructions.dart';

abstract interface class IInstructionRepository {
  Future<InstructionEntity> getInstruction({required int instructionId});

  Future<List<InstructionEntity>> getAllInstructions();
}

class InstructionRepositoryImpl implements IInstructionRepository {
  const InstructionRepositoryImpl({
    required this._client,
    required this._firebaseAuth,
  });

  final RestClientHttp _client;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<InstructionEntity> getInstruction({required int instructionId}) async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/instructions/$instructionId',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response == null) {
      throw StructuredBackendException(
        error: {'description': 'Instruction not found.'},
        statusCode: 404,
      );
    }

    return InstructionDto.fromJson(response).toEntity();
  }

  @override
  Future<List<InstructionEntity>> getAllInstructions() async {
    final token = await _firebaseAuth.currentUser?.getIdToken();
    final response = await _client.send(
      path: '/instructions',
      method: 'GET',
      headers: {'Authorization': 'Bearer $token'},
    );

    final data = response?['instructions'];
    if (data case List<Object?> list when list.isNotEmpty) {
      final instructions = list
          .whereType<Map<String, Object?>>()
          .map<InstructionEntity>(
            (json) => InstructionDto.fromJson(json).toEntity(),
          )
          .toList();

      return instructions;
    }

    throw StructuredBackendException(
      error: {'description': 'Invalid data received from server.'},
      statusCode: 500,
    );
  }
}
