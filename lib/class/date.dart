import 'package:ecos12_chat_app/class/rest.dart';

abstract class Date {
  static Duration errorTime = const Duration();

  static String hoursWithMinute(DateTime date) {
    var _date = dateLocate(date);
    return _zero(_date.hour) + ':' + _zero(_date.minute);
  }

  static String _zero(int n) {
    String a = n.toString();
    if (a.length == 1) {
      return '0' + a;
    }
    return a;
  }

  static DateTime dateLocate(DateTime date) {
    return date.toLocal().add(errorTime);
  }

  static DateTime dateServer() {
    return DateTime.now().toUtc().subtract(errorTime);
  }

  static Future<void> init() async {
    try {
      var milliseconds = (await Rest.get())['timestamp'];

      var locate = DateTime.now().toUtc();
      var server = DateTime.fromMillisecondsSinceEpoch(milliseconds);

      errorTime = locate.difference(server);
      print('Erro time: ' + errorTime.toString());
    } catch (e) {
      print('Connecting');
      await Future.delayed(const Duration(seconds: 1));
      return init();
    }
  }
}
