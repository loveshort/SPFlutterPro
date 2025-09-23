/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27 10:00:00
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27 10:00:00
 * @FilePath: /common_widgets_utils/lib/src/center_dialog/center_dialog_example.dart
 * @Description: 中间弹窗使用示例
 */

import 'package:flutter/material.dart';
import 'center_dialog_widget.dart';

class CenterDialogExample extends StatefulWidget {
  const CenterDialogExample({super.key});

  @override
  State<CenterDialogExample> createState() => _CenterDialogExampleState();
}

class _CenterDialogExampleState extends State<CenterDialogExample> {
  String _inputResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('中间弹窗示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '中间弹窗组件示例',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // 确认对话框
            ElevatedButton(
              onPressed: () => _showConfirmDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('确认对话框'),
            ),
            const SizedBox(height: 12),

            // 警告对话框
            ElevatedButton(
              onPressed: () => _showWarningDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('警告对话框'),
            ),
            const SizedBox(height: 12),

            // 成功对话框
            ElevatedButton(
              onPressed: () => _showSuccessDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('成功对话框'),
            ),
            const SizedBox(height: 12),

            // 错误对话框
            ElevatedButton(
              onPressed: () => _showErrorDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('错误对话框'),
            ),
            const SizedBox(height: 12),

            // 输入对话框
            ElevatedButton(
              onPressed: () => _showInputDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('输入对话框'),
            ),
            const SizedBox(height: 12),

            // 加载对话框
            ElevatedButton(
              onPressed: () => _showLoadingDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('加载对话框'),
            ),
            const SizedBox(height: 12),

            // 自定义弹窗
            ElevatedButton(
              onPressed: () => _showCustomDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('自定义弹窗'),
            ),
            const SizedBox(height: 20),

            // 显示输入结果
            if (_inputResult.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '输入结果：',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _inputResult,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showConfirmDialog() {
    CenterDialogUtils.showConfirmDialog(
      context: context,
      title: '确认操作',
      content: '您确定要执行此操作吗？此操作不可撤销。',
      confirmText: '确定',
      cancelText: '取消',
      confirmColor: Colors.red,
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户点击了确认')),
        );
      },
      onCancel: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户点击了取消')),
        );
      },
    );
  }

  void _showWarningDialog() {
    CenterDialogUtils.showWarningDialog(
      context: context,
      title: '警告',
      content: '您的操作可能会影响系统稳定性，请谨慎操作。',
      confirmText: '我知道了',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户已确认警告')),
        );
      },
    );
  }

  void _showSuccessDialog() {
    CenterDialogUtils.showSuccessDialog(
      context: context,
      title: '操作成功',
      content: '您的操作已成功完成！',
      confirmText: '好的',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户确认了成功信息')),
        );
      },
    );
  }

  void _showErrorDialog() {
    CenterDialogUtils.showErrorDialog(
      context: context,
      title: '操作失败',
      content: '抱歉，操作失败。请检查网络连接后重试。',
      confirmText: '重试',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户选择重试')),
        );
      },
    );
  }

  void _showInputDialog() {
    CenterDialogUtils.showInputDialog(
      context: context,
      title: '请输入信息',
      hintText: '请输入您的姓名',
      initialValue: '张三',
      confirmText: '确认',
      cancelText: '取消',
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户确认了输入')),
        );
      },
      onCancel: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('用户取消了输入')),
        );
      },
    ).then((result) {
      if (result != null) {
        setState(() {
          _inputResult = result;
        });
      }
    });
  }

  void _showLoadingDialog() {
    CenterDialogUtils.showLoadingDialog(
      context: context,
      message: '正在处理数据...',
    );

    // 模拟异步操作
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop(); // 关闭加载对话框
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('加载完成')),
        );
      }
    });
  }

  void _showCustomDialog() {
    CenterDialogUtils.showCustom(
      context: context,
      config: const CenterDialogConfig(
        width: 0.9,
        height: 0.5,
        borderRadius: 20,
        showShadow: true,
        showBorder: true,
        borderColor: Colors.blue,
        borderWidth: 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 64,
            color: Colors.amber,
          ),
          const SizedBox(height: 16),
          const Text(
            '自定义弹窗',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '这是一个完全自定义的弹窗，您可以设置各种样式和内容。',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('用户点击了喜欢')),
                    );
                  },
                  icon: const Icon(Icons.favorite),
                  label: const Text('喜欢'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('用户点击了分享')),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('分享'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
