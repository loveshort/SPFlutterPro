# Tab封装使用指南

这是一个功能完整、可高度定制的Tab底部导航栏封装组件。

## 特性

- 🎨 完全可定制的样式
- 🔄 支持Tab页面状态保持
- 📱 支持徽章显示
- ✨ 支持切换动画
- 🎯 支持独立的Tab控制器
- 💪 支持禁用特定Tab
- 🌊 支持水波纹效果
- 📍 可选的页面滑动切换

## 快速开始

### 基础用法

```dart
import 'package:sp_flutter_shopping/tab/tab.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabScaffold(
      tabs: [
        TabConfig(
          title: '首页',
          unselectedIcon: Icons.home_outlined,
          selectedIcon: Icons.home,
          page: HomePage(),
        ),
        TabConfig(
          title: '分类',
          unselectedIcon: Icons.category_outlined,
          selectedIcon: Icons.category,
          page: CategoryPage(),
        ),
        TabConfig(
          title: '我的',
          unselectedIcon: Icons.person_outline,
          selectedIcon: Icons.person,
          page: ProfilePage(),
        ),
      ],
    );
  }
}
```

### 高级用法

```dart
TabScaffold(
  tabs: [
    TabConfig(
      title: '首页',
      unselectedIcon: Icons.home_outlined,
      selectedIcon: Icons.home,
      unselectedIconColor: Colors.grey,
      selectedIconColor: Colors.blue,
      unselectedTextColor: Colors.grey,
      selectedTextColor: Colors.blue,
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      iconSize: 24.0,
      page: HomePage(),
    ),
    TabConfig(
      title: '购物车',
      unselectedIcon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      selectedIconColor: Colors.orange,
      selectedTextColor: Colors.orange,
      page: CartPage(),
      showBadge: true,
      badgeText: '3',
      badgeColor: Colors.red,
    ),
    TabConfig(
      title: '消息',
      unselectedIcon: Icons.message_outlined,
      selectedIcon: Icons.message,
      selectedIconColor: Colors.red,
      selectedTextColor: Colors.red,
      page: MessagePage(),
      showBadge: true,
      badgeText: '99+',
      badgeColor: Colors.red,
    ),
  ],
  initialIndex: 0,
  keepAlive: true,
  enableSwipe: false,
  barStyle: BottomTabBarStyle(
    backgroundColor: Colors.white,
    height: 70.0,
    showTopBorder: true,
    topBorderColor: Colors.grey.shade300,
    topBorderWidth: 0.5,
    itemSpacing: 4.0,
    enableAnimation: true,
    animationDuration: Duration(milliseconds: 200),
    enableRipple: true,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, -2),
      ),
    ],
  ),
  onIndexChanged: (index) {
    print('Tab切换到: $index');
  },
);
```

### 使用独立的Tab控制器

```dart
class MyTabPage extends StatefulWidget {
  @override
  _MyTabPageState createState() => _MyTabPageState();
}

class _MyTabPageState extends State<MyTabPage> {
  late CustomTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomTabController(
      length: 3,
      initialIndex: 0,
      onIndexChanged: (index) {
        print('Tab切换到: $index');
      },
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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _controller.nextTab(),
            child: Text('下一个Tab'),
          ),
          Expanded(
            child: TabPageView(
              controller: _controller,
              tabs: [...],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomTabBar(
        controller: _controller,
        tabs: [...],
      ),
    );
  }
}
```

## 主要组件

### TabConfig

Tab配置类，用于定义每个Tab的外观和行为。

**主要属性：**
- `title`: Tab标题
- `unselectedIcon`: 未选中图标
- `selectedIcon`: 选中图标
- `page`: Tab页面
- `unselectedIconColor`: 未选中图标颜色
- `selectedIconColor`: 选中图标颜色
- `unselectedTextColor`: 未选中文本颜色
- `selectedTextColor`: 选中文本颜色
- `fontSize`: 字体大小
- `fontWeight`: 字体粗细
- `iconSize`: 图标大小
- `showBadge`: 是否显示徽章
- `badgeText`: 徽章文本
- `badgeColor`: 徽章背景色
- `enabled`: 是否启用

### BottomTabBarStyle

底部导航栏样式配置类。

**主要属性：**
- `backgroundColor`: 背景颜色
- `height`: 高度
- `showTopBorder`: 是否显示顶部边框
- `topBorderColor`: 顶部边框颜色
- `topBorderWidth`: 顶部边框宽度
- `itemSpacing`: Tab项间距
- `enableAnimation`: 是否启用动画
- `animationDuration`: 动画时长
- `enableRipple`: 是否启用水波纹效果
- `rippleColor`: 水波纹颜色
- `padding`: 内边距
- `boxShadow`: 阴影

### CustomTabController

Tab控制器，用于管理Tab状态和切换。

**主要方法：**
- `jumpToIndex(int index)`: 跳转到指定索引
- `nextTab()`: 切换到下一个Tab
- `previousTab()`: 切换到上一个Tab
- `get currentIndex`: 获取当前索引
- `set currentIndex`: 设置当前索引
- `get isFirst`: 是否是第一个Tab
- `get isLast`: 是否是最后一个Tab

### TabScaffold

Tab脚手架，整合了Tab页面视图和底部导航栏。

**主要属性：**
- `tabs`: Tab配置列表
- `initialIndex`: 初始索引
- `keepAlive`: 是否保持页面状态
- `barStyle`: 底部导航栏样式
- `onIndexChanged`: 索引变化回调
- `enableSwipe`: 是否启用页面滑动切换
- `curve`: 页面切换动画曲线
- `duration`: 页面切换动画时长

## 示例场景

### 1. 电商App底部导航

```dart
TabScaffold(
  tabs: [
    TabConfig(
      title: '首页',
      unselectedIcon: Icons.home_outlined,
      selectedIcon: Icons.home,
      selectedIconColor: Colors.blue,
      selectedTextColor: Colors.blue,
      page: HomePage(),
    ),
    TabConfig(
      title: '分类',
      unselectedIcon: Icons.category_outlined,
      selectedIcon: Icons.category,
      selectedIconColor: Colors.green,
      selectedTextColor: Colors.green,
      page: CategoryPage(),
    ),
    TabConfig(
      title: '购物车',
      unselectedIcon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      selectedIconColor: Colors.orange,
      selectedTextColor: Colors.orange,
      page: CartPage(),
      showBadge: true,
      badgeText: '3',
    ),
    TabConfig(
      title: '我的',
      unselectedIcon: Icons.person_outline,
      selectedIcon: Icons.person,
      selectedIconColor: Colors.purple,
      selectedTextColor: Colors.purple,
      page: ProfilePage(),
    ),
  ],
);
```

### 2. 社交App底部导航（带消息徽章）

```dart
TabScaffold(
  tabs: [
    TabConfig(
      title: '动态',
      unselectedIcon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: FeedPage(),
    ),
    TabConfig(
      title: '消息',
      unselectedIcon: Icons.message_outlined,
      selectedIcon: Icons.message,
      page: MessagePage(),
      showBadge: true,
      badgeText: '99+',
      badgeColor: Colors.red,
    ),
    TabConfig(
      title: '发布',
      unselectedIcon: Icons.add_circle_outline,
      selectedIcon: Icons.add_circle,
      page: PublishPage(),
    ),
    TabConfig(
      title: '我的',
      unselectedIcon: Icons.person_outline,
      selectedIcon: Icons.person,
      page: ProfilePage(),
    ),
  ],
);
```

## 注意事项

1. Tab数量必须至少为2个
2. `initialIndex` 必须在有效范围内（0到length-1）
3. 启用 `keepAlive` 会保持所有Tab页面状态，但会增加内存占用
4. 启用 `enableSwipe` 允许用户滑动切换Tab，但可能与页面内的滑动手势冲突
5. 徽章文本建议不超过3个字符，过长会影响显示效果

## 最佳实践

1. 为每个Tab使用不同的颜色，提升用户体验
2. 合理使用徽章功能，避免过度使用
3. 根据实际需求选择是否保持页面状态
4. 为重要操作的Tab（如购物车、消息）添加徽章提示
5. 保持Tab数量在3-5个之间，过多会影响用户体验

## 更新记录

- v1.0.0 (2025-10-30)
  - 初始版本
  - 支持基础Tab功能
  - 支持徽章显示
  - 支持自定义样式
  - 支持页面状态保持
  - 支持独立控制器

