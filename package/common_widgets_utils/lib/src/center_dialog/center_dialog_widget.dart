/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27 10:00:00
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27 10:00:00
 * @FilePath: /common_widgets_utils/lib/src/center_dialog/center_dialog_widget.dart
 * @Description: 通用中间弹窗组件
 */

import 'package:flutter/material.dart';

/// 中间弹窗配置类
class CenterDialogConfig {
  /// 弹窗宽度，默认为屏幕宽度的0.8
  final double width;

  /// 弹窗高度，默认为屏幕高度的0.4
  final double height;

  /// 是否可以通过点击背景关闭
  final bool isDismissible;

  /// 背景颜色
  final Color? backgroundColor;

  /// 圆角半径
  final double borderRadius;

  /// 内边距
  final EdgeInsets padding;

  /// 外边距
  final EdgeInsets margin;

  /// 动画持续时间
  final Duration animationDuration;

  /// 是否显示阴影
  final bool showShadow;

  /// 阴影颜色
  final Color? shadowColor;

  /// 阴影模糊半径
  final double shadowBlurRadius;

  /// 阴影偏移
  final Offset shadowOffset;

  /// 是否显示边框
  final bool showBorder;

  /// 边框颜色
  final Color? borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 背景遮罩颜色
  final Color? barrierColor;

  /// 背景遮罩透明度
  final double barrierOpacity;

  const CenterDialogConfig({
    this.width = 0.8,
    this.height = 0.4,
    this.isDismissible = true,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(20.0),
    this.margin = const EdgeInsets.all(20.0),
    this.animationDuration = const Duration(milliseconds: 300),
    this.showShadow = true,
    this.shadowColor,
    this.shadowBlurRadius = 10.0,
    this.shadowOffset = const Offset(0, 4),
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.barrierColor,
    this.barrierOpacity = 0.5,
  });
}

/// 通用中间弹窗组件
class CenterDialogWidget extends StatefulWidget {
  /// 弹窗内容
  final Widget child;

  /// 弹窗配置
  final CenterDialogConfig config;

  /// 关闭回调
  final VoidCallback? onClose;

  /// 显示回调
  final VoidCallback? onShow;

  const CenterDialogWidget({
    super.key,
    required this.child,
    this.config = const CenterDialogConfig(),
    this.onClose,
    this.onShow,
  });

  /// 显示中间弹窗
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    CenterDialogConfig config = const CenterDialogConfig(),
    VoidCallback? onClose,
    VoidCallback? onShow,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: config.isDismissible,
      barrierColor: config.barrierColor?.withValues(alpha: config.barrierOpacity),
      builder: (context) => CenterDialogWidget(
        config: config,
        onClose: onClose,
        onShow: onShow,
        child: child,
      ),
    );
  }

  @override
  State<CenterDialogWidget> createState() => _CenterDialogWidgetState();
}

class _CenterDialogWidgetState extends State<CenterDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.config.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
    widget.onShow?.call();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final targetWidth = screenSize.width * widget.config.width;
    final targetHeight = screenSize.height * widget.config.height;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  width: targetWidth,
                  height: targetHeight,
                  margin: widget.config.margin,
                  padding: widget.config.padding,
                  decoration: BoxDecoration(
                    color: widget.config.backgroundColor ??
                        Theme.of(context).dialogTheme.backgroundColor ?? Theme.of(context).colorScheme.surface,
                    borderRadius:
                        BorderRadius.circular(widget.config.borderRadius),
                    border: widget.config.showBorder
                        ? Border.all(
                            color:
                                widget.config.borderColor ?? Colors.grey[300]!,
                            width: widget.config.borderWidth,
                          )
                        : null,
                    boxShadow: widget.config.showShadow
                        ? [
                            BoxShadow(
                              color: widget.config.shadowColor ??
                                  Colors.black.withValues(alpha: 0.1),
                              blurRadius: widget.config.shadowBlurRadius,
                              offset: widget.config.shadowOffset,
                            ),
                          ]
                        : null,
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 中间弹窗工具类
class CenterDialogUtils {
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
    CenterDialogConfig? config,
  }) {
    return CenterDialogWidget.show<bool>(
      context: context,
      config: config ?? const CenterDialogConfig(height: 0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
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

  /// 显示警告对话框
  static Future<void> showWarningDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = '知道了',
    Color? confirmColor,
    VoidCallback? onConfirm,
    CenterDialogConfig? config,
  }) {
    return CenterDialogWidget.show(
      context: context,
      config: config ?? const CenterDialogConfig(height: 0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Colors.orange[600],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmColor ?? Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示成功对话框
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = '好的',
    Color? confirmColor,
    VoidCallback? onConfirm,
    CenterDialogConfig? config,
  }) {
    return CenterDialogWidget.show(
      context: context,
      config: config ?? const CenterDialogConfig(height: 0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_rounded,
            size: 48,
            color: Colors.green[600],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmColor ?? Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示错误对话框
  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = '知道了',
    Color? confirmColor,
    VoidCallback? onConfirm,
    CenterDialogConfig? config,
  }) {
    return CenterDialogWidget.show(
      context: context,
      config: config ?? const CenterDialogConfig(height: 0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_rounded,
            size: 48,
            color: Colors.red[600],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmColor ?? Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    );
  }

  /// 显示输入对话框
  static Future<String?> showInputDialog({
    required BuildContext context,
    required String title,
    String? hintText,
    String? initialValue,
    String confirmText = '确认',
    String cancelText = '取消',
    Color? confirmColor,
    Color? cancelColor,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    CenterDialogConfig? config,
  }) {
    final TextEditingController controller =
        TextEditingController(text: initialValue);

    return CenterDialogWidget.show<String>(
      context: context,
      config: config ?? const CenterDialogConfig(height: 0.35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(null);
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
                    Navigator.of(context).pop(controller.text);
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

  /// 显示加载对话框
  static Future<void> showLoadingDialog({
    required BuildContext context,
    String message = '加载中...',
    CenterDialogConfig? config,
  }) {
    return CenterDialogWidget.show(
      context: context,
      config: config ??
          const CenterDialogConfig(height: 0.25, isDismissible: false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 显示自定义内容弹窗
  static Future<T?> showCustom<T>({
    required BuildContext context,
    required Widget child,
    CenterDialogConfig config = const CenterDialogConfig(),
  }) {
    return CenterDialogWidget.show<T>(
      context: context,
      child: child,
      config: config,
    );
  }
}
