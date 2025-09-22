/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-22 14:27:31
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-22 14:29:03
 * @FilePath: /SPFlutterPro/lib/widgets/dashed_line/dashed_line_example.dart
 * @Description: 虚线组件使用示例
 */

import 'package:flutter/material.dart';
import 'dashed_line.dart';

class DashedLineExample extends StatelessWidget {
  const DashedLineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('虚线组件示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 基础水平虚线
            const Text(
              '基础水平虚线',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const DashedLine(),
            const SizedBox(height: 20),

            // 自定义颜色和粗细
            const Text(
              '自定义颜色和粗细',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const DashedLine(
              color: Colors.red,
              strokeWidth: 2.0,
            ),
            const SizedBox(height: 20),

            // 自定义虚线长度和间距
            const Text(
              '自定义虚线长度和间距',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const DashedLine(
              color: Colors.green,
              dashWidth: 10.0,
              dashSpace: 5.0,
            ),
            const SizedBox(height: 20),

            // 垂直虚线
            const Text(
              '垂直虚线',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const DashedLine(
                  direction: Axis.vertical,
                  height: 100,
                  color: Colors.blue,
                ),
                const SizedBox(width: 20),
                const DashedLine(
                  direction: Axis.vertical,
                  height: 100,
                  color: Colors.orange,
                  strokeWidth: 3.0,
                  dashWidth: 8.0,
                  dashSpace: 4.0,
                ),
                const SizedBox(width: 20),
                const DashedLine(
                  direction: Axis.vertical,
                  height: 100,
                  color: Colors.purple,
                  strokeWidth: 2.0,
                  dashWidth: 15.0,
                  dashSpace: 2.0,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 在容器中使用
            const Text(
              '在容器中使用',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text('这是容器内容'),
                  const SizedBox(height: 16),
                  const DashedLine(
                    color: Colors.grey,
                    dashWidth: 6.0,
                    dashSpace: 3.0,
                  ),
                  const SizedBox(height: 16),
                  const Text('虚线分隔'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 不同宽度的水平虚线
            const Text(
              '不同宽度的水平虚线',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const DashedLine(
              width: 200,
              color: Colors.teal,
            ),
            const SizedBox(height: 8),
            const DashedLine(
              width: 150,
              color: Colors.indigo,
              strokeWidth: 2.0,
            ),
            const SizedBox(height: 8),
            const DashedLine(
              width: 100,
              color: Colors.pink,
              strokeWidth: 3.0,
              dashWidth: 8.0,
              dashSpace: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
