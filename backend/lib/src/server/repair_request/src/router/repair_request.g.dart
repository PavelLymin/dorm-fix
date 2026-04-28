// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$RepairRequestsRouter(RepairRequests service) {
  final router = Router();
  router.add('POST', r'/requests', service._createRepairRequest);
  router.add('POST', r'/requests/<id>/accept', service._acceptRepairRequest);
  router.add('GET', r'/requests/stream', service._watchRepairRequests);
  return router;
}
