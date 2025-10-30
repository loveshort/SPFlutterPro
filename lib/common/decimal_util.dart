import 'package:decimal/decimal.dart';

class DecimalUtil {
  DecimalUtil._();

  static Decimal d(num value) => Decimal.parse(value.toString());

  static String add(num a, num b, {int scale = 2}) =>
      _scale(d(a) + d(b), scale);
  static String sub(num a, num b, {int scale = 2}) =>
      _scale(d(a) - d(b), scale);
  static String mul(num a, num b, {int scale = 2}) =>
      _scale(d(a) * d(b), scale);
  static String div(num a, num b, {int scale = 2}) {
    final res = d(a) / d(b);
    return _scale(res, scale);
  }

  static int cmp(num a, num b) => d(a).compareTo(d(b));

  static String _scale(Decimal v, int scale) {
    return v.toStringAsFixed(scale);
  }
}
