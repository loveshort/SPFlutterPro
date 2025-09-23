# 自定义底部Tab组件使用说明

## 概述

这是一个功能完善的Flutter底部Tab导航组件，支持高度自定义，包括图标替换、文字颜色、文字大小、徽章显示等功能。

## 主要特性

- ✅ **高度可定制**：支持自定义图标、颜色、大小、字体等
- ✅ **动画效果**：内置选中动画和切换动画
- ✅ **徽章支持**：支持显示数字徽章和文字徽章
- ✅ **状态保持**：支持页面状态保持，避免重复加载
- ✅ **响应式设计**：自适应不同屏幕尺寸
- ✅ **易于使用**：简单的API设计，快速集成

## 文件结构

```
lib/
├── models/
│   └── tab_item.dart                    # Tab数据模型
├── widgets/
│   └── custom_bottom_navigation_bar.dart # 自定义底部导航栏组件
├── pages/
│   ├── tab_pages.dart                   # Tab页面示例
│   └── bottom_tab_example.dart          # 使用示例
└── main.dart                           # 主入口文件
```

## 使用方法

### 1. 基本使用

```dart
import 'package:flutter/material.dart';
import 'models/tab_item.dart';
import 'widgets/custom_bottom_navigation_bar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<TabItem> tabs = [
      TabItem(
        title: '首页',
        unselectedIcon: Icons.home_outlined,
        selectedIcon: Icons.home,
        page: HomePage(),
      ),
      TabItem(
        title: '分类',
        unselectedIcon: Icons.category_outlined,
        selectedIcon: Icons.category,
        page: CategoryPage(),
      ),
    ];

    return TabPageContainer(
      tabs: tabs,
      initialIndex: 0,
    );
  }
}
```

### 2. 高级自定义

```dart
TabPageContainer(
  tabs: tabs,
  initialIndex: 0,
  keepAlive: true, // 保持页面状态
  bottomNavigationBar: CustomBottomNavigationBar(
    tabs: tabs,
    backgroundColor: Colors.white,
    height: 70.0,
    showTopBorder: true,
    topBorderColor: Colors.grey.shade300,
    enableAnimation: true,
    animationDuration: Duration(milliseconds: 200),
  ),
)
```

### 3. 带徽章的Tab

```dart
TabItem(
  title: '购物车',
  unselectedIcon: Icons.shopping_cart_outlined,
  selectedIcon: Icons.shopping_cart,
  page: CartPage(),
  showBadge: true,
  badgeText: '3',
  badgeColor: Colors.red,
)
```

## TabItem 参数说明

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| title | String | ✅ | Tab标题 |
| page | Widget | ✅ | 对应的页面Widget |
| unselectedIcon | IconData? | ❌ | 未选中状态的图标 |
| selectedIcon | IconData? | ❌ | 选中状态的图标 |
| unselectedIconColor | Color? | ❌ | 未选中状态的图标颜色 |
| selectedIconColor | Color? | ❌ | 选中状态的图标颜色 |
| unselectedTextColor | Color? | ❌ | 未选中状态的文字颜色 |
| selectedTextColor | Color? | ❌ | 选中状态的文字颜色 |
| fontSize | double? | ❌ | 文字大小 |
| fontWeight | FontWeight? | ❌ | 文字字体粗细 |
| iconSize | double? | ❌ | 图标大小 |
| showBadge | bool | ❌ | 是否显示徽章 |
| badgeText | String? | ❌ | 徽章内容 |
| badgeColor | Color? | ❌ | 徽章颜色 |

## CustomBottomNavigationBar 参数说明

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| tabs | List<TabItem> | ✅ | Tab项列表 |
| currentIndex | int | ❌ | 当前选中的索引 |
| onTap | ValueChanged<int>? | ❌ | Tab切换回调 |
| backgroundColor | Color? | ❌ | 背景颜色 |
| height | double? | ❌ | 高度 |
| showTopBorder | bool | ❌ | 是否显示顶部边框 |
| topBorderColor | Color? | ❌ | 顶部边框颜色 |
| topBorderWidth | double? | ❌ | 顶部边框宽度 |
| itemSpacing | double? | ❌ | Tab项间距 |
| enableAnimation | bool | ❌ | 是否启用动画 |
| animationDuration | Duration? | ❌ | 动画持续时间 |

## TabPageContainer 参数说明

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| tabs | List<TabItem> | ✅ | Tab项列表 |
| initialIndex | int | ❌ | 初始选中的索引 |
| bottomNavigationBar | CustomBottomNavigationBar? | ❌ | 底部导航栏配置 |
| keepAlive | bool | ❌ | 是否保持页面状态 |

## 示例效果

运行应用后，点击"底部Tab示例"或"高级底部Tab示例"按钮即可查看效果：

- **底部Tab示例**：基础功能展示，包含5个Tab页面
- **高级底部Tab示例**：高级自定义功能展示，包含不同的颜色主题和动画效果

## 注意事项

1. 确保每个TabItem都包含必需的`title`和`page`参数
2. 图标建议使用Material Design图标，确保选中和未选中状态有区别
3. 徽章文字建议不超过3个字符，避免显示问题
4. 动画持续时间建议设置在200-300毫秒之间，获得最佳用户体验

## 扩展功能

如需更多自定义功能，可以：

1. 修改`TabItem`模型添加更多属性
2. 在`CustomBottomNavigationBar`中添加更多样式选项
3. 自定义动画效果和过渡方式
4. 添加更多徽章样式和位置选项
