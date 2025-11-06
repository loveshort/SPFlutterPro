/*
 * @作者: 顾明次
 * @Date: 2025-10-30
 * @Email: gu271901088@gmail.com
 * @描述: Tab控制器
 */
import 'package:flutter/material.dart';

/// 自定义Tab控制器
class CustomTabController extends ChangeNotifier {
  /// 当前索引
  int _currentIndex;

  /// Tab数量
  final int length;

  /// 索引变化回调
  final ValueChanged<int>? onIndexChanged;

  CustomTabController({
    required this.length,
    int initialIndex = 0,
    this.onIndexChanged,
  }) : _currentIndex = initialIndex {
    assert(initialIndex >= 0 && initialIndex < length,
        'initialIndex必须在0到length-1之间');
  }

  /// 获取当前索引
  int get currentIndex => _currentIndex;

  /// 设置当前索引
  set currentIndex(int value) {
    if (value == _currentIndex) return;
    if (value < 0 || value >= length) {
      throw RangeError('Index $value is out of range [0, $length)');
    }

    _currentIndex = value;
    onIndexChanged?.call(value);
    notifyListeners();
  }

  /// 切换到指定索引
  void jumpToIndex(int index) {
    currentIndex = index;
  }

  /// 切换到下一个Tab
  void nextTab() {
    if (_currentIndex < length - 1) {
      currentIndex = _currentIndex + 1;
    }
  }

  /// 切换到上一个Tab
  void previousTab() {
    if (_currentIndex > 0) {
      currentIndex = _currentIndex - 1;
    }
  }

  /// 是否是第一个Tab
  bool get isFirst => _currentIndex == 0;

  /// 是否是最后一个Tab
  bool get isLast => _currentIndex == length - 1;


}
