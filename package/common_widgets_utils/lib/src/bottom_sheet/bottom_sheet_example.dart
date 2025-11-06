/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27 10:00:00
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27 10:00:00
 * @FilePath: /common_widgets_utils/lib/src/bottom_sheet/bottom_sheet_example.dart
 * @Description: 底部弹窗组件使用示例
 */

import 'package:flutter/material.dart';
import 'bottom_sheet_widget.dart';

class BottomSheetExample extends StatefulWidget {
  const BottomSheetExample({super.key});

  @override
  State<BottomSheetExample> createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('底部弹窗示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '底部弹窗组件示例',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // 基础弹窗示例
            ElevatedButton(
              onPressed: () => _showBasicBottomSheet(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('基础弹窗'),
            ),
            const SizedBox(height: 16),

            // 确认对话框示例
            ElevatedButton(
              onPressed: () => _showConfirmDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('确认对话框'),
            ),
            const SizedBox(height: 16),

            // 选择列表示例
            ElevatedButton(
              onPressed: () => _showSelectionList(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('选择列表'),
            ),
            const SizedBox(height: 16),

            // 自定义内容示例
            ElevatedButton(
              onPressed: () => _showCustomContent(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('自定义内容'),
            ),
            const SizedBox(height: 16),

            // 全屏弹窗示例
            ElevatedButton(
              onPressed: () => _showFullScreenSheet(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('全屏弹窗'),
            ),
            const SizedBox(height: 16),

            // 不可拖拽弹窗示例
            ElevatedButton(
              onPressed: () => _showNonDraggableSheet(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('不可拖拽弹窗'),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示基础弹窗
  void _showBasicBottomSheet() {
    BottomSheetWidget.show(
      context: context,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              '这是一个基础底部弹窗',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '你可以在这里放置任何内容',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '点击背景或向下拖拽可以关闭弹窗',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 显示确认对话框
  void _showConfirmDialog() {
    BottomSheetUtils.showConfirmDialog(
      context: context,
      title: '确认删除',
      content: '确定要删除这个项目吗？此操作不可撤销。',
      confirmText: '删除',
      cancelText: '取消',
      confirmColor: Colors.red,
      onConfirm: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已确认删除')),
        );
      },
      onCancel: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('已取消删除')),
        );
      },
    );
  }

  /// 显示选择列表
  void _showSelectionList() {
    final options = ['选项一', '选项二', '选项三', '选项四', '选项五'];

    BottomSheetUtils.showSelectionList(
      context: context,
      title: '请选择一个选项',
      options: options,
      selectedIndex: 1, // 默认选中第二个选项
    ).then((selectedIndex) {
      if (mounted && selectedIndex != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('你选择了: ${options[selectedIndex]}')),
        );
      }
    });
  }

  /// 显示自定义内容
  void _showCustomContent() {
    BottomSheetWidget.show(
      context: context,
      config: const BottomSheetConfig(
        height: 0.5,
        borderRadius: 30.0,
        backgroundColor: Colors.white,
      ),
      child: Column(
        children: [
          // 自定义头部
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.star, color: Colors.white, size: 24),
                SizedBox(width: 12),
                Text(
                  '自定义内容弹窗',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 内容区域
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    '这是一个自定义的底部弹窗',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // 模拟表单
                  TextField(
                    decoration: InputDecoration(
                      labelText: '输入内容',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black87,
                          ),
                          child: const Text('取消'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('确定'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示全屏弹窗
  void _showFullScreenSheet() {
    BottomSheetWidget.show(
      context: context,
      config: const BottomSheetConfig(
        height: 0.95,
        showDragHandle: false,
        borderRadius: 0,
      ),
      child: Column(
        children: [
          // 自定义头部
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.red[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                const Expanded(
                  child: Text(
                    '全屏弹窗',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48), // 占位，保持标题居中
              ],
            ),
          ),

          // 内容区域
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[100],
                    child: Text('${index + 1}'),
                  ),
                  title: Text('列表项 ${index + 1}'),
                  subtitle: Text('这是第 ${index + 1} 个列表项的描述'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('点击了列表项 ${index + 1}')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 显示不可拖拽弹窗
  void _showNonDraggableSheet() {
    BottomSheetWidget.show(
      context: context,
      config: const BottomSheetConfig(
        height: 0.4,
        enableDrag: false,
        isDismissible: false,
        showDragHandle: false,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock,
              size: 48,
              color: Colors.teal,
            ),
            const SizedBox(height: 16),
            const Text(
              '重要提示',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '这是一个不可拖拽且不可通过点击背景关闭的弹窗。',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('我知道了'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
