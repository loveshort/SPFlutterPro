/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-24 10:28:36
 * @FilePath: /SPFlutterPro/lib/module/home/home_page.dart
 * @Description: 首页
 */
import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:flutter/material.dart';
import 'package:common_widgets_utils/common_widgets_utils.dart';
import '../../router/simple_router.dart';
import '../../router/routes.dart';

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
        title: const Text('首页'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '您已经点击按钮这么多次:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const DashedLine(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SimpleRouter.toNamed(Routes.colorExample);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('颜色工具示例'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                SimpleRouter.toNamed(Routes.bottomSheetExample);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('底部弹窗示例'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                SimpleRouter.toNamed(Routes.centerDialogExample);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('中间弹窗示例'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                SimpleRouter.toNamed(Routes.bottomTabExample);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('底部Tab示例'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                SimpleRouter.toNamed(Routes.advancedBottomTabExample);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text('高级底部Tab示例'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SimpleRouter.showSuccess('这是一个成功提示！');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.success,
                foregroundColor: Colors.white,
              ),
              child: const Text('显示成功提示'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                SimpleRouter.showError('这是一个错误提示！');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('显示错误提示'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
