/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27 10:00:00
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27 10:00:00
 * @FilePath: /common_widgets_utils/lib/src/bottom_sheet/bottom_sheet_widget.dart
 * @Description: 通用底部下拉弹窗组件
 */

import 'package:flutter/material.dart';

/// 底部弹窗配置类
class BottomSheetConfig {
  /// 弹窗高度，默认为屏幕高度的0.6
  final double height;

  /// 是否显示拖拽指示器
  final bool showDragHandle;

  /// 是否可以通过点击背景关闭
  final bool isDismissible;

  /// 是否可以通过拖拽关闭
  final bool enableDrag;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角半径
  final double borderRadius;

  /// 顶部边距
  final double topPadding;

  /// 左右边距
  final double horizontalPadding;

  /// 动画持续时间
  final Duration animationDuration;

  /// 是否显示阴影
  final bool showShadow;

  const BottomSheetConfig({
    this.height = 0.6,
    this.showDragHandle = true,
    this.isDismissible = true,
    this.enableDrag = true,
    this.backgroundColor,
    this.borderRadius = 20.0,
    this.topPadding = 10.0,
    this.horizontalPadding = 0.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showShadow = true,
  });
}

/// 通用底部下拉弹窗组件
class BottomSheetWidget extends StatefulWidget {
  /// 弹窗内容
  final Widget child;

  /// 弹窗配置
  final BottomSheetConfig config;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 显示回调
  final VoidCallback? onShow;

  const BottomSheetWidget({
    super.key,
    required this.child,
    this.config = const BottomSheetConfig(),
    this.onClose,
    this.onShow,
  });

  /// 显示底部弹窗
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    BottomSheetConfig config = const BottomSheetConfig(),
    VoidCallback? onClose,
    VoidCallback? onShow,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: config.isDismissible,
      enableDrag: config.enableDrag,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => BottomSheetWidget(
        config: config,
        onClose: onClose,
        onShow: onShow,
        child: child,
      ),
    );
  }

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    widget.onShow?.call();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _closeSheet() {
    _animationController.reverse().then((_) {
      if (mounted) {
        Navigator.of(context).pop();
        widget.onClose?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final targetHeight = screenHeight * widget.config.height;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.black.withValues(alpha: 0.5 * _animation.value),
          child: Stack(
            children: [
              // 背景点击区域
              if (widget.config.isDismissible)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _closeSheet,
                    child: Container(color: Colors.transparent),
                  ),
                ),

              // 弹窗内容
              Positioned(
                bottom: 0,
                left: widget.config.horizontalPadding,
                right: widget.config.horizontalPadding,
                child: Transform.translate(
                  offset: Offset(0, targetHeight * (1 - _animation.value)),
                  child: Container(
                    height: targetHeight,
                    decoration: BoxDecoration(
                      color: widget.config.backgroundColor ??
                          Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.config.borderRadius),
                        topRight: Radius.circular(widget.config.borderRadius),
                      ),
                      boxShadow: widget.config.showShadow
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, -2),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      children: [
                        // 拖拽指示器
                        if (widget.config.showDragHandle)
                          Container(
                            margin:
                                EdgeInsets.only(top: widget.config.topPadding),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),

                        // 内容区域
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: widget.config.showDragHandle
                                  ? 16
                                  : widget.config.topPadding,
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: widget.child,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 底部弹窗工具类
class BottomSheetUtils {
  /// 显示确认对话框
  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = '确认',
    String cancelText = '取消',
    Color? confirmColor,
    Color? cancelColor,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return BottomSheetWidget.show<bool>(
      context: context,
      config: const BottomSheetConfig(height: 0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    onCancel?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cancelColor ?? Colors.grey[300],
                    foregroundColor: Colors.black87,
                  ),
                  child: Text(cancelText),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onConfirm?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor ?? Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(confirmText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 显示选择列表
  static Future<int?> showSelectionList({
    required BuildContext context,
    required List<String> options,
    String? title,
    int? selectedIndex,
    Color? selectedColor,
  }) {
    return BottomSheetWidget.show<int>(
      context: context,
      config: BottomSheetConfig(
        height:
            (options.length * 60.0 + 100) / MediaQuery.of(context).size.height,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
          ],
          ...options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = selectedIndex == index;

            return ListTile(
              title: Text(option),
              trailing: isSelected
                  ? Icon(
                      Icons.check,
                      color: selectedColor ?? Colors.blue,
                    )
                  : null,
              onTap: () => Navigator.of(context).pop(index),
            );
          }),
        ],
      ),
    );
  }

  /// 显示自定义内容弹窗
  static Future<T?> showCustom<T>({
    required BuildContext context,
    required Widget child,
    BottomSheetConfig config = const BottomSheetConfig(),
  }) {
    return BottomSheetWidget.show<T>(
      context: context,
      child: child,
      config: config,
    );
  }
}
