/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/router/go_router_transitions.dart
 * @Description: GoRouter 过渡动画 - 丰富的页面切换效果
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

/// GoRouter 过渡动画
/// 提供丰富的页面切换效果
class GoRouterTransitions {
  // 私有构造函数，防止实例化
  GoRouterTransitions._();

  // ==================== 基础过渡动画 ====================

  /// 滑动过渡动画
  static Page<T> slideTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    AxisDirection direction = AxisDirection.left,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offset = _getSlideOffset(direction);
        final slideAnimation = Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
    );
  }

  /// 淡入淡出过渡动画
  static Page<T> fadeTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }

  /// 缩放过渡动画
  static Page<T> scaleTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    double beginScale = 0.8,
    double endScale = 1.0,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = Tween<double>(
          begin: beginScale,
          end: endScale,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }

  /// 旋转过渡动画
  static Page<T> rotationTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    double beginRotation = 0.0,
    double endRotation = 1.0,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final rotationAnimation = Tween<double>(
          begin: beginRotation,
          end: endRotation,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return RotationTransition(
          turns: rotationAnimation,
          child: child,
        );
      },
    );
  }

  // ==================== 组合过渡动画 ====================

  /// 滑动 + 淡入淡出组合动画
  static Page<T> slideFadeTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    AxisDirection direction = AxisDirection.left,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offset = _getSlideOffset(direction);
        final slideAnimation = Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// 缩放 + 淡入淡出组合动画
  static Page<T> scaleFadeTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    double beginScale = 0.8,
    double endScale = 1.0,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = Tween<double>(
          begin: beginScale,
          end: endScale,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// 滑动 + 缩放组合动画
  static Page<T> slideScaleTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    AxisDirection direction = AxisDirection.left,
    double beginScale = 0.9,
    double endScale = 1.0,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offset = _getSlideOffset(direction);
        final slideAnimation = Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        final scaleAnimation = Tween<double>(
          begin: beginScale,
          end: endScale,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );
  }

  // ==================== 特殊过渡动画 ====================

  /// 翻转过渡动画
  static Page<T> flipTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final flipAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return AnimatedBuilder(
          animation: flipAnimation,
          builder: (context, child) {
            final isHalfway = flipAnimation.value >= 0.5;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(flipAnimation.value * 3.14159),
              child: isHalfway
                  ? child
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(3.14159),
                      child: child,
                    ),
            );
          },
          child: child,
        );
      },
    );
  }

  /// 弹性过渡动画
  static Page<T> elasticTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.elasticOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        ));

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }

  /// 波浪过渡动画
  static Page<T> waveTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return ClipPath(
              clipper: WaveClipper(animation.value),
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }

  // ==================== 辅助方法 ====================

  /// 获取滑动偏移量
  static Offset _getSlideOffset(AxisDirection direction) {
    switch (direction) {
      case AxisDirection.left:
        return const Offset(1.0, 0.0);
      case AxisDirection.right:
        return const Offset(-1.0, 0.0);
      case AxisDirection.up:
        return const Offset(0.0, 1.0);
      case AxisDirection.down:
        return const Offset(0.0, -1.0);
    }
  }

  /// 获取默认过渡动画
  static Page<T> defaultTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return slideTransition<T>(
      context: context,
      state: state,
      child: child,
    );
  }

  /// 获取无过渡动画
  static Page<T> noTransition<T extends Object?>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return MaterialPage<T>(
      key: state.pageKey,
      child: child,
    );
  }
}

/// 波浪裁剪器
class WaveClipper extends CustomClipper<Path> {
  final double animationValue;

  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();
    final waveHeight = size.height * 0.1;
    final waveLength = size.width / 2;

    path.moveTo(0, size.height);
    path.lineTo(0, size.height - waveHeight);

    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height -
          waveHeight *
              (1 +
                  math.sin((x / waveLength) * 2 * math.pi +
                      animationValue * 2 * math.pi)) /
              2;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
