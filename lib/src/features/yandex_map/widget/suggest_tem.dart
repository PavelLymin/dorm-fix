import 'package:dorm_fix/src/features/yandex_map/model/dormitory.dart';
import 'package:flutter/widgets.dart';

class SuggestTem extends StatelessWidget {
  const SuggestTem({super.key, required this.dormitory});
  final DormitoryEntity dormitory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // final longitude = dormitory.longitude;
        // final latitude = dormitory.latitude;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dormitory.name),
          const SizedBox(height: 4.0),
          Text(""),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  // void _submitPointSearch(double longitude, double latitude) {
  //   final _searchManager = SearchFactory.instance.createSearchManager(
  //     SearchManagerType.Combined,
  //   );
  //   // SearchSession _searchSession = _searchManager.submitPoint(
  //   //   Point(latitude: latitude, longitude: longitude),
  //   //   SearchOptions(),
  //   // );
  // }
}
