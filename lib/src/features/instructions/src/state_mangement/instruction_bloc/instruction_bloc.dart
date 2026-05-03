import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../../instructions.dart';

part 'instruction_event.dart';
part 'instruction_state.dart';

class InstructionBloc extends Bloc<InstructionEvent, InstructionState> {
  InstructionBloc({required this._instructionRepository, required this._logger})
    : super(const .loading(instructions: [])) {
    on<InstructionEvent>((event, emit) async {
      await event.map(getInstructions: (e) => _getInstructions(e, emit));
    });
  }

  final IInstructionRepository _instructionRepository;
  final Logger _logger;

  Future<void> _getInstructions(
    _GetInstructionsEvent e,
    Emitter<InstructionState> emit,
  ) async {
    try {
      final instructions = await _instructionRepository.getAllInstructions();
      emit(.loaded(instructions: instructions));
    } on Object catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      emit(.error(instructions: state.instructions, error: e));
    }
  }
}
