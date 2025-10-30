/*
 * @作者: 顾明次
 * @Date: 2025-10-30
 * @Email: gu271901088@gmail.com
 * @描述: Tab脚手架 - 整合Tab页面视图和底部导航栏
 */
import 'package:flutter/material.dart';
import 'tab_config.dart';
import 'tab_controller.dart';
import 'tab_page_view.dart';
import 'custom_bottom_tab_bar.dart';

/// Tab脚手架
class TabScaffold extends StatefulWidget {
  /// Tab配置列表
  final List<TabConfig> tabs;

  /// 初始索引
  final int initialIndex;

  /// 是否保持页面状态
  final bool keepAlive;

  /// 底部导航栏样式
  final BottomTabBarStyle? barStyle;

  /// 索引变化回调
  final ValueChanged<int>? onIndexChanged;

  /// 是否启用页面滑动切换
  final bool enableSwipe;

  /// 页面切换动画曲线
  final Curve curve;

  /// 页面切换动画时长
  final Duration duration;

  /// 自定义AppBar
  final PreferredSizeWidget? appBar;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否调整body大小以避免底部inset
  final bool resizeToAvoidBottomInset;

  const TabScaffold({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.keepAlive = true,
    this.barStyle,
    this.onIndexChanged,
    this.enableSwipe = false,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 300),
    this.appBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  }) : assert(tabs.length >= 2, 'Tab数量必须至少为2个');

  @override
  State<TabScaffold> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<TabScaffold> {
  late CustomTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomTabController(
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
      onIndexChanged: widget.onIndexChanged,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      body: TabPageView(
        controller: _controller,
        tabs: widget.tabs,
        keepAlive: widget.keepAlive,
        enableSwipe: widget.enableSwipe,
        curve: widget.curve,
        duration: widget.duration,
      ),
      bottomNavigationBar: CustomBottomTabBar(
        controller: _controller,
        tabs: widget.tabs,
        style: widget.barStyle ?? const BottomTabBarStyle(),
      ),
    );
  }
}
