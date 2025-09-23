# BottomSheetWidget 使用指南

## 概述

BottomSheetWidget 是一个通用的底部下拉弹窗组件，提供了丰富的配置选项和预设场景，适用于各种业务需求。

## 基本使用

### 1. 导入组件

```dart
import 'package:common_widgets_utils/common_widgets_utils.dart';
```

### 2. 显示基础弹窗

```dart
BottomSheetWidget.show(
  context: context,
  child: Column(
    children: [
      Text('弹窗标题'),
      Text('弹窗内容'),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text('关闭'),
      ),
    ],
  ),
);
```

## 常用场景

### 确认对话框

```dart
// 删除确认
BottomSheetUtils.showConfirmDialog(
  context: context,
  title: '确认删除',
  content: '删除后无法恢复，确定要删除吗？',
  confirmText: '删除',
  cancelText: '取消',
  confirmColor: Colors.red,
  onConfirm: () {
    // 执行删除操作
    deleteItem();
  },
);

// 保存确认
BottomSheetUtils.showConfirmDialog(
  context: context,
  title: '保存更改',
  content: '是否保存当前修改？',
  confirmText: '保存',
  cancelText: '不保存',
  confirmColor: Colors.blue,
  onConfirm: () {
    saveChanges();
  },
);
```

### 选择列表

```dart
// 性别选择
BottomSheetUtils.showSelectionList(
  context: context,
  title: '选择性别',
  options: ['男', '女', '其他'],
  selectedIndex: 0,
).then((index) {
  if (index != null) {
    setState(() {
      selectedGender = index;
    });
  }
});

// 城市选择
final cities = ['北京', '上海', '广州', '深圳', '杭州'];
BottomSheetUtils.showSelectionList(
  context: context,
  title: '选择城市',
  options: cities,
  selectedIndex: currentCityIndex,
).then((index) {
  if (index != null) {
    setState(() {
      currentCityIndex = index;
      currentCity = cities[index];
    });
  }
});
```

### 表单弹窗

```dart
BottomSheetWidget.show(
  context: context,
  config: BottomSheetConfig(height: 0.7),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: '姓名'),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(labelText: '电话'),
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(labelText: '地址'),
          maxLines: 3,
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // 保存表单
                  Navigator.pop(context);
                },
                child: Text('保存'),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
```

## 高级配置

### 全屏弹窗

```dart
BottomSheetWidget.show(
  context: context,
  config: BottomSheetConfig(
    height: 0.95,
    showDragHandle: false,
    borderRadius: 0,
  ),
  child: YourFullScreenContent(),
);
```

### 不可关闭弹窗

```dart
BottomSheetWidget.show(
  context: context,
  config: BottomSheetConfig(
    enableDrag: false,
    isDismissible: false,
  ),
  child: Column(
    children: [
      Text('重要提示'),
      Text('请仔细阅读以下内容'),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text('我知道了'),
      ),
    ],
  ),
);
```

### 自定义样式

```dart
BottomSheetWidget.show(
  context: context,
  config: BottomSheetConfig(
    height: 0.5,
    borderRadius: 30.0,
    backgroundColor: Colors.white,
    showShadow: true,
    animationDuration: Duration(milliseconds: 500),
  ),
  child: YourCustomContent(),
);
```

## 实际应用示例

### 商品详情弹窗

```dart
void showProductDetail(Product product) {
  BottomSheetWidget.show(
    context: context,
    config: BottomSheetConfig(height: 0.8),
    child: Column(
      children: [
        // 商品图片
        Container(
          height: 200,
          width: double.infinity,
          child: Image.network(product.imageUrl),
        ),
        
        // 商品信息
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '¥${product.price}',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              SizedBox(height: 16),
              Text(product.description),
            ],
          ),
        ),
        
        // 操作按钮
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    addToCart(product);
                    Navigator.pop(context);
                  },
                  child: Text('加入购物车'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    buyNow(product);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text('立即购买'),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
```

### 设置选项弹窗

```dart
void showSettings() {
  BottomSheetWidget.show(
    context: context,
    config: BottomSheetConfig(height: 0.6),
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('通知设置'),
          trailing: Switch(
            value: notificationEnabled,
            onChanged: (value) {
              setState(() {
                notificationEnabled = value;
              });
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text('深色模式'),
          trailing: Switch(
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text('语言设置'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pop(context);
            showLanguageSelection();
          },
        ),
        ListTile(
          leading: Icon(Icons.privacy_tip),
          title: Text('隐私政策'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pop(context);
            showPrivacyPolicy();
          },
        ),
      ],
    ),
  );
}
```

## 注意事项

1. **性能优化**: 避免在弹窗中使用过于复杂的Widget树
2. **内存管理**: 及时释放不需要的资源，避免内存泄漏
3. **用户体验**: 确保弹窗内容在小屏幕设备上也能正常显示
4. **无障碍访问**: 为重要操作提供适当的语义标签
5. **测试覆盖**: 在不同设备和屏幕尺寸上测试弹窗效果