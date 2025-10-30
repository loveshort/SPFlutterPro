/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 17:04:24
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 17:06:49
 * @FilePath: /SPFlutterPro/lib/common/svg_util.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgUtil {
  SvgUtil._();

  static Widget asset(
    String assetName, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    ColorFilter? colorFilter,
  }) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      colorFilter: colorFilter,
    );
  }

  static Widget network(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    ColorFilter? colorFilter,
  }) {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: placeholder != null ? (_) => placeholder : null,
      colorFilter: colorFilter,
    );
  }
}
