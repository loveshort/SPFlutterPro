/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 17:04:34
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 17:06:35
 * @FilePath: /SPFlutterPro/lib/common/decimal_util.dart
 * @Description: 小数计算工具类
 */
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
    return _scale(Decimal.fromBigInt(res.toBigInt()), scale);
  }

  static int cmp(num a, num b) => d(a).compareTo(d(b));

  static String _scale(Decimal v, int scale) {
    return v.toStringAsFixed(scale);
  }
}
