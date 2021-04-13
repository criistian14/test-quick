class TimeUtils {
  String transformSecondsToTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;

    return _formatTime(minute) + ":" + _formatTime(second);
  }

  // Digital formatting, converting 0-9 time to 00-09
  String _formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }
}
