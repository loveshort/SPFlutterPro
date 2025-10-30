import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilInitWrapper extends StatelessWidget {
  final Widget child;
  final Size designSize;

  const ScreenUtilInitWrapper({super.key, required this.child, this.designSize = const Size(375, 812)});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => child,
    );
  }
}


