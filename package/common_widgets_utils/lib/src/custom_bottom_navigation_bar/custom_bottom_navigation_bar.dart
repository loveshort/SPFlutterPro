/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 自定义底部导航栏组件
 */
import 'package:flutter/material.dart';

import 'tab_item.dart';

/// 自定义底部导航栏组件
class CustomBottomNavigationBar extends StatefulWidget {
  /// Tab项列表
  final List<TabItem> tabs;

  /// 当前选中的索引
  final int currentIndex;

  /// Tab切换回调
  final ValueChanged<int>? onTap;

  /// 背景颜色
  final Color? backgroundColor;

  /// 高度
  final double? height;

  /// 是否显示顶部边框
  final bool showTopBorder;

  /// 顶部边框颜色
  final Color? topBorderColor;

  /// 顶部边框宽度
  final double? topBorderWidth;

  /// Tab项间距
  final double? itemSpacing;

  /// 是否启用动画
  final bool enableAnimation;

  /// 动画持续时间
  final Duration? animationDuration;

  const CustomBottomNavigationBar({
    super.key,
    required this.tabs,
    this.currentIndex = 0,
    this.onTap,
    this.backgroundColor,
    this.height,
    this.showTopBorder = true,
    this.topBorderColor,
    this.topBorderWidth,
    this.itemSpacing,
    this.enableAnimation = true,
    this.animationDuration,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.enableAnimation) {
      _animationController = AnimationController(
        duration: widget.animationDuration ?? const Duration(milliseconds: 200),
        vsync: this,
      );
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 1.1,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.enableAnimation) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 60.0,
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
            Colors.white,
        border: widget.showTopBorder
            ? Border(
                top: BorderSide(
                  color: widget.topBorderColor ?? Colors.grey.shade300,
                  width: widget.topBorderWidth ?? 0.5,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.tabs.length,
          (index) => _buildTabItem(index),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final tab = widget.tabs[index];
    final isSelected = index == widget.currentIndex;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (widget.enableAnimation) {
            _animationController.forward().then((_) {
              _animationController.reverse();
            });
          }
          widget.onTap?.call(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.itemSpacing ?? 8.0,
            vertical: 8.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 图标部分
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedBuilder(
                    animation: widget.enableAnimation
                        ? _scaleAnimation
                        : const AlwaysStoppedAnimation(1.0),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: isSelected ? _scaleAnimation.value : 1.0,
                        child: Icon(
                          isSelected
                              ? (tab.selectedIcon ??
                                  tab.unselectedIcon ??
                                  Icons.circle)
                              : (tab.unselectedIcon ?? Icons.circle),
                          size: tab.iconSize ?? 24.0,
                          color: isSelected
                              ? (tab.selectedIconColor ??
                                  Theme.of(context).primaryColor)
                              : (tab.unselectedIconColor ??
                                  Colors.grey.shade600),
                        ),
                      );
                    },
                  ),
                  // 徽章
                  if (tab.showBadge && tab.badgeText != null)
                    Positioned(
                      right: -8,
                      top: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: tab.badgeColor ?? Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          tab.badgeText!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // 文字部分
              AnimatedDefaultTextStyle(
                duration: widget.enableAnimation
                    ? (widget.animationDuration ??
                        const Duration(milliseconds: 200))
                    : Duration.zero,
                style: TextStyle(
                  fontSize: tab.fontSize ?? 12.0,
                  fontWeight: isSelected
                      ? (tab.fontWeight ?? FontWeight.w600)
                      : FontWeight.normal,
                  color: isSelected
                      ? (tab.selectedTextColor ??
                          Theme.of(context).primaryColor)
                      : (tab.unselectedTextColor ?? Colors.grey.shade600),
                ),
                child: Text(
                  tab.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 带底部导航栏的页面容器
class TabPageContainer extends StatefulWidget {
  /// Tab项列表
  final List<TabItem> tabs;

  /// 初始选中的索引
  final int initialIndex;

  /// 底部导航栏配置
  final CustomBottomNavigationBar? bottomNavigationBar;

  /// 是否保持页面状态
  final bool keepAlive;

  const TabPageContainer({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.bottomNavigationBar,
    this.keepAlive = true,
  });

  @override
  State<TabPageContainer> createState() => _TabPageContainerState();
}

class _TabPageContainerState extends State<TabPageContainer>
    with TickerProviderStateMixin {
  late int _currentIndex;
  late PageController _pageController;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

    // 如果启用keepAlive，使用AutomaticKeepAliveClientMixin包装页面
    _pages = widget.tabs.map((tab) {
      if (widget.keepAlive) {
        return _KeepAlivePage(page: tab.page);
      }
      return tab.page;
    }).toList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: widget.bottomNavigationBar ??
          CustomBottomNavigationBar(
            tabs: widget.tabs,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
          ),
    );
  }
}

/// 保持页面状态的包装器
class _KeepAlivePage extends StatefulWidget {
  final Widget page;

  const _KeepAlivePage({required this.page});

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
    return widget.page;
  }
}
