import 'package:flutter/material.dart';

class DialogUtil {
  DialogUtil._();

  static Future<void> alert(BuildContext context, String message,
      {String title = '提示'}) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('知道了')),
        ],
      ),
    );
  }

  static Future<bool> confirm(BuildContext context, String message,
      {String title = '确认'}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消')),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确定')),
        ],
      ),
    );
    return result ?? false;
  }
}
