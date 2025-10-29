/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/router/go_router_routes.dart
 * @Description: GoRouter 路由定义 - 类型安全的路由常量
 */

/// GoRouter 路由路径和名称定义
/// 提供类型安全的路由管理
class GoRouterRoutes {
  // 私有构造函数，防止实例化
  GoRouterRoutes._();

  // ==================== 基础路由 ====================

  /// 首页路径
  static const String home = '/';

  /// 首页名称
  static const String homeName = 'home';

  /// 登录页路径
  static const String login = '/login';

  /// 登录页名称
  static const String loginName = 'login';

  /// 主Tab页路径
  static const String mainTab = '/main';

  /// 主Tab页名称
  static const String mainTabName = 'main-tab';

  // ==================== Tab子路由 ====================

  /// Tab首页路径
  static const String tabHome = '/main/home';

  /// Tab分类页路径
  static const String tabCategory = '/main/category';

  /// Tab购物车页路径
  static const String tabCart = '/main/cart';

  /// Tab消息页路径
  static const String tabMessage = '/main/message';

  /// Tab个人页路径
  static const String tabProfile = '/main/profile';

  // ==================== GetX示例路由 ====================

  /// GetX示例页路径
  static const String getxExample = '/getx-example';

  /// GetX示例页名称
  static const String getxExampleName = 'getx-example';

  /// Todo列表页路径
  static const String todoList = '/todos';

  /// Todo列表页名称
  static const String todoListName = 'todo-list';

  /// Todo详情页路径模板
  static const String todoDetail = '/todos/detail/:todoId';

  /// Todo详情页名称
  static const String todoDetailName = 'todo-detail';

  /// Todo表单页路径
  static const String todoForm = '/todos/form';

  /// Todo表单页名称
  static const String todoFormName = 'todo-form';

  // ==================== Riverpod示例路由 ====================

  /// Riverpod示例页路径
  static const String riverpodExample = '/riverpod-example';

  /// Riverpod示例页名称
  static const String riverpodExampleName = 'riverpod-example';

  /// Riverpod产品列表页路径
  static const String riverpodProductList = '/products';

  /// Riverpod产品列表页名称
  static const String riverpodProductListName = 'product-list';

  /// Riverpod产品详情页路径模板
  static const String riverpodProductDetail = '/products/detail/:productId';

  /// Riverpod产品详情页名称
  static const String riverpodProductDetailName = 'product-detail';

  /// Riverpod购物车页路径
  static const String riverpodCart = '/cart';

  /// Riverpod购物车页名称
  static const String riverpodCartName = 'cart';

  // ==================== 功能路由 ====================

  /// 搜索页路径
  static const String search = '/search';

  /// 搜索页名称
  static const String searchName = 'search';

  /// 设置页路径
  static const String settings = '/settings';

  /// 设置页名称
  static const String settingsName = 'settings';

  /// 关于页路径
  static const String about = '/about';

  /// 关于页名称
  static const String aboutName = 'about';

  // ==================== 示例路由 ====================

  /// 底部Tab示例页路径
  static const String bottomTabExample = '/examples/bottom-tab';

  /// 底部Tab示例页名称
  static const String bottomTabExampleName = 'bottom-tab-example';

  /// 高级底部Tab示例页路径
  static const String advancedBottomTabExample =
      '/examples/advanced-bottom-tab';

  /// 高级底部Tab示例页名称
  static const String advancedBottomTabExampleName =
      'advanced-bottom-tab-example';

  /// 颜色示例页路径
  static const String colorExample = '/examples/color';

  /// 颜色示例页名称
  static const String colorExampleName = 'color-example';

  /// 底部弹窗示例页路径
  static const String bottomSheetExample = '/examples/bottom-sheet';

  /// 底部弹窗示例页名称
  static const String bottomSheetExampleName = 'bottom-sheet-example';

  /// 居中对话框示例页路径
  static const String centerDialogExample = '/examples/center-dialog';

  /// 居中对话框示例页名称
  static const String centerDialogExampleName = 'center-dialog-example';

  // ==================== 路由工具方法 ====================

  /// 获取所有路由路径列表
  static List<String> get allPaths => [
        home,
        login,
        mainTab,
        tabHome,
        tabCategory,
        tabCart,
        tabMessage,
        tabProfile,
        getxExample,
        todoList,
        todoDetail,
        todoForm,
        riverpodExample,
        riverpodProductList,
        riverpodProductDetail,
        riverpodCart,
        search,
        settings,
        about,
        bottomTabExample,
        advancedBottomTabExample,
        colorExample,
        bottomSheetExample,
        centerDialogExample,
      ];

  /// 获取所有路由名称列表
  static List<String> get allNames => [
        homeName,
        loginName,
        mainTabName,
        'tab-home',
        'tab-category',
        'tab-cart',
        'tab-message',
        'tab-profile',
        getxExampleName,
        todoListName,
        todoDetailName,
        todoFormName,
        riverpodExampleName,
        riverpodProductListName,
        riverpodProductDetailName,
        riverpodCartName,
        searchName,
        settingsName,
        aboutName,
        bottomTabExampleName,
        advancedBottomTabExampleName,
        colorExampleName,
        bottomSheetExampleName,
        centerDialogExampleName,
      ];

  // ==================== 路径构建方法 ====================

  /// 构建Todo详情页路径
  static String todoDetailPath(String todoId) => '/todos/detail/$todoId';

  /// 构建产品详情页路径
  static String productDetailPath(String productId) =>
      '/products/detail/$productId';

  /// 构建Tab页路径
  static String tabPath(String tabName) => '/main/$tabName';

  /// 构建示例页路径
  static String examplePath(String exampleName) => '/examples/$exampleName';

  // ==================== 路径验证方法 ====================

  /// 验证路径是否有效
  static bool isValidPath(String path) {
    return allPaths.contains(path) ||
        path.startsWith('/todos/detail/') ||
        path.startsWith('/products/detail/') ||
        path.startsWith('/main/') ||
        path.startsWith('/examples/');
  }

  /// 验证路由名称是否有效
  static bool isValidName(String name) {
    return allNames.contains(name);
  }

  /// 获取路径对应的路由名称
  static String? getRouteName(String path) {
    switch (path) {
      case home:
        return homeName;
      case login:
        return loginName;
      case mainTab:
        return mainTabName;
      case getxExample:
        return getxExampleName;
      case todoList:
        return todoListName;
      case riverpodExample:
        return riverpodExampleName;
      case riverpodProductList:
        return riverpodProductListName;
      case riverpodCart:
        return riverpodCartName;
      case search:
        return searchName;
      case settings:
        return settingsName;
      case about:
        return aboutName;
      case bottomTabExample:
        return bottomTabExampleName;
      case advancedBottomTabExample:
        return advancedBottomTabExampleName;
      case colorExample:
        return colorExampleName;
      case bottomSheetExample:
        return bottomSheetExampleName;
      case centerDialogExample:
        return centerDialogExampleName;
      default:
        if (path.startsWith('/todos/detail/')) return todoDetailName;
        if (path.startsWith('/products/detail/')) {
          return riverpodProductDetailName;
        }
        if (path.startsWith('/main/')) {
          final tabName = path.split('/').last;
          return 'tab-$tabName';
        }
        if (path.startsWith('/examples/')) {
          final exampleName = path.split('/').last;
          return '$exampleName-example';
        }
        return null;
    }
  }
}

/// 路由参数类
/// 提供类型安全的参数传递
class GoRouterParams {
  // Todo相关参数
  static const String todoId = 'todoId';
  static const String todo = 'todo';

  // 产品相关参数
  static const String productId = 'productId';
  static const String product = 'product';

  // 用户相关参数
  static const String userId = 'userId';
  static const String user = 'user';

  // 搜索相关参数
  static const String query = 'query';
  static const String category = 'category';

  // 通用参数
  static const String id = 'id';
  static const String data = 'data';
  static const String extra = 'extra';
}

/// 路由查询参数类
/// 提供类型安全的查询参数管理
class GoRouterQueryParams {
  // 搜索参数
  static const String searchQuery = 'q';
  static const String searchCategory = 'category';
  static const String searchSort = 'sort';

  // 分页参数
  static const String page = 'page';
  static const String pageSize = 'pageSize';
  static const String limit = 'limit';
  static const String offset = 'offset';

  // 过滤参数
  static const String filter = 'filter';
  static const String minPrice = 'minPrice';
  static const String maxPrice = 'maxPrice';
  static const String brand = 'brand';

  // 排序参数
  static const String sortBy = 'sortBy';
  static const String sortOrder = 'sortOrder';
  static const String orderBy = 'orderBy';

  // 状态参数
  static const String status = 'status';
  static const String type = 'type';
  static const String mode = 'mode';

  // 通用参数
  static const String returnTo = 'returnTo';
  static const String redirect = 'redirect';
  static const String callback = 'callback';
}
