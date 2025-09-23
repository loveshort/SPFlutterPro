# DashedLine 虚线组件

一个功能强大且高度可定制的Flutter虚线组件，支持水平和垂直方向的虚线绘制。

## 📋 目录

- [特性](#特性)
- [安装](#安装)
- [基础用法](#基础用法)
- [API文档](#api文档)
- [使用示例](#使用示例)
- [高级用法](#高级用法)
- [注意事项](#注意事项)

## ✨ 特性

- 🎨 **高度可定制** - 支持自定义颜色、粗细、虚线长度、间距等
- 📐 **多方向支持** - 支持水平和垂直方向的虚线绘制
- 🚀 **性能优化** - 使用CustomPaint实现，性能优异
- 🎯 **简单易用** - 提供简洁的API，开箱即用
- 📱 **响应式** - 支持自适应宽度和高度

## 📦 安装

将 `dashed_line.dart` 文件复制到您的项目中：

```bash
lib/widgets/dashed_line/
├── dashed_line.dart          # 主组件文件
├── dashed_line_example.dart  # 使用示例
└── README.md                 # 文档
```

## 🚀 基础用法

### 导入组件

```dart
import 'package:your_project/widgets/dashed_line/dashed_line.dart';
```

### 最简单的使用

```dart
// 默认水平虚线
DashedLine()
```

### 自定义样式

```dart
DashedLine(
  color: Colors.red,
  strokeWidth: 2.0,
  dashWidth: 10.0,
  dashSpace: 5.0,
)
```

### 垂直虚线

```dart
DashedLine(
  direction: Axis.vertical,
  height: 100,
  color: Colors.blue,
)
```

## 📚 API文档

### DashedLine 构造函数

```dart
const DashedLine({
  Key? key,
  Color color = Colors.grey,           // 虚线颜色
  double strokeWidth = 1.0,            // 线条粗细
  double dashWidth = 5.0,              // 虚线长度
  double dashSpace = 3.0,              // 虚线间距
  Axis direction = Axis.horizontal,    // 方向：水平或垂直
  double? width,                       // 宽度（仅水平方向有效）
  double? height,                      // 高度（仅垂直方向有效）
})
```

### 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `color` | `Color` | `Colors.grey` | 虚线的颜色 |
| `strokeWidth` | `double` | `1.0` | 线条的粗细 |
| `dashWidth` | `double` | `5.0` | 每个虚线段的长度 |
| `dashSpace` | `double` | `3.0` | 虚线之间的间距 |
| `direction` | `Axis` | `Axis.horizontal` | 虚线方向：`Axis.horizontal`（水平）或 `Axis.vertical`（垂直） |
| `width` | `double?` | `null` | 水平虚线的宽度，为null时自适应父容器 |
| `height` | `double?` | `null` | 垂直虚线的高度，为null时自适应父容器 |

## 💡 使用示例

### 1. 基础水平虚线

```dart
DashedLine()
```

### 2. 自定义颜色和粗细

```dart
DashedLine(
  color: Colors.red,
  strokeWidth: 2.0,
)
```

### 3. 自定义虚线长度和间距

```dart
DashedLine(
  color: Colors.green,
  dashWidth: 10.0,
  dashSpace: 5.0,
)
```

### 4. 垂直虚线

```dart
DashedLine(
  direction: Axis.vertical,
  height: 100,
  color: Colors.blue,
)
```

### 5. 在容器中使用

```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Column(
    children: [
      Text('这是容器内容'),
      SizedBox(height: 16),
      DashedLine(
        color: Colors.grey,
        dashWidth: 6.0,
        dashSpace: 3.0,
      ),
      SizedBox(height: 16),
      Text('虚线分隔'),
    ],
  ),
)
```

### 6. 不同宽度的水平虚线

```dart
Column(
  children: [
    DashedLine(
      width: 200,
      color: Colors.teal,
    ),
    SizedBox(height: 8),
    DashedLine(
      width: 150,
      color: Colors.indigo,
      strokeWidth: 2.0,
    ),
    SizedBox(height: 8),
    DashedLine(
      width: 100,
      color: Colors.pink,
      strokeWidth: 3.0,
      dashWidth: 8.0,
      dashSpace: 2.0,
    ),
  ],
)
```

## 🔧 高级用法

### 创建虚线边框

```dart
Container(
  width: 200,
  height: 100,
  child: Stack(
    children: [
      // 顶部虚线
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: DashedLine(color: Colors.blue),
      ),
      // 底部虚线
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: DashedLine(color: Colors.blue),
      ),
      // 左侧虚线
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        child: DashedLine(
          direction: Axis.vertical,
          color: Colors.blue,
        ),
      ),
      // 右侧虚线
      Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        child: DashedLine(
          direction: Axis.vertical,
          color: Colors.blue,
        ),
      ),
    ],
  ),
)
```

### 创建虚线网格

```dart
Container(
  width: 300,
  height: 200,
  child: Stack(
    children: [
      // 水平虚线
      ...List.generate(4, (index) => 
        Positioned(
          top: (index + 1) * 40.0,
          left: 0,
          right: 0,
          child: DashedLine(color: Colors.grey.shade400),
        ),
      ),
      // 垂直虚线
      ...List.generate(6, (index) => 
        Positioned(
          left: (index + 1) * 50.0,
          top: 0,
          bottom: 0,
          child: DashedLine(
            direction: Axis.vertical,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    ],
  ),
)
```

## ⚠️ 注意事项

1. **性能考虑**：组件使用CustomPaint绘制，对于大量虚线建议合理使用
2. **尺寸限制**：当width或height为null时，组件会尝试自适应父容器
3. **方向参数**：direction参数影响width和height参数的有效性
4. **数值范围**：建议strokeWidth、dashWidth、dashSpace使用合理的数值范围

## 🎨 样式建议

### 常用样式组合

```dart
// 细虚线 - 适合分隔内容
DashedLine(
  strokeWidth: 0.5,
  dashWidth: 3.0,
  dashSpace: 2.0,
  color: Colors.grey.shade300,
)

// 粗虚线 - 适合强调分隔
DashedLine(
  strokeWidth: 2.0,
  dashWidth: 8.0,
  dashSpace: 4.0,
  color: Colors.blue,
)

// 密集虚线 - 适合边框效果
DashedLine(
  strokeWidth: 1.0,
  dashWidth: 2.0,
  dashSpace: 1.0,
  color: Colors.grey.shade400,
)
```

## 📄 许可证

MIT License

## 👨‍💻 作者

- **mingci** - gu271901088@gmail.com

## 📝 更新日志

### v1.0.0 (2025-09-22)
- ✨ 初始版本发布
- 🎨 支持水平和垂直虚线绘制
- 🔧 提供丰富的自定义选项
- 📚 完整的文档和示例
