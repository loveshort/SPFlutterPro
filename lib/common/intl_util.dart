/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 15:02:07
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 15:02:32
 * @FilePath: /SPFlutterPro/lib/common/intl_util.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:intl/intl.dart';

class IntlUtil {
  IntlUtil._();

  static String formatDate(DateTime dateTime,
      {String pattern = 'yyyy-MM-dd HH:mm'}) {
    return DateFormat(pattern).format(dateTime);
  }

  static String formatCurrency(num amount,
      {String locale = 'zh_CN', String symbol = '¥'}) {
    final formatter = NumberFormat.currency(locale: locale, symbol: symbol);
    return formatter.format(amount);
  }

  static String formatDecimal(num number, {int decimalDigits = 2}) {
    final formatter = NumberFormat.decimalPattern()
      ..minimumFractionDigits = decimalDigits
      ..maximumFractionDigits = decimalDigits;
    return formatter.format(number);
  }

  static String relativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inSeconds < 60) return '${diff.inSeconds}秒前';
    if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
    if (diff.inHours < 24) return '${diff.inHours}小时前';
    if (diff.inDays < 7) return '${diff.inDays}天前';
    return formatDate(dateTime, pattern: 'yyyy-MM-dd');
  }
}
