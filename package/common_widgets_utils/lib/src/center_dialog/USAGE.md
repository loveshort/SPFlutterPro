# 中间弹窗组件使用说明

## 概述

`CenterDialogWidget` 是一个通用的中间弹窗组件，提供了丰富的配置选项和多种预设的弹窗类型，适用于各种业务场景。

## 特性

- 🎨 **高度可定制**：支持自定义尺寸、颜色、圆角、阴影等样式
- 🎭 **多种预设类型**：确认、警告、成功、错误、输入、加载等常用弹窗
- 🎬 **流畅动画**：内置弹性动画效果，提升用户体验
- 📱 **响应式设计**：自适应不同屏幕尺寸
- 🔧 **易于使用**：提供工具类方法，快速调用各种弹窗

## 快速开始

### 1. 导入组件

```dart
import 'package:common_widgets_utils/common_widgets_utils.dart';
```

### 2. 基本使用

```dart
// 显示确认对话框
CenterDialogUtils.showConfirmDialog(
  context: context,
  title: '确认操作',
  content: '您确定要执行此操作吗？',
  onConfirm: () {
    // 确认回调
  },
  onCancel: () {
    // 取消回调
  },
);
```

## 配置选项

### CenterDialogConfig 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `width` | `double` | `0.8` | 弹窗宽度（屏幕宽度比例） |
| `height` | `double` | `0.4` | 弹窗高度（屏幕高度比例） |
| `isDismissible` | `bool` | `true` | 是否可点击背景关闭 |
| `backgroundColor` | `Color?` | `null` | 背景颜色 |
| `borderRadius` | `double` | `12.0` | 圆角半径 |
| `padding` | `EdgeInsets` | `EdgeInsets.all(20.0)` | 内边距 |
| `margin` | `EdgeInsets` | `EdgeInsets.all(20.0)` | 外边距 |
| `animationDuration` | `Duration` | `Duration(milliseconds: 300)` | 动画持续时间 |
| `showShadow` | `bool` | `true` | 是否显示阴影 |
| `shadowColor` | `Color?` | `null` | 阴影颜色 |
| `shadowBlurRadius` | `double` | `10.0` | 阴影模糊半径 |
| `shadowOffset` | `Offset` | `Offset(0, 4)` | 阴影偏移 |
| `showBorder` | `bool` | `false` | 是否显示边框 |
| `borderColor` | `Color?` | `null` | 边框颜色 |
| `borderWidth` | `double` | `1.0` | 边框宽度 |
| `barrierColor` | `Color?` | `null` | 背景遮罩颜色 |
| `barrierOpacity` | `double` | `0.5` | 背景遮罩透明度 |

## 预设弹窗类型

### 1. 确认对话框

```dart
CenterDialogUtils.showConfirmDialog(
  context: context,
  title: '确认操作',
  content: '您确定要执行此操作吗？',
  confirmText: '确认',
  cancelText: '取消',
  confirmColor: Colors.red,
  cancelColor: Colors.grey,
  onConfirm: () {
    // 确认操作
  },
  onCancel: () {
    // 取消操作
  },
);
```

### 2. 警告对话框

```dart
CenterDialogUtils.showWarningDialog(
  context: context,
  title: '警告',
  content: '您的操作可能会影响系统稳定性。',
  confirmText: '我知道了',
  confirmColor: Colors.orange,
  onConfirm: () {
    // 确认回调
  },
);
```

### 3. 成功对话框

```dart
CenterDialogUtils.showSuccessDialog(
  context: context,
  title: '操作成功',
  content: '您的操作已成功完成！',
  confirmText: '好的',
  confirmColor: Colors.green,
  onConfirm: () {
    // 确认回调
  },
);
```

### 4. 错误对话框

```dart
CenterDialogUtils.showErrorDialog(
  context: context,
  title: '操作失败',
  content: '抱歉，操作失败。请重试。',
  confirmText: '重试',
  confirmColor: Colors.red,
  onConfirm: () {
    // 确认回调
  },
);
```

### 5. 输入对话框

```dart
CenterDialogUtils.showInputDialog(
  context: context,
  title: '请输入信息',
  hintText: '请输入您的姓名',
  initialValue: '默认值',
  confirmText: '确认',
  cancelText: '取消',
  onConfirm: () {
    // 确认回调
  },
  onCancel: () {
    // 取消回调
  },
).then((result) {
  if (result != null) {
    print('用户输入：$result');
  }
});
```

### 6. 加载对话框

```dart
CenterDialogUtils.showLoadingDialog(
  context: context,
  message: '正在加载...',
);

// 关闭加载对话框
Navigator.of(context).pop();
```

### 7. 自定义弹窗

```dart
CenterDialogUtils.showCustom(
  context: context,
  config: const CenterDialogConfig(
    width: 0.9,
    height: 0.5,
    borderRadius: 20,
    showShadow: true,
    showBorder: true,
    borderColor: Colors.blue,
    borderWidth: 2,
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.star, size: 64, color: Colors.amber),
      const SizedBox(height: 16),
      const Text('自定义内容'),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('关闭'),
      ),
    ],
  ),
);
```

## 高级用法

### 1. 自定义配置

```dart
const customConfig = CenterDialogConfig(
  width: 0.9,
  height: 0.6,
  borderRadius: 20,
  padding: EdgeInsets.all(24),
  showShadow: true,
  showBorder: true,
  borderColor: Colors.blue,
  borderWidth: 2,
  barrierColor: Colors.black,
  barrierOpacity: 0.7,
);

CenterDialogUtils.showCustom(
  context: context,
  config: customConfig,
  child: YourCustomWidget(),
);
```

### 2. 监听弹窗事件

```dart
CenterDialogWidget.show(
  context: context,
  child: YourWidget(),
  onShow: () {
    print('弹窗已显示');
  },
  onClose: () {
    print('弹窗已关闭');
  },
);
```

### 3. 链式调用

```dart
// 先显示确认对话框
CenterDialogUtils.showConfirmDialog(
  context: context,
  title: '确认删除',
  content: '删除后无法恢复，确定要删除吗？',
).then((confirmed) {
  if (confirmed == true) {
    // 显示加载对话框
    CenterDialogUtils.showLoadingDialog(
      context: context,
      message: '正在删除...',
    );
    
    // 模拟删除操作
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // 关闭加载对话框
      
      // 显示成功对话框
      CenterDialogUtils.showSuccessDialog(
        context: context,
        title: '删除成功',
        content: '数据已成功删除',
      );
    });
  }
});
```

## 最佳实践

### 1. 合理使用弹窗类型

- **确认对话框**：用于重要操作的二次确认
- **警告对话框**：用于提醒用户潜在风险
- **成功/错误对话框**：用于反馈操作结果
- **输入对话框**：用于收集用户输入
- **加载对话框**：用于长时间操作的用户反馈

### 2. 文案设计

- 标题简洁明了，不超过10个字
- 内容描述清晰，避免歧义
- 按钮文字具有明确的动作含义

### 3. 样式统一

```dart
// 定义全局配置
const globalDialogConfig = CenterDialogConfig(
  borderRadius: 16,
  padding: EdgeInsets.all(20),
  showShadow: true,
);

// 在所有弹窗中使用
CenterDialogUtils.showConfirmDialog(
  context: context,
  config: globalDialogConfig,
  // ... 其他参数
);
```

### 4. 错误处理

```dart
try {
  await CenterDialogUtils.showInputDialog(
    context: context,
    title: '请输入',
    hintText: '请输入内容',
  );
} catch (e) {
  // 处理异常
  CenterDialogUtils.showErrorDialog(
    context: context,
    title: '错误',
    content: '操作失败：$e',
  );
}
```

## 注意事项

1. **内存管理**：长时间显示的加载对话框要及时关闭
2. **用户体验**：避免频繁弹出弹窗，影响用户操作
3. **无障碍访问**：确保弹窗内容对屏幕阅读器友好
4. **性能优化**：复杂自定义弹窗建议使用 `const` 构造函数

## 示例项目

查看 `center_dialog_example.dart` 文件获取完整的使用示例。
