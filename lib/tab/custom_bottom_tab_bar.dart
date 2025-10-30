/*
 * @作者: 顾明次
 * @Date: 2025-10-30
 * @Email: gu271901088@gmail.com
 * @描述: 自定义底部导航栏
 */
import 'package:flutter/material.dart';
import 'tab_config.dart';
import 'tab_controller.dart';
import 'tab_item_widget.dart';

/// 自定义底部导航栏
class CustomBottomTabBar extends StatelessWidget {
  /// Tab控制器
  final CustomTabController controller;

  /// Tab配置列表
  final List<TabConfig> tabs;

  /// 样式配置
  final BottomTabBarStyle style;

  const CustomBottomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.style = const BottomTabBarStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: style.height + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: style.backgroundColor ?? Colors.white,
        border: style.showTopBorder
            ? Border(
                top: BorderSide(
                  color: style.topBorderColor ?? Colors.grey.shade300,
                  width: style.topBorderWidth,
                ),
              )
            : null,
        boxShadow: style.boxShadow,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: style.padding ?? EdgeInsets.zero,
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  tabs.length,
                  (index) => TabItemWidget(
                    config: tabs[index],
                    isSelected: controller.currentIndex == index,
                    style: style,
                    onTap: () => controller.jumpToIndex(index),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
