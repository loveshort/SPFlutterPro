/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 16:53:31
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 16:55:39
 * @FilePath: /SPFlutterPro/lib/common/clipboard_util.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/services.dart';

class ClipboardUtil {
  ClipboardUtil._();

  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String?> paste() async {
    final data = await Clipboard.getData('text/plain');
    return data?.text;
  }
}
