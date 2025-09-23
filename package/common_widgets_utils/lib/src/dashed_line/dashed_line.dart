/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-22 14:27:31
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-22 14:35:42
 * @FilePath: /SPFlutterPro/lib/widgets/dashed_line/dashed_line.dart
 * @Description: 虚线组件
 */

import 'package:flutter/material.dart';

/// 虚线组件
///
/// 一个功能强大且高度可定制的Flutter虚线组件，支持水平和垂直方向的虚线绘制。
/// 使用CustomPaint实现真正的虚线效果，性能优异。
///
/// 示例：
/// ```dart
/// // 基础使用
/// DashedLine()
///
/// // 自定义样式
/// DashedLine(
///   color: Colors.red,
///   strokeWidth: 2.0,
///   dashWidth: 10.0,
///   dashSpace: 5.0,
/// )
///
/// // 垂直虚线
/// DashedLine(
///   direction: Axis.vertical,
///   height: 100,
///   color: Colors.blue,
/// )
/// ```
class DashedLine extends StatelessWidget {
  /// 创建虚线组件
  ///
  /// [color] 虚线的颜色，默认为灰色
  /// [strokeWidth] 线条的粗细，默认为1.0
  /// [dashWidth] 每个虚线段的长度，默认为5.0
  /// [dashSpace] 虚线之间的间距，默认为3.0
  /// [direction] 虚线方向，默认为水平方向
  /// [width] 水平虚线的宽度，为null时自适应父容器
  /// [height] 垂直虚线的高度，为null时自适应父容器
  const DashedLine({
    super.key,
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.direction = Axis.horizontal,
    this.width,
    this.height,
  });

  /// 虚线颜色
  final Color color;

  /// 线条粗细
  final double strokeWidth;

  /// 虚线长度
  final double dashWidth;

  /// 虚线间距
  final double dashSpace;

  /// 方向：水平或垂直
  final Axis direction;

  /// 宽度（仅水平方向有效）
  final double? width;

  /// 高度（仅垂直方向有效）
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        direction == Axis.horizontal ? (width ?? double.infinity) : strokeWidth,
        direction == Axis.vertical ? (height ?? double.infinity) : strokeWidth,
      ),
      painter: DashedLinePainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        direction: direction,
      ),
    );
  }
}

/// 虚线绘制器
///
/// 负责实际的虚线绘制逻辑，支持水平和垂直方向的虚线绘制。
/// 使用Canvas API绘制虚线，性能优异。
class DashedLinePainter extends CustomPainter {
  /// 创建虚线绘制器
  ///
  /// [color] 虚线的颜色
  /// [strokeWidth] 线条的粗细
  /// [dashWidth] 每个虚线段的长度
  /// [dashSpace] 虚线之间的间距
  /// [direction] 虚线方向：水平或垂直
  DashedLinePainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.direction,
  });

  final Color color; // 虚线颜色
  final double strokeWidth; // 线条粗细
  final double dashWidth; // 虚线长度
  final double dashSpace; // 虚线间距
  final Axis direction; // 方向：水平或垂直

  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // 根据方向选择绘制方法
    if (direction == Axis.horizontal) {
      _drawHorizontalDashedLine(canvas, paint, size);
    } else {
      _drawVerticalDashedLine(canvas, paint, size);
    }
  }

  /// 绘制水平虚线
  ///
  /// [canvas] 画布对象
  /// [paint] 画笔对象
  /// [size] 绘制区域大小
  void _drawHorizontalDashedLine(Canvas canvas, Paint paint, Size size) {
    final double centerY = size.height / 2; // 计算垂直中心位置
    double startX = 0; // 起始X坐标

    // 循环绘制虚线
    while (startX < size.width) {
      final double endX = (startX + dashWidth).clamp(0.0, size.width);
      // 绘制一条虚线
      canvas.drawLine(
        Offset(startX, centerY),
        Offset(endX, centerY),
        paint,
      );
      // 计算下一个虚线的起点
      startX += dashWidth + dashSpace;
    }
  }

  /// 绘制垂直虚线
  ///
  /// [canvas] 画布对象
  /// [paint] 画笔对象
  /// [size] 绘制区域大小
  void _drawVerticalDashedLine(Canvas canvas, Paint paint, Size size) {
    final double centerX = size.width / 2; // 计算水平中心位置
    double startY = 0; // 起始Y坐标

    // 循环绘制虚线
    while (startY < size.height) {
      final double endY = (startY + dashWidth).clamp(0.0, size.height);
      // 绘制一条虚线
      canvas.drawLine(
        Offset(centerX, startY),
        Offset(centerX, endY),
        paint,
      );
      // 计算下一个虚线的起点
      startY += dashWidth + dashSpace;
    }
  }

  @override

  /// 判断是否需要重新绘制
  ///
  /// 当任何绘制参数发生变化时返回true，触发重新绘制
  /// [oldDelegate] 之前的绘制器实例
  /// 返回true表示需要重新绘制，false表示可以复用之前的绘制结果
  bool shouldRepaint(DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.direction != direction;
  }
}
