/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 16:53:38
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 16:57:23
 * @FilePath: /SPFlutterPro/lib/common/snackbar_util.dart
 * @Description: SnackBar工具类
 */
import 'package:flutter/material.dart';

class SnackbarUtil {
  SnackbarUtil._();

  static void show(BuildContext context, String message, {Color? background}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: background),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message, background: Colors.green);

  static void error(BuildContext context, String message) =>
      show(context, message, background: Colors.red);
}
