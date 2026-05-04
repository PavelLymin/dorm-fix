// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$InstructionServiceRouter(InstructionService service) {
  final router = Router();
  router.add('GET', r'/instructions', service.getInstructions);
  router.add('GET', r'/instructions/<id>', service.getInstructionById);
  return router;
}
