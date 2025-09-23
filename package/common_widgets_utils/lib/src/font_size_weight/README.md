# 字体粗细统一管理器 (FontWeightManager)

## 问题描述

在Flutter开发中，Android和iOS平台上的字体粗细（FontWeight）显示存在差异：
- **Android平台**：字体看起来比iOS平台要细一些
- **iOS平台**：字体显示正常
- **问题影响**：同一份代码在不同平台上视觉效果不一致

## 解决方案

`FontWeightManager` 提供了一个统一的字体粗细管理方案，自动根据平台调整字体粗细，确保在不同平台上有一致的视觉效果。

### 核心特性

- ✅ **自动平台检测**：自动识别Android和iOS平台
- ✅ **智能粗细调整**：Android平台自动增加一个级别的字体粗细
- ✅ **预定义常量**：提供常用的统一字体粗细常量
- ✅ **扩展方法**：为TextStyle和Text提供便捷的扩展方法
- ✅ **零配置使用**：导入即可使用，无需额外配置

## 安装使用

### 1. 导入依赖

```dart
import 'package:flutter/material.dart';
import 'font_weight_manager.dart';
```

### 2. 基本使用

#### 方法一：使用预定义常量（推荐）

```dart
Text(
  '标题文字',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
  ),
)
```

#### 方法二：使用统一方法

```dart
Text(
  '正文内容',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.getUnifiedFontWeight(FontWeight.w400),
  ),
)
```

#### 方法三：使用扩展方法

```dart
// TextStyle扩展方法
Text(
  '使用扩展方法',
  style: TextStyle(fontSize: 16).unifiedFontWeight(FontWeight.w600),
)

// Text扩展方法
TextExtension.unified(
  '使用Text.unified',
  fontWeight: FontWeight.w700,
  fontSize: 16,
)
```

## API 参考

### FontWeightManager 类

#### 静态方法

| 方法 | 描述 | 参数 | 返回值 |
|------|------|------|--------|
| `getUnifiedFontWeight(FontWeight weight)` | 获取统一的字体粗细 | `FontWeight` | `FontWeight` |
| `platformInfo` | 获取当前平台信息 | - | `String` |
| `isAndroid` | 检查是否为Android平台 | - | `bool` |
| `isIOS` | 检查是否为iOS平台 | - | `bool` |

#### 预定义常量

| 常量 | 描述 | Android实际值 | iOS实际值 |
|------|------|---------------|-----------|
| `ultraLight` | 超细字体 | w200 | w100 |
| `extraLight` | 极细字体 | w300 | w200 |
| `light` | 细字体 | w400 | w300 |
| `normal` | 正常字体 | w500 | w400 |
| `medium` | 中等字体 | w600 | w500 |
| `semiBold` | 半粗字体 | w700 | w600 |
| `bold` | 粗字体 | w800 | w700 |
| `extraBold` | 超粗字体 | w900 | w800 |
| `ultraBold` | 极粗字体 | w900 | w900 |

### 扩展方法

#### TextStyleExtension

```dart
TextStyle.unifiedFontWeight(FontWeight weight)
```

为TextStyle添加统一的字体粗细设置。

#### TextExtension

```dart
TextExtension.unified(String data, {FontWeight? fontWeight, ...})
```

创建使用统一字体粗细的Text组件。

## 字体粗细映射表

| 原始粗细 | Android调整后 | iOS保持 | 视觉效果 |
|----------|---------------|---------|----------|
| w100 | w200 | w100 | 超细 |
| w200 | w300 | w200 | 极细 |
| w300 | w400 | w300 | 细 |
| w400 | w500 | w400 | 正常 |
| w500 | w600 | w500 | 中等 |
| w600 | w700 | w600 | 半粗 |
| w700 | w800 | w700 | 粗 |
| w800 | w900 | w800 | 超粗 |
| w900 | w900 | w900 | 极粗 |

## 使用示例

### 1. 标题和正文

```dart
Column(
  children: [
    // 主标题
    Text(
      '文章标题',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeightManager.bold,
      ),
    ),
    
    // 副标题
    Text(
      '副标题',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeightManager.semiBold,
      ),
    ),
    
    // 正文
    Text(
      '这是正文内容...',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeightManager.normal,
      ),
    ),
  ],
)
```

### 2. 按钮文字

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

### 3. 列表项

```dart
ListTile(
  title: Text(
    '列表项标题',
    style: TextStyle(
      fontWeight: FontWeightManager.medium,
    ),
  ),
  subtitle: Text(
    '列表项描述',
    style: TextStyle(
      fontWeight: FontWeightManager.normal,
    ),
  ),
)
```

## 最佳实践

### 1. 优先使用预定义常量

```dart
// ✅ 推荐
Text('标题', style: TextStyle(fontWeight: FontWeightManager.bold))

// ❌ 不推荐
Text('标题', style: TextStyle(fontWeight: FontWeightManager.getUnifiedFontWeight(FontWeight.w700)))
```

### 2. 保持一致性

在整个应用中使用统一的字体粗细管理，避免混用原始FontWeight和统一FontWeight。

### 3. 语义化命名

使用语义化的常量名称，而不是具体的数值：

```dart
// ✅ 推荐
FontWeightManager.bold

// ❌ 不推荐
FontWeightManager.getUnifiedFontWeight(FontWeight.w700)
```

## 注意事项

1. **平台兼容性**：目前主要针对Android和iOS平台，其他平台会保持原始字体粗细
2. **性能影响**：平台检测在编译时完成，运行时无额外性能开销
3. **向后兼容**：可以与现有的FontWeight代码共存，逐步迁移

## 完整示例

查看 `font_weight_example.dart` 文件获取完整的使用示例，包括：
- 平台信息显示
- 预定义常量演示
- 扩展方法使用
- 对比示例
- 实际应用场景

## 更新日志

### v1.0.0
- 初始版本发布
- 支持Android和iOS平台字体粗细统一
- 提供预定义常量和扩展方法
- 完整的文档和示例
