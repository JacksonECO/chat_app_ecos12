mixin Date {
  String dateHours(DateTime date) {
    return _zero(date.hour) + ':' + _zero(date.minute);
  }

  String _zero(int n) {
    String a = n.toString();
    if (a.length == 1) {
      return '0' + a;
    }
    return a;
  }
}
