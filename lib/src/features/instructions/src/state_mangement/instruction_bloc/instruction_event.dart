part of 'instruction_bloc.dart';

typedef InstructionEventMatch<R, E extends InstructionEvent> =
    R Function(E event);

sealed class InstructionEvent {
  const InstructionEvent();

  factory InstructionEvent.get() = _GetInstructionsEvent;

  R map<R>({
    required InstructionEventMatch<R, _GetInstructionsEvent> getInstructions,
  }) => switch (this) {
    _GetInstructionsEvent m => getInstructions(m),
  };
}

final class _GetInstructionsEvent extends InstructionEvent {
  const _GetInstructionsEvent();
}
