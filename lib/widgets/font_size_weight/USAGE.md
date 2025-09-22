# 字体粗细统一管理器 - 快速使用指南

## 问题背景

在Flutter开发中，Android和iOS平台的字体粗细显示不一致：
- **Android**: 字体看起来比iOS细
- **iOS**: 字体显示正常
- **影响**: 同一份代码在不同平台视觉效果不统一

## 解决方案

`FontWeightManager` 自动根据平台调整字体粗细，确保跨平台一致性。

## 快速开始

### 1. 导入

```dart
import 'font_weight_manager.dart';
```

### 2. 使用预定义常量（推荐）

```dart
Text(
  '标题',
  style: TextStyle(
    fontWeight: FontWeightManager.bold,  // 自动适配平台
  ),
)
```

### 3. 常用场景

#### 标题文字
```dart
Text(
  '页面标题',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeightManager.bold,
  ),
)
```

#### 正文内容
```dart
Text(
  '这是正文内容...',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.normal,
  ),
)
```

#### 按钮文字
```dart
ElevatedButton(
  onPressed: () {},
  child: Text(
    '确认',
    style: TextStyle(
      fontWeight: FontWeightManager.medium,
    ),
  ),
)
```

## 可用的字体粗细

| 常量 | 描述 | 使用场景 |
|------|------|----------|
| `ultraLight` | 超细 | 装饰性文字 |
| `extraLight` | 极细 | 辅助信息 |
| `light` | 细 | 次要文字 |
| `normal` | 正常 | 正文内容 |
| `medium` | 中等 | 按钮、标签 |
| `semiBold` | 半粗 | 小标题 |
| `bold` | 粗 | 主标题 |
| `extraBold` | 超粗 | 重要标题 |
| `ultraBold` | 极粗 | 特殊强调 |

## 平台适配原理

| 原始粗细 | Android调整后 | iOS保持 | 效果 |
|----------|---------------|---------|------|
| w400 | w500 | w400 | 正常 |
| w500 | w600 | w500 | 中等 |
| w700 | w800 | w700 | 粗体 |

## 扩展方法

### TextStyle扩展
```dart
Text(
  '使用扩展方法',
  style: TextStyle(fontSize: 16).unifiedFontWeight(FontWeight.w600),
)
```

### Text扩展
```dart
TextExtension.unified(
  '使用Text.unified',
  fontWeight: FontWeight.w700,
  fontSize: 16,
)
```

## 最佳实践

1. **优先使用预定义常量**
   ```dart
   // ✅ 推荐
   FontWeightManager.bold
   
   // ❌ 不推荐
   FontWeightManager.getUnifiedFontWeight(FontWeight.w700)
   ```

2. **保持一致性**
   - 在整个应用中使用统一的字体粗细管理
   - 避免混用原始FontWeight和统一FontWeight

3. **语义化命名**
   - 使用有意义的常量名
   - 避免使用具体的数值

## 完整示例

查看 `font_weight_example.dart` 获取完整的使用示例。

## 注意事项

- 目前主要支持Android和iOS平台
- 其他平台会保持原始字体粗细
- 可以与现有代码共存，逐步迁移
