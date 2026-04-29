// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_requests.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$RepairRequestsRouter(RepairRequests service) {
  final router = Router();
  router.add(
    'PUT',
    r'/requests/<id>/update-status',
    service._updateRepairRequestStatus,
  );
  router.add('PUT', r'/requests/<id>/accept', service._acceptRepairRequest);
  router.add('POST', r'/requests', service._createRepairRequest);
  router.add('GET', r'/requests/stream', service._watchRepairRequests);
  return router;
}
