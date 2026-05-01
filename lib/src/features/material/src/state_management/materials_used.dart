import 'package:ui_kit/ui.dart';

class MaterialsUsedController extends ChangeNotifier {
  MaterialsUsedController(this._materials);

  final Map<int, (String, int)> _materials;

  Map<int, (String, int)> get value => _materials;

  void addMaterial(int id, String name, int quantity) {
    _materials[id] = (name, quantity);
    notifyListeners();
  }

  void removeMaterial(int id) {
    _materials.remove(id);
    notifyListeners();
  }
}
