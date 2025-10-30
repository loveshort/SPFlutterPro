# sp_flutter_shopping

## 功能清单与入口

- 路由系统（GoRouter）
  - 文件：`lib/router/go_router/` 目录（`go_router_config.dart`、`go_router_routes.dart`、`go_router_pages.dart` 等）
  - 特性：
    - `GoRouterConfig.instance.initialize()` 统一初始化
    - `GoRouterGuards` 路由守卫/重定向
    - `GoRouterDebug.enableDebug()` 调试开关
    - `GoRouterRoutes` 路由常量集中管理
  - 入口：应用启动即加载，初始路由为 `/`（`HomePage`）

- 新版 Tab 封装
  - 目录：`lib/tab/`
  - 文件：`tab_config.dart`、`tab_controller.dart`、`custom_bottom_tab_bar.dart`、`tab_page_view.dart`、`tab_scaffold.dart`、`tab_example.dart`
  - 特性：
    - `TabScaffold` 一站式脚手架
    - `CustomTabController` 编程式切换
    - `BottomTabBarStyle` 全量样式参数（高度/边框/阴影/动画/水波纹）
    - 徽章/图标/文字完全可配
    - KeepAlive 与 PageView/IndexedStack 双模式
  - 示例入口：主页卡片「基础/高级/自定义控制器 Tab 示例」

- 老版 Tab 示例（基于包）
  - 文件：`lib/module/tabbar/bottom_tab_example.dart`
  - 入口：主页卡片「底部Tab示例 / 高级底部Tab示例」

- GetX 示例
  - 目录：`lib/getX/`
  - 包含：控制器、页面、模型、服务、工具
  - 入口：主页卡片「GetX 完美示例」或通过 GoRouter 快捷方法

- Riverpod 示例
  - 目录：`lib/Riverpod/`
  - 包含：models/pages/providers/services/utils
  - 入口：主页卡片「Riverpod 完美示例」或通过 GoRouter 快捷方法

- 通用组件示例
  - 入口：主页卡片「颜色工具示例 / 底部弹窗示例 / 中间弹窗示例」

## 目录结构（节选）

```text
lib/
  main.dart                 # App 启动、示例聚合首页（使用 GoRouter）
  tab/                      # 新版 Tab 封装组件与示例
  module/tabbar/            # 老版 Tab 示例（依赖包）
  router/go_router/         # GoRouter 封装（配置/守卫/页面/过渡）
  getX/                     # GetX 完整示例
  Riverpod/                 # Riverpod 完整示例
package/
  common_widgets_utils/     # 本地纳管的 UI 通用组件包
```

## 依赖包与使用说明

- `common_widgets_utils`（UI 通用组件）
  - 源码位置：`package/common_widgets_utils/`
  - 项目内作为本地包依赖，可直接引入：
    ```dart
    import 'package:common_widgets_utils/common_widgets_utils.dart';
    ```
  - 示例：`DashedLine`、颜色管理 `ColorManager`、底部弹窗与居中对话框示例等

- `common_flutter_network`（网络层）
  - 初始化：
    ```dart
    HttpsEngine.init();
    LogUtils.init(enabled: true, minLevel: LogLevel.debug);
    ```
  - 用途：统一网络引擎初始化、日志打点等（示例在 `main.dart`）

- `go_router`（官方路由包）
### 常用库清单与封装用法

- `intl`（国际化/格式化）
  - 用法：
    ```dart
    import 'package:intl/intl.dart';
    final str = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    ```

- `url_launcher`（外部链接/邮件）→ 封装：`lib/common/launcher_util.dart`
  - 用法：
    ```dart
    final ok = await LauncherUtil.openUrl('https://example.com');
    ```

- `package_info_plus`（应用信息）→ 封装：`lib/common/app_info_service.dart`
  - 用法：
    ```dart
    await AppInfoService.init();
    print(AppInfoService.version);
    ```

- `connectivity_plus`（网络连通性）→ 封装：`lib/common/connectivity_service.dart`
  - 用法：
    ```dart
    await ConnectivityService.init();
    final online = await ConnectivityService.isOnline();
    ConnectivityService.onlineStream.listen((isOnline) { /* ... */ });
    ```

- `permission_handler`（权限）→ 封装：`lib/common/permission_service.dart`
  - 用法：
    ```dart
    final granted = await PermissionService.ensure(Permission.camera);
    ```

- `cached_network_image`（图片缓存）→ 封装：`lib/common/image_cache_util.dart`
  - 用法：
    ```dart
    ImageCacheUtil.network('https://...', width: 120, height: 120);
    ```

- `flutter_screenutil`（屏幕适配）→ 封装：`lib/common/screen_util.dart`
  - 用法：
    ```dart
    // 在 MyApp 外层或 MaterialApp 外层包一层
    ScreenUtilInitWrapper(child: MyApp());
    ```

- `device_info_plus`（设备信息）→ 封装：`lib/common/device_info_service.dart`
  - 用法：
    ```dart
    final data = await DeviceInfoService.getDeviceData();
    print(data['model']);
    ```

- `intl`（时间/货币/数值格式化）→ 封装：`lib/common/intl_util.dart`
  - 用法：
    ```dart
    IntlUtil.formatDate(DateTime.now());
    IntlUtil.formatCurrency(199.99);
    IntlUtil.relativeTime(DateTime.now().subtract(Duration(minutes: 5))); // 5分钟前
    ```

- `shared_preferences`（本地存储）→ 封装：`lib/common/local_storage.dart`
  - 用法：
    ```dart
    await LocalStorage.setString('token', 'abc');
    final token = await LocalStorage.getString('token');
    ```

- `Clipboard/SnackBar/Dialog`（系统交互）→ 封装：
  - `lib/common/clipboard_util.dart`
  - `lib/common/snackbar_util.dart`
  - `lib/common/dialog_util.dart`
  - 用法：
    ```dart
    await ClipboardUtil.copy('内容');
    SnackbarUtil.success(context, '已复制');
    final ok = await DialogUtil.confirm(context, '确定删除？');
    ```

- `Debounce/Throttle`（节流防抖）→ 封装：`lib/common/debounce_throttle.dart`
  - 用法：
    ```dart
    final debouncer = Debouncer(Duration(milliseconds: 300));
    debouncer(() { /* 搜索 */ });
    ```

- `EnvConfig`（环境配置）→ 封装：`lib/common/env_config.dart`
  - 用法：
    ```dart
    EnvConfig.apply(baseApiUrl: 'https://api.dev.com', name: 'dev');
    ```

  - 封装入口：`GoRouterConfig.instance.initialize()`
  - 常量：`GoRouterRoutes` 提供路径/名称常量
  - 守卫：`GoRouterGuards.*`

## 本地依赖 vs 远程依赖

项目支持在本地开发阶段直接依赖本地包，也支持切换到远程（pub.dev 或 Git）依赖。

- 本地依赖（当前默认，示意）：
  ```yaml
  # pubspec.yaml
  dependencies:
    common_widgets_utils:
      path: package/common_widgets_utils
  ```

- 远程依赖（发布/CI 可切换为 Git 或 pub.dev）：
  ```yaml
  # 方式一：Git 源
  dependencies:
    common_widgets_utils:
      git:
        url: https://github.com/your-org/common_widgets_utils.git
        ref: main

  # 方式二：pub.dev（如已发布）
  dependencies:
    common_widgets_utils: ^x.y.z
  ```

切换建议：
- 开发期：优先使用 `path` 保持联动调试
- 集成/发布：切到 `git` 或 `pub.dev` 固定版本，保证可重复构建

## 运行与构建

运行：
```bash
flutter pub get
flutter run -d macos # 或 ios/android 等设备
```

构建并上传蒲公英：
```bash
# 调试包（iOS Dev + Android Debug）
bash ./pgyer_build.sh

# 发布包（iOS Release-adhoc + Android Release）
bash ./pgyer_build_release.sh
```

所需环境变量：
```bash
export PGYER_API_KEY="<你的蒲公英_api_key>"
export PGYER_INSTALL_PASSWORD=""  # 可选
export PGYER_CHANGELOG="Auto upload via Fastlane"  # 可选
```
## 蒲公英打包与上传（Fastlane 整合）

已添加以下脚本与配置：

- `ios/fastlane/Fastfile`：
  - `lane dev`：生成 Debug/Development 版 ipa 并上传到蒲公英
  - `lane release_pgyer`：生成 Release AdHoc 版 ipa 并上传到蒲公英
- `android/fastlane/Fastfile`：
  - `lane debug_pgyer`：生成 Debug APK 并上传到蒲公英
  - `lane release_pgyer`：生成 Release APK 并上传到蒲公英
- 根目录脚本：
  - `pgyer_build.sh`：并行构建 iOS dev + Android debug，并上传蒲公英
  - `pgyer_build_release.sh`：并行构建 iOS release + Android release，并上传蒲公英

环境变量（请在 shell 或 CI 中设置）：

```bash
export PGYER_API_KEY="<你的蒲公英_api_key>"
# 可选：设置安装密码（若需要）
export PGYER_INSTALL_PASSWORD=""
# 可选：更新描述
export PGYER_CHANGELOG="Auto upload via Fastlane"
```

使用方式：

```bash
# 调试包（iOS dev + Android debug）
bash ./pgyer_build.sh

# 发布包（iOS release + Android release）
bash ./pgyer_build_release.sh
```

注意事项：
- iOS 需要正确的签名证书与 provisioning（dev 使用 development，release 使用 ad-hoc）。
- 如果没有安装 Bundler，可直接使用 `fastlane <lane>`；脚本已自动判断。
- Android lanes 默认输出 APK 并上传，如需改为 AAB 可调整 gradle 任务与上传文件。

## 项目简介

本项目是一个集成多种架构与路由方案的 Flutter 电商示例工程，包含：

- 新版 Tab 封装（自研组件，支持徽章/动画/KeepAlive/自定义样式）
- 老版 Tab（基于 `common_widgets_utils` 的示例）
- 路由：GoRouter 完整封装（守卫、过渡、调试、类型安全常量）
- 状态管理：GetX 与 Riverpod 两套完整示例（列表、详情、表单、购物车）
- 通用 UI 组件：颜色管理、虚线、弹窗、居中对话框等
- 网络层：`common_flutter_network` 统一初始化与日志
- 打包分发：fastlane + Pgyer 一键上传（iOS/Android 并行）

## 开发规范与说明

- 代码风格：已启用 `flutter_lints`（见 `analysis_options.yaml`）
- 组件开发：
  - 注重可读性与可配置性，避免过度嵌套
  - 注释只保留必要的非显式信息（设计意图/边界条件/性能安全）
- 路由：统一走 `GoRouter`，路径从 `GoRouterRoutes` 获取
- 日志：统一通过 `LogUtils` 输出，便于排查

## 常见问题（FAQ）

1. 首页不显示示例列表？
   - 已将 GoRouter 的 `/` 对应页面更新为示例聚合页（`HomePage` 在 `go_router_pages.dart`），确保 `GoRouterConfig.instance.initialize()` 正常执行。

2. iOS 打包失败：
   - 确认签名证书/Provisioning 是否与 lane 中的 `export_method` 对应（dev=development，release=ad-hoc）。

3. Android 上传失败：
   - 确认 `PGYER_API_KEY` 是否正确，且 APK 路径存在；若改为 AAB 需同步调整上传文件参数。


