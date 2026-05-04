// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materials.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$MaterialServiceRouter(MaterialService service) {
  final router = Router();
  router.add('GET', r'/materials', service.getMaterials);
  router.add('GET', r'/material-types', service.getMaterialTypes);
  router.add('POST', r'/materials/<id>/consume', service.consumeMaterial);
  return router;
}
