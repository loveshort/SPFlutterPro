/*
 * @作者: 顾明次
 * @Date: 2025-10-30
 * @Email: gu271901088@gmail.com
 * @描述: Tab页面视图容器
 */
import 'package:flutter/material.dart';
import 'tab_config.dart';
import 'tab_controller.dart';

/// Tab页面视图容器
class TabPageView extends StatefulWidget {
  /// Tab控制器
  final CustomTabController controller;

  /// Tab配置列表
  final List<TabConfig> tabs;

  /// 是否保持页面状态
  final bool keepAlive;

  /// 是否启用页面滑动切换
  final bool enableSwipe;

  /// 页面切换动画曲线
  final Curve curve;

  /// 页面切换动画时长
  final Duration duration;

  const TabPageView({
    super.key,
    required this.controller,
    required this.tabs,
    this.keepAlive = true,
    this.enableSwipe = false,
    this.curve = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<TabPageView> createState() => _TabPageViewState();
}

class _TabPageViewState extends State<TabPageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.controller.currentIndex);
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _pageController.dispose();
    super.dispose();
  }

  /// 控制器索引变化监听
  void _onControllerChanged() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        widget.controller.currentIndex,
        duration: widget.duration,
        curve: widget.curve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.keepAlive) {
      // 使用PageView保持页面状态
      return PageView.builder(
        controller: _pageController,
        physics:
            widget.enableSwipe ? null : const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          widget.controller.jumpToIndex(index);
        },
        itemCount: widget.tabs.length,
        itemBuilder: (context, index) {
          return _KeepAlivePage(child: widget.tabs[index].page);
        },
      );
    } else {
      // 使用IndexedStack，不保持页面状态但切换无动画
      return ListenableBuilder(
        listenable: widget.controller,
        builder: (context, child) {
          return IndexedStack(
            index: widget.controller.currentIndex,
            children: widget.tabs.map((tab) => tab.page).toList(),
          );
        },
      );
    }
  }
}

/// 保持页面状态的包装组件
class _KeepAlivePage extends StatefulWidget {
  final Widget child;

  const _KeepAlivePage({required this.child});

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
