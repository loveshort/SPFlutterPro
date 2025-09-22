# 颜色工具封装

一个功能丰富的Flutter颜色管理工具，提供统一的颜色定义、颜色转换、计算、生成和分析功能。

## 功能特性

- 🎨 **统一颜色管理** - 提供完整的颜色定义体系
- 🌓 **主题支持** - 支持明暗主题切换
- 🔄 **颜色转换** - 支持多种颜色格式转换
- 🧮 **颜色计算** - 提供颜色混合、调整等计算功能
- 🎲 **颜色生成** - 支持随机颜色和调色板生成
- 📊 **颜色分析** - 提供颜色分析和对比度检查
- 🎯 **语义化颜色** - 提供成功、警告、错误等语义化颜色
- 🌈 **渐变色** - 内置多种精美渐变色

## 文件结构

```
lib/widgets/mc_color/
├── color_manager.dart      # 颜色管理器 - 统一颜色定义
├── color_utils.dart        # 颜色工具类 - 颜色操作和计算
├── color_example.dart      # 使用示例
└── README.md              # 使用文档
```

## 快速开始

### 1. 导入颜色工具

```dart
import 'package:your_project/widgets/mc_color/color_manager.dart';
import 'package:your_project/widgets/mc_color/color_utils.dart';
```

### 2. 基础使用

```dart
// 使用预定义颜色
Container(
  color: ColorManager.primary,
  child: Text('主色调'),
)

// 使用语义化颜色
Container(
  color: ColorManager.success,
  child: Text('成功状态'),
)

// 使用渐变色
Container(
  decoration: BoxDecoration(
    gradient: ColorManager.primaryGradient,
  ),
  child: Text('渐变背景'),
)
```

### 3. 主题切换

```dart
// 设置主题模式
ColorManager.setDarkMode(true);

// 根据主题获取颜色
Container(
  color: ColorManager.getBackgroundColor(),
  child: Text(
    '自适应背景',
    style: TextStyle(
      color: ColorManager.getTextPrimaryColor(),
    ),
  ),
)
```

## 详细使用指南

### ColorManager - 颜色管理器

#### 主题颜色

```dart
// 主色调
ColorManager.primary        // 主色
ColorManager.primaryLight   // 浅主色
ColorManager.primaryDark    // 深主色

// 辅助色
ColorManager.secondary      // 辅助色
ColorManager.secondaryLight // 浅辅助色
ColorManager.secondaryDark  // 深辅助色

// 强调色
ColorManager.accent         // 强调色
ColorManager.accentLight    // 浅强调色
ColorManager.accentDark     // 深强调色
```

#### 语义化颜色

```dart
// 状态颜色
ColorManager.success        // 成功色
ColorManager.warning        // 警告色
ColorManager.error          // 错误色
ColorManager.info           // 信息色

// 带透明度的语义化颜色
ColorManager.successWithOpacity(0.5)  // 50%透明度的成功色
ColorManager.warningWithOpacity(0.3)  // 30%透明度的警告色
```

#### 中性色

```dart
// 白色系
ColorManager.white          // 纯白
ColorManager.whiteSmoke     // 烟白色
ColorManager.ghostWhite     // 幽灵白
ColorManager.snow           // 雪白色

// 黑色系
ColorManager.black          // 纯黑
ColorManager.charcoal       // 炭黑色
ColorManager.darkGray       // 深灰色
ColorManager.dimGray        // 暗灰色

// 灰色系
ColorManager.lightGray      // 浅灰色
ColorManager.silver         // 银色
ColorManager.gray           // 灰色
ColorManager.darkSlateGray  // 深石板灰
```

#### 背景和文本颜色

```dart
// 背景色
ColorManager.background     // 背景色
ColorManager.surface         // 表面色
ColorManager.cardBackground // 卡片背景色

// 文本颜色
ColorManager.textPrimary    // 主要文本色
ColorManager.textSecondary  // 次要文本色
ColorManager.textDisabled   // 禁用文本色
ColorManager.textHint        // 提示文本色

// 边框和分割线
ColorManager.border         // 边框色
ColorManager.divider        // 分割线色
```

#### 渐变色

```dart
// 预定义渐变
ColorManager.primaryGradient  // 主色调渐变
ColorManager.rainbowGradient  // 彩虹渐变
ColorManager.sunsetGradient   // 日落渐变
ColorManager.oceanGradient    // 海洋渐变

// 使用渐变
Container(
  decoration: BoxDecoration(
    gradient: ColorManager.primaryGradient,
  ),
  child: Text('渐变背景'),
)
```

#### 主题相关方法

```dart
// 设置主题模式
ColorManager.setDarkMode(true);

// 获取当前主题模式
bool isDark = ColorManager.isDarkMode;

// 根据主题获取颜色
Color bgColor = ColorManager.getBackgroundColor();
Color textColor = ColorManager.getTextPrimaryColor();
Color borderColor = ColorManager.getBorderColor();
```

### ColorUtils - 颜色工具类

#### 颜色转换

```dart
// 十六进制转Color
Color color = ColorUtils.hexToColor('#FF5722');
Color colorWithAlpha = ColorUtils.hexToColor('#FF5722', alpha: 0.5);

// Color转十六进制
String hex = ColorUtils.colorToHex(ColorManager.primary);
String hexWithAlpha = ColorUtils.colorToHex(ColorManager.primary, includeAlpha: true);

// RGB转Color
Color rgbColor = ColorUtils.rgbToColor(255, 87, 34);

// HSL转Color
Color hslColor = ColorUtils.hslToColor(14, 100, 57); // 色相, 饱和度, 亮度

// HSV转Color
Color hsvColor = ColorUtils.hsvToColor(14, 87, 100); // 色相, 饱和度, 明度
```

#### 颜色计算

```dart
// 混合两个颜色
Color blended = ColorUtils.blendColors(
  ColorManager.primary,
  ColorManager.secondary,
  0.5, // 50%混合比例
);

// 调整亮度
Color brighter = ColorUtils.adjustBrightness(ColorManager.primary, 0.2);
Color darker = ColorUtils.adjustBrightness(ColorManager.primary, -0.2);

// 调整饱和度
Color moreSaturated = ColorUtils.adjustSaturation(ColorManager.primary, 0.3);
Color lessSaturated = ColorUtils.adjustSaturation(ColorManager.primary, -0.3);

// 调整色相
Color shiftedHue = ColorUtils.adjustHue(ColorManager.primary, 30);

// 反转颜色
Color inverted = ColorUtils.invertColor(ColorManager.primary);

// 获取补色
Color complementary = ColorUtils.getComplementaryColor(ColorManager.primary);
```

#### 颜色关系

```dart
// 获取三元色
List<Color> triadic = ColorUtils.getTriadicColors(ColorManager.primary);

// 获取类似色
List<Color> analogous = ColorUtils.getAnalogousColors(ColorManager.primary, count: 5);

// 生成调色板
List<Color> palette = ColorUtils.generatePalette(ColorManager.primary, count: 5);

// 生成单色调色板
List<Color> monochromatic = ColorUtils.generateMonochromaticPalette(ColorManager.primary, count: 5);
```

#### 颜色生成

```dart
// 生成随机颜色
Color randomColor = ColorUtils.generateRandomColor();
Color randomBrightColor = ColorUtils.generateRandomBrightColor();
Color randomSoftColor = ColorUtils.generateRandomSoftColor();
```

#### 颜色分析

```dart
// 计算亮度
double luminance = ColorUtils.getLuminance(ColorManager.primary);

// 判断颜色类型
bool isDark = ColorUtils.isDarkColor(ColorManager.primary);
bool isLight = ColorUtils.isLightColor(ColorManager.primary);

// 计算对比度
double contrast = ColorUtils.getContrastRatio(ColorManager.primary, ColorManager.white);

// 检查WCAG对比度标准
bool meetsAA = ColorUtils.meetsContrastRatio(ColorManager.primary, ColorManager.white, ratio: 4.5);
bool meetsAAA = ColorUtils.meetsContrastRatio(ColorManager.primary, ColorManager.white, ratio: 7.0);

// 获取适合的文本颜色
Color textColor = ColorUtils.getTextColorForBackground(ColorManager.primary);

// 获取颜色信息
String colorInfo = ColorUtils.formatColorInfo(ColorManager.primary);

// 获取颜色名称
String colorName = ColorUtils.getColorName(ColorManager.primary);
```

#### 颜色格式转换

```dart
// Color转HSV
Map<String, double> hsv = ColorUtils.colorToHsv(ColorManager.primary);
// 返回: {'h': 210.0, 's': 1.0, 'v': 0.95}

// Color转HSL
Map<String, double> hsl = ColorUtils.colorToHsl(ColorManager.primary);
// 返回: {'h': 210.0, 's': 1.0, 'l': 0.47}
```

## 实际应用示例

### 1. 创建主题切换功能

```dart
class ThemeToggleWidget extends StatefulWidget {
  @override
  _ThemeToggleWidgetState createState() => _ThemeToggleWidgetState();
}

class _ThemeToggleWidgetState extends State<ThemeToggleWidget> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.getBackgroundColor(),
      appBar: AppBar(
        backgroundColor: ColorManager.getSurfaceColor(),
        foregroundColor: ColorManager.getTextPrimaryColor(),
        title: Text('主题切换'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
                ColorManager.setDarkMode(_isDarkMode);
              });
            },
          ),
        ],
      ),
      body: Container(
        color: ColorManager.getCardBackgroundColor(),
        child: Text(
          '自适应文本颜色',
          style: TextStyle(
            color: ColorManager.getTextPrimaryColor(),
          ),
        ),
      ),
    );
  }
}
```

### 2. 创建状态指示器

```dart
class StatusIndicator extends StatelessWidget {
  final String status;
  
  const StatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    
    switch (status.toLowerCase()) {
      case 'success':
        statusColor = ColorManager.success;
        statusIcon = Icons.check_circle;
        break;
      case 'warning':
        statusColor = ColorManager.warning;
        statusIcon = Icons.warning;
        break;
      case 'error':
        statusColor = ColorManager.error;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = ColorManager.info;
        statusIcon = Icons.info;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ColorUtils.successWithOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 16),
          SizedBox(width: 4),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3. 创建颜色选择器

```dart
class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color _selectedColor = ColorManager.primary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 显示当前选择的颜色
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _selectedColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorManager.getBorderColor()),
          ),
          child: Center(
            child: Text(
              ColorUtils.colorToHex(_selectedColor),
              style: TextStyle(
                color: ColorUtils.getTextColorForBackground(_selectedColor),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 16),
        
        // 颜色信息
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorManager.getSurfaceColor(),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorManager.getBorderColor()),
          ),
          child: Text(
            ColorUtils.formatColorInfo(_selectedColor),
            style: TextStyle(
              color: ColorManager.getTextPrimaryColor(),
              fontFamily: 'monospace',
            ),
          ),
        ),
        
        SizedBox(height: 16),
        
        // 颜色生成按钮
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor = ColorUtils.generateRandomColor();
                });
              },
              child: Text('随机颜色'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor = ColorUtils.generateRandomBrightColor();
                });
              },
              child: Text('明亮颜色'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor = ColorUtils.generateRandomSoftColor();
                });
              },
              child: Text('柔和颜色'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedColor = ColorUtils.getComplementaryColor(_selectedColor);
                });
              },
              child: Text('补色'),
            ),
          ],
        ),
      ],
    );
  }
}
```

### 4. 创建渐变色背景

```dart
class GradientBackground extends StatelessWidget {
  final Widget child;
  final LinearGradient gradient;
  
  const GradientBackground({
    required this.child,
    this.gradient = ColorManager.primaryGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: child,
    );
  }
}

// 使用示例
GradientBackground(
  gradient: ColorManager.sunsetGradient,
  child: Center(
    child: Text(
      '日落渐变背景',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
)
```

### 5. 创建颜色对比度检查器

```dart
class ContrastChecker extends StatefulWidget {
  @override
  _ContrastCheckerState createState() => _ContrastCheckerState();
}

class _ContrastCheckerState extends State<ContrastChecker> {
  Color _foregroundColor = ColorManager.black;
  Color _backgroundColor = ColorManager.white;

  @override
  Widget build(BuildContext context) {
    final contrastRatio = ColorUtils.getContrastRatio(_foregroundColor, _backgroundColor);
    final meetsAA = ColorUtils.meetsContrastRatio(_foregroundColor, _backgroundColor, ratio: 4.5);
    final meetsAAA = ColorUtils.meetsContrastRatio(_foregroundColor, _backgroundColor, ratio: 7.0);
    
    return Column(
      children: [
        // 颜色预览
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorManager.getBorderColor()),
          ),
          child: Center(
            child: Text(
              '示例文本',
              style: TextStyle(
                color: _foregroundColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        
        SizedBox(height: 16),
        
        // 对比度信息
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorManager.getCardBackgroundColor(),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorManager.getBorderColor()),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '对比度分析',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.getTextPrimaryColor(),
                ),
              ),
              SizedBox(height: 12),
              _buildInfoRow('对比度比例', '${contrastRatio.toStringAsFixed(2)}:1'),
              _buildInfoRow('WCAG AA', meetsAA ? '✅ 通过' : '❌ 未通过'),
              _buildInfoRow('WCAG AAA', meetsAAA ? '✅ 通过' : '❌ 未通过'),
              _buildInfoRow('前景色', ColorUtils.colorToHex(_foregroundColor)),
              _buildInfoRow('背景色', ColorUtils.colorToHex(_backgroundColor)),
            ],
          ),
        ),
        
        SizedBox(height: 16),
        
        // 颜色选择按钮
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _foregroundColor = ColorUtils.generateRandomColor();
                  });
                },
                child: Text('随机前景色'),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _backgroundColor = ColorUtils.generateRandomColor();
                  });
                },
                child: Text('随机背景色'),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: ColorManager.getTextSecondaryColor(),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: ColorManager.getTextPrimaryColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
```

## 最佳实践

### 1. 颜色命名规范

- 使用语义化命名，如 `success`、`warning`、`error`
- 避免使用具体颜色名称，如 `red`、`blue`
- 使用描述性名称，如 `primary`、`secondary`

### 2. 主题适配

- 始终使用 `ColorManager.getXXXColor()` 方法获取主题相关颜色
- 避免硬编码颜色值
- 提供明暗两种主题的完整支持

### 3. 对比度检查

- 使用 `ColorUtils.meetsContrastRatio()` 检查文本可读性
- 确保满足WCAG AA标准（4.5:1）
- 对于重要文本，考虑使用AAA标准（7.0:1）

### 4. 颜色一致性

- 使用预定义的颜色调色板
- 避免在应用中混合使用不同的颜色系统
- 保持品牌色彩的一致性

### 5. 性能优化

- 缓存常用的颜色计算结果
- 避免在build方法中进行复杂的颜色计算
- 使用 `const` 构造函数创建静态颜色

## 注意事项

1. **颜色格式**: 确保十六进制颜色值格式正确（#RRGGBB 或 RRGGBB）
2. **透明度**: 透明度值范围为 0.0-1.0
3. **色相值**: HSL/HSV 的色相值范围为 0-360 度
4. **饱和度/亮度**: HSL/HSV 的饱和度和亮度值范围为 0-100
5. **主题切换**: 调用 `ColorManager.setDarkMode()` 后需要重新构建UI

## 更新日志

### v1.0.0 (2025-01-27)
- 初始版本发布
- 提供完整的颜色管理功能
- 支持主题切换
- 提供丰富的颜色工具方法
- 包含详细的使用示例和文档

## 许可证

MIT License

## 联系方式

- 作者: 顾明次
- 邮箱: gu271901088@gmail.com
- 日期: 2025-01-27
