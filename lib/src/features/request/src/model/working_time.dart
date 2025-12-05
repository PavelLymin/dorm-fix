abstract class WorkingTime {
  const WorkingTime();

  static const int startWorkHour = 8;
  static const int countWorkingHours = 9;

  static List<int> createWorkingHours(int start) {
    int length = (startWorkHour + countWorkingHours) - start;
    return List.generate(length, (index) {
      int hour = index + start;
      return hour;
    });
  }

  static bool isValidate(String startTime, String endTime) {
    if (startTime.isEmpty || endTime.isEmpty) {
      return false;
    } else if (int.tryParse(startTime) == null ||
        int.tryParse(endTime) == null) {
      return false;
    }

    return true;
  }
}
