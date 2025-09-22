/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 颜色工具类 - 提供颜色转换、计算、生成等功能
 */

import 'dart:math';
import 'package:flutter/material.dart';

/// 颜色工具类
/// 提供各种颜色操作和计算功能
class ColorUtils {
  // ==================== 颜色转换 ====================

  /// 十六进制字符串转Color
  /// [hex] 十六进制颜色值，支持 #RRGGBB 或 RRGGBB 格式
  /// [alpha] 透明度，0.0-1.0
  static Color hexToColor(String hex, {double alpha = 1.0}) {
    try {
      // 移除 # 号
      hex = hex.replaceAll('#', '');

      // 确保是6位十六进制
      if (hex.length == 3) {
        hex = hex.split('').map((char) => char + char).join();
      }

      if (hex.length != 6) {
        throw ArgumentError('无效的十六进制颜色值: $hex');
      }

      final r = int.parse(hex.substring(0, 2), radix: 16);
      final g = int.parse(hex.substring(2, 4), radix: 16);
      final b = int.parse(hex.substring(4, 6), radix: 16);

      return Color.fromRGBO(r, g, b, alpha);
    } catch (e) {
      throw ArgumentError('颜色转换失败: $e');
    }
  }

  /// Color转十六进制字符串
  /// [color] 要转换的颜色
  /// [includeAlpha] 是否包含透明度
  static String colorToHex(Color color, {bool includeAlpha = false}) {
    final r = color.red.toRadixString(16).padLeft(2, '0');
    final g = color.green.toRadixString(16).padLeft(2, '0');
    final b = color.blue.toRadixString(16).padLeft(2, '0');

    if (includeAlpha) {
      final a = color.alpha.toRadixString(16).padLeft(2, '0');
      return '#$a$r$g$b';
    }

    return '#$r$g$b';
  }

  /// RGB值转Color
  static Color rgbToColor(int r, int g, int b, {double alpha = 1.0}) {
    return Color.fromRGBO(
      r.clamp(0, 255),
      g.clamp(0, 255),
      b.clamp(0, 255),
      alpha.clamp(0.0, 1.0),
    );
  }

  /// HSL值转Color
  /// [h] 色相 (0-360)
  /// [s] 饱和度 (0-100)
  /// [l] 亮度 (0-100)
  /// [alpha] 透明度 (0.0-1.0)
  static Color hslToColor(double h, double s, double l, {double alpha = 1.0}) {
    h = h.clamp(0, 360);
    s = s.clamp(0, 100) / 100;
    l = l.clamp(0, 100) / 100;
    alpha = alpha.clamp(0.0, 1.0);

    final c = (1 - (2 * l - 1).abs()) * s;
    final x = c * (1 - ((h / 60) % 2 - 1).abs());
    final m = l - c / 2;

    double r, g, b;

    if (h < 60) {
      r = c;
      g = x;
      b = 0;
    } else if (h < 120) {
      r = x;
      g = c;
      b = 0;
    } else if (h < 180) {
      r = 0;
      g = c;
      b = x;
    } else if (h < 240) {
      r = 0;
      g = x;
      b = c;
    } else if (h < 300) {
      r = x;
      g = 0;
      b = c;
    } else {
      r = c;
      g = 0;
      b = x;
    }

    return Color.fromRGBO(
      ((r + m) * 255).round(),
      ((g + m) * 255).round(),
      ((b + m) * 255).round(),
      alpha,
    );
  }

  /// HSV值转Color
  /// [h] 色相 (0-360)
  /// [s] 饱和度 (0-100)
  /// [v] 明度 (0-100)
  /// [alpha] 透明度 (0.0-1.0)
  static Color hsvToColor(double h, double s, double v, {double alpha = 1.0}) {
    h = h.clamp(0, 360);
    s = s.clamp(0, 100) / 100;
    v = v.clamp(0, 100) / 100;
    alpha = alpha.clamp(0.0, 1.0);

    final c = v * s;
    final x = c * (1 - ((h / 60) % 2 - 1).abs());
    final m = v - c;

    double r, g, b;

    if (h < 60) {
      r = c;
      g = x;
      b = 0;
    } else if (h < 120) {
      r = x;
      g = c;
      b = 0;
    } else if (h < 180) {
      r = 0;
      g = c;
      b = x;
    } else if (h < 240) {
      r = 0;
      g = x;
      b = c;
    } else if (h < 300) {
      r = x;
      g = 0;
      b = c;
    } else {
      r = c;
      g = 0;
      b = x;
    }

    return Color.fromRGBO(
      ((r + m) * 255).round(),
      ((g + m) * 255).round(),
      ((b + m) * 255).round(),
      alpha,
    );
  }

  // ==================== 颜色计算 ====================

  /// 混合两个颜色
  /// [color1] 第一个颜色
  /// [color2] 第二个颜色
  /// [ratio] 混合比例 (0.0-1.0)，0.0表示完全使用color1，1.0表示完全使用color2
  static Color blendColors(Color color1, Color color2, double ratio) {
    ratio = ratio.clamp(0.0, 1.0);

    final r = (color1.red * (1 - ratio) + color2.red * ratio).round();
    final g = (color1.green * (1 - ratio) + color2.green * ratio).round();
    final b = (color1.blue * (1 - ratio) + color2.blue * ratio).round();
    final a = (color1.alpha * (1 - ratio) + color2.alpha * ratio);

    return Color.fromRGBO(r, g, b, a);
  }

  /// 调整颜色亮度
  /// [color] 原始颜色
  /// [amount] 调整量 (-1.0到1.0)，负数变暗，正数变亮
  static Color adjustBrightness(Color color, double amount) {
    amount = amount.clamp(-1.0, 1.0);

    final r = (color.red + (255 * amount)).clamp(0, 255);
    final g = (color.green + (255 * amount)).clamp(0, 255);
    final b = (color.blue + (255 * amount)).clamp(0, 255);

    return Color.fromRGBO(r.round(), g.round(), b.round(), color.alpha / 255.0);
  }

  /// 调整颜色饱和度
  /// [color] 原始颜色
  /// [amount] 调整量 (-1.0到1.0)，负数降低饱和度，正数提高饱和度
  static Color adjustSaturation(Color color, double amount) {
    amount = amount.clamp(-1.0, 1.0);

    final hsv = colorToHsv(color);
    final newSaturation = (hsv['s']! + amount).clamp(0.0, 1.0);

    return hsvToColor(
      hsv['h']!,
      newSaturation * 100,
      hsv['v']! * 100,
      alpha: color.alpha / 255.0,
    );
  }

  /// 调整颜色色相
  /// [color] 原始颜色
  /// [amount] 调整量 (-360到360度)
  static Color adjustHue(Color color, double amount) {
    amount = amount.clamp(-360, 360);

    final hsv = colorToHsv(color);
    final newHue = (hsv['h']! + amount) % 360;

    return hsvToColor(
      newHue,
      hsv['s']! * 100,
      hsv['v']! * 100,
      alpha: color.alpha / 255.0,
    );
  }

  /// 反转颜色
  static Color invertColor(Color color) {
    return Color.fromRGBO(
      255 - color.red,
      255 - color.green,
      255 - color.blue,
      color.alpha / 255.0,
    );
  }

  /// 获取颜色的补色
  static Color getComplementaryColor(Color color) {
    final hsv = colorToHsv(color);
    final complementaryHue = (hsv['h']! + 180) % 360;

    return hsvToColor(
      complementaryHue,
      hsv['s']! * 100,
      hsv['v']! * 100,
      alpha: color.alpha / 255.0,
    );
  }

  /// 获取颜色的三元色
  static List<Color> getTriadicColors(Color color) {
    final hsv = colorToHsv(color);
    final hue1 = (hsv['h']! + 120) % 360;
    final hue2 = (hsv['h']! + 240) % 360;

    return [
      color,
      hsvToColor(hue1, hsv['s']! * 100, hsv['v']! * 100,
          alpha: color.alpha / 255.0),
      hsvToColor(hue2, hsv['s']! * 100, hsv['v']! * 100,
          alpha: color.alpha / 255.0),
    ];
  }

  /// 获取颜色的类似色
  static List<Color> getAnalogousColors(Color color, {int count = 5}) {
    final hsv = colorToHsv(color);
    final colors = <Color>[];

    for (int i = 0; i < count; i++) {
      final hue = (hsv['h']! + (i - count ~/ 2) * 30) % 360;
      colors.add(hsvToColor(
        hue,
        hsv['s']! * 100,
        hsv['v']! * 100,
        alpha: color.alpha / 255.0,
      ));
    }

    return colors;
  }

  // ==================== 颜色分析 ====================

  /// 计算颜色亮度
  static double getLuminance(Color color) {
    return color.computeLuminance();
  }

  /// 判断颜色是否为深色
  static bool isDarkColor(Color color) {
    return getLuminance(color) < 0.5;
  }

  /// 判断颜色是否为浅色
  static bool isLightColor(Color color) {
    return !isDarkColor(color);
  }

  /// 计算两个颜色的对比度
  static double getContrastRatio(Color color1, Color color2) {
    final lum1 = getLuminance(color1);
    final lum2 = getLuminance(color2);

    final lighter = lum1 > lum2 ? lum1 : lum2;
    final darker = lum1 < lum2 ? lum1 : lum2;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// 检查颜色对比度是否满足WCAG标准
  /// [ratio] 最小对比度要求，通常为4.5（AA级）或7.0（AAA级）
  static bool meetsContrastRatio(Color color1, Color color2,
      {double ratio = 4.5}) {
    return getContrastRatio(color1, color2) >= ratio;
  }

  /// 获取适合的文本颜色（基于背景色）
  static Color getTextColorForBackground(Color backgroundColor) {
    return isDarkColor(backgroundColor) ? Colors.white : Colors.black;
  }

  /// Color转HSV
  static Map<String, double> colorToHsv(Color color) {
    final r = color.red / 255.0;
    final g = color.green / 255.0;
    final b = color.blue / 255.0;

    final maxValue = [r, g, b].reduce((a, b) => a > b ? a : b);
    final minValue = [r, g, b].reduce((a, b) => a < b ? a : b);
    final delta = maxValue - minValue;

    double h = 0;
    if (delta != 0) {
      if (maxValue == r) {
        h = 60 * (((g - b) / delta) % 6);
      } else if (maxValue == g) {
        h = 60 * ((b - r) / delta + 2);
      } else if (maxValue == b) {
        h = 60 * ((r - g) / delta + 4);
      }
    }

    if (h < 0) h += 360;

    final s = maxValue == 0 ? 0 : delta / maxValue;
    final v = maxValue;

    return {'h': h.toDouble(), 's': s.toDouble(), 'v': v.toDouble()};
  }

  /// Color转HSL
  static Map<String, double> colorToHsl(Color color) {
    final r = color.red / 255.0;
    final g = color.green / 255.0;
    final b = color.blue / 255.0;

    final maxValue = [r, g, b].reduce((a, b) => a > b ? a : b);
    final minValue = [r, g, b].reduce((a, b) => a < b ? a : b);
    final delta = maxValue - minValue;

    double h = 0;
    if (delta != 0) {
      if (maxValue == r) {
        h = 60 * (((g - b) / delta) % 6);
      } else if (maxValue == g) {
        h = 60 * ((b - r) / delta + 2);
      } else if (maxValue == b) {
        h = 60 * ((r - g) / delta + 4);
      }
    }

    if (h < 0) h += 360;

    final l = (maxValue + minValue) / 2;
    final s = delta == 0 ? 0 : delta / (1 - (2 * l - 1).abs());

    return {'h': h.toDouble(), 's': s.toDouble(), 'l': l.toDouble()};
  }

  // ==================== 颜色生成 ====================

  /// 生成随机颜色
  static Color generateRandomColor({double alpha = 1.0}) {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      alpha,
    );
  }

  /// 生成随机明亮颜色
  static Color generateRandomBrightColor({double alpha = 1.0}) {
    final random = Random();
    return hsvToColor(
      random.nextDouble() * 360,
      0.7 + random.nextDouble() * 0.3, // 饱和度 70%-100%
      0.8 + random.nextDouble() * 0.2, // 明度 80%-100%
      alpha: alpha,
    );
  }

  /// 生成随机柔和颜色
  static Color generateRandomSoftColor({double alpha = 1.0}) {
    final random = Random();
    return hsvToColor(
      random.nextDouble() * 360,
      0.3 + random.nextDouble() * 0.4, // 饱和度 30%-70%
      0.6 + random.nextDouble() * 0.3, // 明度 60%-90%
      alpha: alpha,
    );
  }

  /// 生成调色板
  /// [baseColor] 基础颜色
  /// [count] 生成颜色数量
  static List<Color> generatePalette(Color baseColor, {int count = 5}) {
    final hsv = colorToHsv(baseColor);
    final colors = <Color>[];

    for (int i = 0; i < count; i++) {
      final hue = (hsv['h']! + (i * 72)) % 360; // 72度间隔
      colors.add(hsvToColor(
        hue,
        hsv['s']! * 100,
        hsv['v']! * 100,
        alpha: baseColor.alpha / 255.0,
      ));
    }

    return colors;
  }

  /// 生成单色调色板
  /// [baseColor] 基础颜色
  /// [count] 生成颜色数量
  static List<Color> generateMonochromaticPalette(Color baseColor,
      {int count = 5}) {
    final hsv = colorToHsv(baseColor);
    final colors = <Color>[];

    for (int i = 0; i < count; i++) {
      final lightness = 0.2 + (i / (count - 1)) * 0.6; // 20%-80%
      colors.add(hsvToColor(
        hsv['h']!,
        hsv['s']! * 100,
        lightness * 100,
        alpha: baseColor.alpha / 255.0,
      ));
    }

    return colors;
  }

  // ==================== 颜色格式化 ====================

  /// 格式化颜色信息
  static String formatColorInfo(Color color) {
    final hex = colorToHex(color);
    final rgb = 'RGB(${color.red}, ${color.green}, ${color.blue})';
    final hsv = colorToHsv(color);
    final hsl = colorToHsl(color);
    final luminance = getLuminance(color);

    return '''
颜色信息:
├─ 十六进制: $hex
├─ RGB: $rgb
├─ HSV: H:${hsv['h']!.toStringAsFixed(1)}° S:${(hsv['s']! * 100).toStringAsFixed(1)}% V:${(hsv['v']! * 100).toStringAsFixed(1)}%
├─ HSL: H:${hsl['h']!.toStringAsFixed(1)}° S:${(hsl['s']! * 100).toStringAsFixed(1)}% L:${(hsl['l']! * 100).toStringAsFixed(1)}%
├─ 亮度: ${(luminance * 100).toStringAsFixed(1)}%
└─ 类型: ${isDarkColor(color) ? '深色' : '浅色'}
''';
  }

  /// 获取颜色名称（基于RGB值）
  static String getColorName(Color color) {
    final r = color.red;
    final g = color.green;
    final b = color.blue;

    // 常见颜色映射
    if (r == 255 && g == 255 && b == 255) return '白色';
    if (r == 0 && g == 0 && b == 0) return '黑色';
    if (r == 255 && g == 0 && b == 0) return '红色';
    if (r == 0 && g == 255 && b == 0) return '绿色';
    if (r == 0 && g == 0 && b == 255) return '蓝色';
    if (r == 255 && g == 255 && b == 0) return '黄色';
    if (r == 255 && g == 0 && b == 255) return '洋红';
    if (r == 0 && g == 255 && b == 255) return '青色';
    if (r == 128 && g == 128 && b == 128) return '灰色';

    // 基于RGB值判断
    if (r > g && r > b) return '偏红色';
    if (g > r && g > b) return '偏绿色';
    if (b > r && b > g) return '偏蓝色';
    if (r == g && g == b) return '灰色系';

    return '混合色';
  }
}
