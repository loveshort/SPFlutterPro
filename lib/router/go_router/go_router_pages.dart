/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 15:04:44
 * @FilePath: /SPFlutterPro/lib/router/go_router_pages.dart
 * @Description: GoRouter 页面组件 - 基础页面组件
 */

import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:common_widgets_utils/common_widgets_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/decimal_util.dart';
import '../../common/device_info_service.dart';
import '../../common/image_cache_util.dart';
import '../../common/intl_util.dart';
import '../../common/launcher_util.dart';
import '../../common/permission_service.dart';
import '../../common/svg_util.dart';
import '../../common/toast_util.dart';
import '../../module/tabbar/bottom_tab_example.dart';
import '../../tab/tab_example.dart';
import '../../ios26widget/ios_tab_example.dart';
import 'go_router_utils.dart';

/// 首页组件
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    LogUtils.i('HomePage initState');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

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
        title: const Text('SP Flutter Shopping'),
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
            onTap: () {
              // 跳转到颜色示例页面
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ColorExamplePage()),
              );
            },
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

          // 常用工具示例
          _buildSectionTitle('🧰 常用工具示例'),
          _buildExampleCard(
            context,
            title: '设备信息',
            description: '读取设备品牌/型号/系统版本等',
            color: Colors.brown,
            icon: Icons.devices_other,
            onTap: () async {
              final data = await DeviceInfoService.getDeviceData();
              if (mounted) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('设备信息'),
                    content:
                        SingleChildScrollView(child: Text(data.toString())),
                  ),
                );
              }
            },
          ),
          _buildExampleCard(
            context,
            title: '打开官方网站',
            description: '通过 url_launcher 打开外部链接',
            color: Colors.blueGrey,
            icon: Icons.open_in_browser,
            onTap: () async {
              final ok = await LauncherUtil.openUrl('https://flutter.dev');
              if (mounted && !ok) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('无法打开链接')),
                );
              }
            },
          ),
          _buildExampleCard(
            context,
            title: '申请相机权限',
            description: 'permission_handler 示例',
            color: Colors.orange,
            icon: Icons.photo_camera,
            onTap: () async {
              final granted = await PermissionService.ensure(Permission.camera);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(granted ? '已授权' : '未授权')),
              );
            },
          ),
          _buildExampleCard(
            context,
            title: '格式化示例',
            description: 'Intl：时间/货币/相对时间',
            color: Colors.green,
            icon: Icons.access_time,
            onTap: () async {
              final ts = IntlUtil.formatDate(DateTime.now());
              final money = IntlUtil.formatCurrency(88.8);
              final rel = IntlUtil.relativeTime(
                  DateTime.now().subtract(const Duration(minutes: 3)));
              if (!mounted) return;
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('格式化示例'),
                  content: Text('时间: $ts\n金额: $money\n相对: $rel'),
                ),
              );
            },
          ),
          _buildExampleCard(
            context,
            title: '图片缓存展示',
            description: 'cached_network_image 简易封装',
            color: Colors.purpleAccent,
            icon: Icons.image,
            onTap: () async {
              if (!mounted) return;
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('图片缓存'),
                  content: SizedBox(
                    width: 200,
                    height: 200,
                    child: ImageCacheUtil.network(
                      'https://picsum.photos/300',
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              );
            },
          ),

          _buildExampleCard(
            context,
            title: 'SVG 展示',
            description: 'flutter_svg 封装示例',
            color: Colors.black87,
            icon: Icons.logo_dev,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('SVG 示例'),
                  content: SizedBox(
                    width: 160,
                    height: 160,
                    child: SvgUtil.network(
                      'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg',
                      placeholder: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                  ),
                ),
              );
            },
          ),

          _buildExampleCard(
            context,
            title: 'Toast 提示',
            description: 'oktoast 封装示例',
            color: Colors.deepOrange,
            icon: Icons.notification_important,
            onTap: () {
              ToastUtil.success('操作成功');
            },
          ),

          _buildExampleCard(
            context,
            title: '高精度计算',
            description: 'decimal 加减乘除',
            color: Colors.blueAccent,
            icon: Icons.calculate,
            onTap: () {
              final add = DecimalUtil.add(0.1, 0.2, scale: 3); // 0.300
              final mul = DecimalUtil.mul(2.5, 1.2, scale: 3); // 3.000
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('高精度结果'),
                  content: Text('0.1 + 0.2 = $add\n2.5 × 1.2 = $mul'),
                ),
              );
            },
          ),

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
          _buildExampleCard(
            context,
            title: 'iOS 26 原生 Tab 示例',
            description: 'iOS 26+ 调用原生；以下沿用 Flutter',
            color: Colors.black,
            icon: Icons.phone_iphone,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IOSTabExample()),
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
          const SizedBox(height: 16),

          // 状态管理示例
          _buildSectionTitle('⚡ 状态管理示例'),
          _buildExampleCard(
            context,
            title: 'GetX 完美示例',
            description: '演示GetX状态管理',
            color: Colors.red,
            icon: Icons.g_mobiledata,
            onTap: () => context.goGetXExample(),
          ),
          _buildExampleCard(
            context,
            title: 'Riverpod 完美示例',
            description: '演示Riverpod状态管理',
            color: Colors.teal,
            icon: Icons.anchor,
            onTap: () => context.goRiverpodExample(),
          ),
          const SizedBox(height: 16),

          // 应用内购买
          _buildSectionTitle('🛒 应用内购买'),
          _buildExampleCard(
            context,
            title: '内购示例',
            description: '演示内购功能',
            color: Colors.blue,
            icon: Icons.shopping_cart,
            onTap: () => context.goInAppPurchase(),
          ),
          const SizedBox(height: 24),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '增加计数',
        child: const Icon(Icons.add),
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

/// 登录页组件
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.login,
                size: 80,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              const Text(
                '用户登录',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // 模拟登录成功
                  context.goMainTab();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('登录'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.goHome(),
                child: const Text('返回首页'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 主Tab页组件
class MainTabPage extends StatelessWidget {
  const MainTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('主Tab页面'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '购物车',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.goTab('home');
              break;
            case 1:
              context.goTab('category');
              break;
            case 2:
              context.goTab('cart');
              break;
            case 3:
              context.goTab('message');
              break;
            case 4:
              context.goTab('profile');
              break;
          }
        },
      ),
    );
  }
}

/// Tab首页组件
class TabHomePage extends StatelessWidget {
  const TabHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tab首页'),
      ),
    );
  }
}

/// Tab分类页组件
class TabCategoryPage extends StatelessWidget {
  const TabCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tab分类页'),
      ),
    );
  }
}

/// Tab购物车页组件
class TabCartPage extends StatelessWidget {
  const TabCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tab购物车页'),
      ),
    );
  }
}

/// Tab消息页组件
class TabMessagePage extends StatelessWidget {
  const TabMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tab消息页'),
      ),
    );
  }
}

/// Tab个人页组件
class TabProfilePage extends StatelessWidget {
  const TabProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tab个人页'),
      ),
    );
  }
}

/// 搜索页组件
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('搜索'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('搜索页面'),
      ),
    );
  }
}

/// 设置页组件
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('设置页面'),
      ),
    );
  }
}

/// 关于页组件
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('关于页面'),
      ),
    );
  }
}

/// 颜色示例页组件
class ColorExamplePage extends StatelessWidget {
  const ColorExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('颜色示例'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('颜色示例页面'),
      ),
    );
  }
}

/// 底部弹窗示例页组件
class BottomSheetExamplePage extends StatelessWidget {
  const BottomSheetExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('底部弹窗示例'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('底部弹窗示例页面'),
      ),
    );
  }
}

/// 居中对话框示例页组件
class CenterDialogExamplePage extends StatelessWidget {
  const CenterDialogExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('居中对话框示例'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('居中对话框示例页面'),
      ),
    );
  }
}
