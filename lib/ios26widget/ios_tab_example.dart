import 'package:flutter/material.dart';
import 'package:sp_flutter_shopping/ios26widget/ios_tab_widdget.dart';

class IOSTabExample extends StatelessWidget {
  const IOSTabExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iOS Tab Widget Example'),
      ),
      body: Column(
        children: [
          // Flutter Tab Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text('Flutter Tab Bar：',
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          IOSTabWidget(
            tabs: const ['Home', 'Discover', 'Notifications', 'Profile'],
            initialIndex: 0,
            onTabChanged: (index) {
              print('Tab changed to: \$index');
            },
          ),
          const SizedBox(height: 32),
          // Description
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text('iOS 26 及以上：通过原生 UITabBarController 展示并同步选中；\n'
                'iOS 26 以下：沿用 Flutter 实现，仅更新 Flutter UI。\n\n'
                '点击上面的 Tab 将会：\n'
                '1. 更新 Flutter 界面的选中态；\n'
                '2. 若为 iOS 26+，同时调用原生代码展示并切换对应原生 Tab。',
                style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
