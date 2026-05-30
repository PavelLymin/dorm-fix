import 'package:ui_kit/ui.dart';

import '../../../material.dart';

class MaterialQuantityNotifier extends ValueNotifier<int> {
  MaterialQuantityNotifier(super._value, {required this._maxQuantity});

  final int _maxQuantity;

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
      notifyListeners();
    }
  }
}

class MaterialsUsedController extends ValueNotifier<Map<int, MaterialDraft>> {
  MaterialsUsedController() : super({});

  void updateMaterials(MaterialEntity material, int amount) {
    if (value.containsKey(material.id)) {
      if (amount == 0) {
        value.remove(material.id);
      } else {
        value.update(material.id, (m) => m.updatedAmount(amount));
      }
    } else {
      if (amount == 0) return;
      value[material.id] = MaterialDraft(
        material: material,
        selectedAmount: amount,
      );
    }
    notifyListeners();
  }
}
