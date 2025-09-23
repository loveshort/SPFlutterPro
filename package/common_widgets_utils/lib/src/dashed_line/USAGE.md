# DashedLine 使用指南

## 🚀 快速开始

### 1. 导入组件

```dart
import 'package:your_project/widgets/dashed_line/dashed_line.dart';
```

### 2. 基础使用

```dart
// 最简单的虚线
DashedLine()
```

## 📝 常用场景

### 分隔内容

```dart
Column(
  children: [
    Text('第一部分内容'),
    DashedLine(), // 分隔线
    Text('第二部分内容'),
  ],
)
```

### 表单分隔

```dart
Column(
  children: [
    TextFormField(decoration: InputDecoration(labelText: '用户名')),
    SizedBox(height: 16),
    DashedLine(color: Colors.grey.shade300),
    SizedBox(height: 16),
    TextFormField(decoration: InputDecoration(labelText: '密码')),
  ],
)
```

### 卡片分隔

```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text('标题'),
        SizedBox(height: 8),
        DashedLine(color: Colors.blue),
        SizedBox(height: 8),
        Text('内容'),
      ],
    ),
  ),
)
```

### 垂直分隔

```dart
Row(
  children: [
    Expanded(child: Text('左侧内容')),
    DashedLine(
      direction: Axis.vertical,
      height: 50,
      color: Colors.grey,
    ),
    SizedBox(width: 16),
    Expanded(child: Text('右侧内容')),
  ],
)
```

## 🎨 样式定制

### 颜色主题

```dart
// 主色调
DashedLine(color: Colors.blue)

// 次要色调
DashedLine(color: Colors.grey.shade400)

// 强调色
DashedLine(color: Colors.red)
```

### 粗细调整

```dart
// 细线
DashedLine(strokeWidth: 0.5)

// 标准线
DashedLine(strokeWidth: 1.0)

// 粗线
DashedLine(strokeWidth: 2.0)
```

### 虚线样式

```dart
// 短虚线
DashedLine(dashWidth: 3.0, dashSpace: 2.0)

// 长虚线
DashedLine(dashWidth: 10.0, dashSpace: 5.0)

// 密集虚线
DashedLine(dashWidth: 2.0, dashSpace: 1.0)
```

## 🔧 高级用法

### 响应式宽度

```dart
// 自适应父容器宽度
Container(
  width: 200,
  child: DashedLine(),
)

// 固定宽度
DashedLine(width: 150)
```

### 动态样式

```dart
class DynamicDashedLine extends StatefulWidget {
  @override
  _DynamicDashedLineState createState() => _DynamicDashedLineState();
}

class _DynamicDashedLineState extends State<DynamicDashedLine> {
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isHighlighted = !isHighlighted;
        });
      },
      child: DashedLine(
        color: isHighlighted ? Colors.red : Colors.grey,
        strokeWidth: isHighlighted ? 2.0 : 1.0,
      ),
    );
  }
}
```

## 💡 最佳实践

### 1. 选择合适的颜色

```dart
// ✅ 推荐：使用主题色
DashedLine(color: Theme.of(context).dividerColor)

// ✅ 推荐：使用语义化颜色
DashedLine(color: Colors.grey.shade300)

// ❌ 避免：过于鲜艳的颜色
DashedLine(color: Colors.yellow)
```

### 2. 合理的间距

```dart
// ✅ 推荐：保持一致的间距
Column(
  children: [
    Text('内容1'),
    SizedBox(height: 16),
    DashedLine(),
    SizedBox(height: 16),
    Text('内容2'),
  ],
)
```

### 3. 性能考虑

```dart
// ✅ 推荐：合理使用
DashedLine()

// ❌ 避免：在ListView中大量使用
ListView.builder(
  itemBuilder: (context, index) => DashedLine(), // 不推荐
)
```

## 🐛 常见问题

### Q: 虚线不显示？

A: 检查以下几点：
- 确保父容器有足够的空间
- 检查颜色是否与背景色相同
- 确认strokeWidth大于0

### Q: 虚线太密集或太稀疏？

A: 调整dashWidth和dashSpace参数：
```dart
// 更密集
DashedLine(dashWidth: 2.0, dashSpace: 1.0)

// 更稀疏
DashedLine(dashWidth: 10.0, dashSpace: 8.0)
```

### Q: 垂直虚线高度不正确？

A: 确保设置了height参数或父容器有明确的高度：
```dart
// 明确设置高度
DashedLine(direction: Axis.vertical, height: 100)

// 或在有高度的容器中
Container(
  height: 100,
  child: DashedLine(direction: Axis.vertical),
)
```

## 📚 更多资源

- [完整API文档](README.md)
- [使用示例](dashed_line_example.dart)
- [Flutter CustomPaint文档](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html)
