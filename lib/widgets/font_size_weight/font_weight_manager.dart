/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-22 15:30:03
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-22 15:33:51
 * @FilePath: /SPFlutterPro/lib/widgets/font_size_weight/font_weight_manager.dart
 * @Description: 字体粗细管理器
 */
import 'dart:io';
import 'package:flutter/material.dart';

/// 字体粗细管理器
/// 解决Android和iOS平台字体粗细显示不一致的问题
class FontWeightManager {
  static bool get _isAndroid => Platform.isAndroid;
  static bool get _isIOS => Platform.isIOS;

  /// 统一的字体粗细映射表
  /// Android平台会自动增加一个级别的粗细来匹配iOS的视觉效果
  static FontWeight getUnifiedFontWeight(FontWeight originalWeight) {
    if (_isAndroid) {
      // Android平台字体看起来比iOS细，所以增加一个级别
      return _getAndroidAdjustedWeight(originalWeight);
    } else {
      // iOS平台保持原始粗细
      return originalWeight;
    }
  }

  /// Android平台字体粗细调整
  static FontWeight _getAndroidAdjustedWeight(FontWeight weight) {
    switch (weight) {
      case FontWeight.w100:
        return FontWeight.w200;
      case FontWeight.w200:
        return FontWeight.w300;
      case FontWeight.w300:
        return FontWeight.w400;
      case FontWeight.w400:
        return FontWeight.w500;
      case FontWeight.w500:
        return FontWeight.w600;
      case FontWeight.w600:
        return FontWeight.w700;
      case FontWeight.w700:
        return FontWeight.w800;
      case FontWeight.w800:
        return FontWeight.w900;
      case FontWeight.w900:
        return FontWeight.w900; // 已经是最大值
      default:
        return FontWeight.w500; // 默认值
    }
  }

  /// 预定义的统一字体粗细常量
  /// 超细字体 (w100 -> Android: w200, iOS: w100)
  static FontWeight get ultraLight => getUnifiedFontWeight(FontWeight.w100);

  /// 极细字体 (w200 -> Android: w300, iOS: w200)
  static FontWeight get extraLight => getUnifiedFontWeight(FontWeight.w200);

  /// 细字体 (w300 -> Android: w400, iOS: w300)
  static FontWeight get light => getUnifiedFontWeight(FontWeight.w300);

  /// 正常字体 (w400 -> Android: w500, iOS: w400)
  static FontWeight get normal => getUnifiedFontWeight(FontWeight.w400);

  /// 中等字体 (w500 -> Android: w600, iOS: w500)
  static FontWeight get medium => getUnifiedFontWeight(FontWeight.w500);

  /// 半粗字体 (w600 -> Android: w700, iOS: w600)
  static FontWeight get semiBold => getUnifiedFontWeight(FontWeight.w600);

  /// 粗字体 (w700 -> Android: w800, iOS: w700)
  static FontWeight get bold => getUnifiedFontWeight(FontWeight.w700);

  /// 超粗字体 (w800 -> Android: w900, iOS: w800)
  static FontWeight get extraBold => getUnifiedFontWeight(FontWeight.w800);

  /// 极粗字体 (w900 -> Android: w900, iOS: w900)
  static FontWeight get ultraBold => getUnifiedFontWeight(FontWeight.w900);

  /// 获取当前平台信息
  static String get platformInfo {
    if (_isAndroid) {
      return 'Android (字体粗细已调整)';
    } else if (_isIOS) {
      return 'iOS (原始字体粗细)';
    } else {
      return '其他平台';
    }
  }

  /// 检查是否为Android平台
  static bool get isAndroid => _isAndroid;

  /// 检查是否为iOS平台
  static bool get isIOS => _isIOS;
}

/// 扩展方法，为TextStyle提供便捷的统一字体粗细设置
extension TextStyleExtension on TextStyle {
  /// 使用统一的字体粗细
  TextStyle unifiedFontWeight(FontWeight weight) {
    return copyWith(fontWeight: FontWeightManager.getUnifiedFontWeight(weight));
  }
}

/// 扩展方法，为Text提供便捷的统一字体粗细设置
extension TextExtension on Text {
  /// 使用统一的字体粗细创建Text
  static Text unified(
    String data, {
    FontWeight? fontWeight,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
  }) {
    final unifiedWeight = fontWeight != null
        ? FontWeightManager.getUnifiedFontWeight(fontWeight)
        : null;

    return Text(
      data,
      style: (style ?? TextStyle()).copyWith(
        fontWeight: unifiedWeight,
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
      ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
