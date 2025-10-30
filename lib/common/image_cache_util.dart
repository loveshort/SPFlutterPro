import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCacheUtil {
  ImageCacheUtil._();

  static Widget network(
    String url, {
    double? width,
    double? height,
    BoxFit? fit,
    Widget? placeholder,
    Widget? error,
    BorderRadius? borderRadius,
  }) {
    final image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => placeholder ?? const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      errorWidget: (_, __, ___) => error ?? const Icon(Icons.broken_image),
    );

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: image);
    }
    return image;
  }
}


