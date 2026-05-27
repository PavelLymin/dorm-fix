import 'package:ui_kit/ui.dart';

import '../../../material.dart';

class MaterialQuantityNotifier extends ValueNotifier<int> {
  MaterialQuantityNotifier(
    super._value, {
    required this._maxQuantity,
    this._usedMaterials = const {},
  });

  final int _maxQuantity;

  final Map<int, MaterialDraft> _usedMaterials;

  int get quantity => value;

  bool get canIncrement => value < _maxQuantity;
  bool get canDecrement => value > 0;

  void increment(MaterialEntity material) {
    if (value < _maxQuantity) {
      value++;

      notifyListeners();
    }
  }

  void decrement(MaterialEntity material) {
    if (value > 0) {
      value--;
      _usedMaterials.containsKey(material.id)
          ? _usedMaterials.update(material.id, (m) => m.updatedAmount(value))
          : _usedMaterials.putIfAbsent(
              material.id,
              () => MaterialDraft(material: material, selectedAmount: value),
            );
      notifyListeners();
    }
  }
}

class MaterialsUsedController extends ValueNotifier<Map<int, MaterialDraft>> {
  MaterialsUsedController() : super(const {});

  void upsertMaterial(MaterialEntity material, int amount) {
    value.containsKey(material.id)
        ? value.update(material.id, (m) => m.updatedAmount(amount))
        : value.putIfAbsent(
            material.id,
            () => MaterialDraft(material: material, selectedAmount: amount),
          );
    notifyListeners();
  }

  void removeMaterial(int materialId) {
    value.remove(materialId);
    notifyListeners();
  }
}
