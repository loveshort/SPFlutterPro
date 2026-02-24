/*
 * @作者: 顾明次
 * @Date: 2025-09-17 14:32:49
 * @Email: gu271901088@gmail.com
 * @描述: 
 */
import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:common_widgets_utils/common_widgets_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sp_flutter_shopping/module/tabbar/bottom_tab_example.dart';
import 'package:sp_flutter_shopping/tab/tab_example.dart';

import 'common/app_info_service.dart';
import 'common/connectivity_service.dart';
import 'common/screen_util.dart';
import 'router/go_router/go_router.dart';

void main() async {
  // 确保 Flutter 绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化日志工具
  LogUtils.init(
    enabled: true,
    minLevel: LogLevel.debug,
  );

  // 测试日志功能
  LogUtils.d('Debug日志测试');
  LogUtils.i('Info日志测试');
  LogUtils.w('Warning日志测试');
  LogUtils.e('Error日志测试');

  // 初始化网络引擎
  HttpsEngine.init();

  // 初始化 SharedPreferences
  await SharedPreferencesManager.init();

  // 初始化颜色管理器
  ColorManager.setDarkMode(false); // 默认使用浅色主题

  // 初始化GoRouter配置
  GoRouterConfig.instance.initialize();

  // 启用调试模式（仅在开发环境）
  GoRouterDebug.enableDebug();

  // 记录应用启动
  LogUtils.i('应用启动');

  // 初始化通用服务
  await AppInfoService.init();
  await ConnectivityService.init();

  runApp(
    ScreenUtilInitWrapper(
      child: OKToast(
        child: ProviderScope(
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SP Flutter Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouterConfig.instance.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    LogUtils.i('MyHomePage initState');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // 记录用户行为
    LogUtils.userAction('点击计数器按钮', params: {
      'counterValue': _counter,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 计数器演示区域
          _buildCounterSection(context),
          const SizedBox(height: 24),

          // UI组件示例
          _buildSectionTitle('🎨 UI组件示例'),
          _buildExampleCard(
            context,
            title: '颜色工具示例',
            description: '演示颜色管理器的使用',
            color: ColorManager.primary,
            icon: Icons.palette,
            onTap: () => Navigator.pushNamed(context, '/color-example'),
          ),
          _buildExampleCard(
            context,
            title: '底部弹窗示例',
            description: '演示各种底部弹窗样式',
            color: Colors.purple,
            icon: Icons.view_agenda,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomSheetExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: '中间弹窗示例',
            description: '演示各种中间弹窗样式',
            color: Colors.teal,
            icon: Icons.flip_to_front,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CenterDialogExample()),
            ),
          ),
          const SizedBox(height: 16),

          // Tab导航示例（新版封装）
          _buildSectionTitle('📱 Tab导航示例（新版封装）'),
          _buildExampleCard(
            context,
            title: '基础Tab示例',
            description: '简单的三Tab导航',
            color: Colors.cyan,
            icon: Icons.tab,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BasicTabExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: '高级Tab示例',
            description: '带徽章和自定义样式的Tab',
            color: Colors.amber,
            icon: Icons.tab_unselected,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdvancedTabExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: '自定义控制器Tab示例',
            description: '演示编程式Tab切换',
            color: Colors.pink,
            icon: Icons.app_settings_alt,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CustomControllerTabExample()),
            ),
          ),
          const SizedBox(height: 16),

          // Tab导航示例（旧版）
          _buildSectionTitle('📑 Tab导航示例（旧版）'),
          _buildExampleCard(
            context,
            title: '底部Tab示例',
            description: '使用common_widgets_utils的Tab',
            color: Colors.deepPurple,
            icon: Icons.dashboard,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomTabExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: '高级底部Tab示例',
            description: '高级自定义底部Tab',
            color: Colors.indigo,
            icon: Icons.dashboard_customize,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdvancedBottomTabExample()),
            ),
          ),
          _buildExampleCard(
            context,
            title: 'Dog APP 底部导航',
            description: '根据 Figma 设计的底部导航栏',
            color: Colors.orange,
            icon: Icons.pets,
            onTap: () => Navigator.pushNamed(context, '/dogAppTabExample'),
          ),
          const SizedBox(height: 16),

          // 状态管理示例
          _buildSectionTitle('⚡ 状态管理示例'),
          _buildExampleCard(
            context,
            title: 'GetX 完美示例',
            description: '演示GetX状态管理',
            color: Colors.red,
            icon: Icons.g_mobiledata,
            onTap: () => Navigator.pushNamed(context, '/getxExample'),
          ),
          _buildExampleCard(
            context,
            title: 'Riverpod 完美示例',
            description: '演示Riverpod状态管理',
            color: Colors.teal,
            icon: Icons.anchor,
            onTap: () => Navigator.pushNamed(context, '/riverpodExample'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// 构建计数器区域
  Widget _buildCounterSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Icons.touch_app,
              size: 48,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 16),
            const Text(
              '你已经点击了这么多次：',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const DashedLine(),
          ],
        ),
      ),
    );
  }

  /// 构建分类标题
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建示例卡片
  Widget _buildExampleCard(
    BuildContext context, {
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
