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
