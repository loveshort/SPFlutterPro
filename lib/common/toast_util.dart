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
