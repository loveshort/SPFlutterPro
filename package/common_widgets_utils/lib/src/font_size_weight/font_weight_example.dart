import 'package:flutter/material.dart';
import 'font_weight_manager.dart';

/// 字体粗细管理器使用示例
class FontWeightExample extends StatelessWidget {
  const FontWeightExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '字体粗细统一示例',
          style: TextStyle(
            fontWeight: FontWeightManager.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 平台信息
            _buildPlatformInfo(),
            const SizedBox(height: 20),

            // 使用预定义常量
            _buildPredefinedWeights(),
            const SizedBox(height: 20),

            // 使用扩展方法
            _buildExtensionMethods(),
            const SizedBox(height: 20),

            // 对比示例
            _buildComparisonExample(),
            const SizedBox(height: 20),

            // 实际应用示例
            _buildRealWorldExample(),
          ],
        ),
      ),
    );
  }

  /// 平台信息显示
  Widget _buildPlatformInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '当前平台信息',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '平台: ${FontWeightManager.platformInfo}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeightManager.normal,
              ),
            ),
            Text(
              'Android: ${FontWeightManager.isAndroid}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeightManager.normal,
              ),
            ),
            Text(
              'iOS: ${FontWeightManager.isIOS}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeightManager.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 预定义字体粗细示例
  Widget _buildPredefinedWeights() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '预定义字体粗细常量',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildWeightItem('超细字体', FontWeightManager.ultraLight),
            _buildWeightItem('极细字体', FontWeightManager.extraLight),
            _buildWeightItem('细字体', FontWeightManager.light),
            _buildWeightItem('正常字体', FontWeightManager.normal),
            _buildWeightItem('中等字体', FontWeightManager.medium),
            _buildWeightItem('半粗字体', FontWeightManager.semiBold),
            _buildWeightItem('粗字体', FontWeightManager.bold),
            _buildWeightItem('超粗字体', FontWeightManager.extraBold),
            _buildWeightItem('极粗字体', FontWeightManager.ultraBold),
          ],
        ),
      ),
    );
  }

  /// 扩展方法示例
  Widget _buildExtensionMethods() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '扩展方法使用示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '使用TextStyle扩展方法:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeightManager.normal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '这是使用统一字体粗细的文本',
              style: TextStyle(fontSize: 16).unifiedFontWeight(FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              '使用Text.unified静态方法:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeightManager.normal,
              ),
            ),
            const SizedBox(height: 8),
            TextExtension.unified(
              '这是使用Text.unified创建的文本',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  /// 对比示例
  Widget _buildComparisonExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '对比示例 (原始 vs 统一)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '原始字体粗细:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeightManager.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('细字体',
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      Text('正常字体',
                          style: TextStyle(fontWeight: FontWeight.w400)),
                      Text('粗字体',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '统一字体粗细:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeightManager.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('细字体',
                          style:
                              TextStyle(fontWeight: FontWeightManager.light)),
                      Text('正常字体',
                          style:
                              TextStyle(fontWeight: FontWeightManager.normal)),
                      Text('粗字体',
                          style: TextStyle(fontWeight: FontWeightManager.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 实际应用示例
  Widget _buildRealWorldExample() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '实际应用示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 12),

            // 标题示例
            Text(
              '文章标题',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeightManager.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // 副标题示例
            Text(
              '副标题',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeightManager.semiBold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),

            // 正文示例
            Text(
              '这是正文内容，使用统一的正常字体粗细，在Android和iOS平台上会有一致的视觉效果。',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeightManager.normal,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),

            // 按钮示例
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                '按钮文字',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建字体粗细项目
  Widget _buildWeightItem(String label, FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: weight,
        ),
      ),
    );
  }
}
