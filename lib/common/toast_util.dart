/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 17:04:05
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 17:06:53
 * @FilePath: /SPFlutterPro/lib/common/toast_util.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  ToastUtil._();

  static void show(String msg, {Duration? duration}) {
    showToast(msg, duration: duration ?? const Duration(seconds: 2));
  }

  static void success(String msg) {
    showToastWidget(
      _buildToast(msg, Colors.green),
      duration: const Duration(seconds: 2),
    );
  }

  static void error(String msg) {
    showToastWidget(
      _buildToast(msg, Colors.red),
      duration: const Duration(seconds: 2),
    );
  }

  static Widget _buildToast(String msg, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              msg,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
