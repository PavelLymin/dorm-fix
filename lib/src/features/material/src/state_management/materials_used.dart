import 'package:ui_kit/ui.dart';

class MaterialsUsedController extends ChangeNotifier {
  MaterialsUsedController(this._materials);

  final Map<int, ({String name, int quantity})> _materials;

  Map<int, ({String name, int quantity})> get value => _materials;

  void addMaterial(int id, String name, int quantity) {
    _materials[id] = (name: name, quantity: quantity);
    notifyListeners();
  }

  void removeMaterial(int id) {
    _materials.remove(id);
    notifyListeners();
  }
}
