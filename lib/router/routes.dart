/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/router/routes.dart
 * @Description: 路由常量定义
 */

/// 路由常量定义
class Routes {
  // 私有构造函数，防止实例化
  Routes._();

  // 主页面路由
  static const String home = '/home';
  static const String splash = '/splash';
  static const String login = '/login';

  // Tab页面路由
  static const String mainTab = '/mainTab';
  static const String category = '/category';
  static const String cart = '/cart';
  static const String message = '/message';
  static const String profile = '/profile';

  // 功能页面路由
  static const String productDetail = '/productDetail';
  static const String search = '/search';
  static const String orderList = '/orderList';
  static const String orderDetail = '/orderDetail';
  static const String addressList = '/addressList';
  static const String addressEdit = '/addressEdit';
  static const String settings = '/settings';
  static const String about = '/about';

  // 示例页面路由
  static const String bottomTabExample = '/bottomTabExample';
  static const String advancedBottomTabExample = '/advancedBottomTabExample';
  static const String colorExample = '/colorExample';
  static const String bottomSheetExample = '/bottomSheetExample';
  static const String centerDialogExample = '/centerDialogExample';

  // 获取所有路由列表
  static List<String> get allRoutes => [
        home,
        splash,
        login,
        mainTab,
        category,
        cart,
        message,
        profile,
        productDetail,
        search,
        orderList,
        orderDetail,
        addressList,
        addressEdit,
        settings,
        about,
        bottomTabExample,
        advancedBottomTabExample,
        colorExample,
        bottomSheetExample,
        centerDialogExample,
      ];
}
