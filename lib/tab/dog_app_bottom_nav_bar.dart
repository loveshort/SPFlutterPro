/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: Dog APP 底部导航栏（根据 Figma 设计）
 */
import 'package:flutter/material.dart';
import 'dart:ui';

/// Dog APP 底部导航栏项配置
class DogAppNavItem {
  /// 标题
  final String title;

  /// 未选中时的图标
  final IconData unselectedIcon;

  /// 选中时的图标
  final IconData selectedIcon;

  /// 页面
  final Widget page;

  const DogAppNavItem({
    required this.title,
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.page,
  });
}

/// Dog APP 底部导航栏
class DogAppBottomNavBar extends StatelessWidget {
  /// 导航项列表
  final List<DogAppNavItem> items;

  /// 当前选中的索引
  final int currentIndex;

  /// 切换回调
  final ValueChanged<int>? onTap;

  const DogAppBottomNavBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1E22)
            .withValues(alpha: 0.8), // rgba(28,30,34,0.8)
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              items.length,
              (index) => _buildNavItem(index),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建导航项
  Widget _buildNavItem(int index) {
    final item = items[index];
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap?.call(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF212121)
                    .withValues(alpha: 0.1) // rgba(33,33,33,0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 图标
              Icon(
                isSelected ? item.selectedIcon : item.unselectedIcon,
                size: 16,
                color: isSelected
                    ? const Color(0xFFFDFDFD) // #fdfdfd
                    : const Color(0xFF8D9398), // #8d9398
              ),
              const SizedBox(height: 4),
              // 文字
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? const Color(0xFFFDFDFD) // #fdfdfd
                      : const Color(0xFF8D9398), // #8d9398
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dog APP Tab 脚手架（带底部导航栏）
class DogAppTabScaffold extends StatefulWidget {
  /// 导航项列表
  final List<DogAppNavItem> items;

  /// 初始索引
  final int initialIndex;

  /// AppBar
  final PreferredSizeWidget? appBar;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否保持页面状态
  final bool keepAlive;

  const DogAppTabScaffold({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.appBar,
    this.backgroundColor,
    this.keepAlive = true,
  });

  @override
  State<DogAppTabScaffold> createState() => _DogAppTabScaffoldState();
}

class _DogAppTabScaffoldState extends State<DogAppTabScaffold>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late PageController _pageController;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

    // 如果启用keepAlive，使用AutomaticKeepAliveClientMixin包装页面
    _pages = widget.items.map((item) {
      if (widget.keepAlive) {
        return _KeepAlivePage(page: item.page);
      }
      return item.page;
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
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          alignment: Alignment.center,
          child: DogAppBottomNavBar(
            items: widget.items,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
          ),
        ),
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
