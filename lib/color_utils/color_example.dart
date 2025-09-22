/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 颜色工具使用示例
 */

import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'color_utils.dart';

/// 颜色工具使用示例
class ColorExample extends StatefulWidget {
  const ColorExample({super.key});

  @override
  State<ColorExample> createState() => _ColorExampleState();
}

class _ColorExampleState extends State<ColorExample> {
  bool _isDarkMode = false;
  Color _selectedColor = ColorManager.primary;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('颜色工具示例'),
        backgroundColor: ColorManager.getBackgroundColor(),
        foregroundColor: ColorManager.getTextPrimaryColor(),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
                ColorManager.setDarkMode(_isDarkMode);
              });
            },
          ),
        ],
      ),
      backgroundColor: ColorManager.getBackgroundColor(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 主题切换示例
            _buildThemeSection(),
            const SizedBox(height: 24),
            
            // 基础颜色示例
            _buildBasicColorsSection(),
            const SizedBox(height: 24),
            
            // 语义化颜色示例
            _buildSemanticColorsSection(),
            const SizedBox(height: 24),
            
            // 渐变色示例
            _buildGradientSection(),
            const SizedBox(height: 24),
            
            // 颜色工具示例
            _buildColorUtilsSection(),
            const SizedBox(height: 24),
            
            // 颜色生成示例
            _buildColorGenerationSection(),
            const SizedBox(height: 24),
            
            // 颜色分析示例
            _buildColorAnalysisSection(),
          ],
        ),
      ),
    );
  }
  
  /// 主题切换示例
  Widget _buildThemeSection() {
    return Card(
      color: ColorManager.getCardBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '主题切换',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: ColorManager.getBackgroundColor(),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorManager.getBorderColor()),
                    ),
                    child: Center(
                      child: Text(
                        '背景色',
                        style: TextStyle(color: ColorManager.getTextPrimaryColor()),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: ColorManager.getSurfaceColor(),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorManager.getBorderColor()),
                    ),
                    child: Center(
                      child: Text(
                        '表面色',
                        style: TextStyle(color: ColorManager.getTextPrimaryColor()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: ColorManager.getCardBackgroundColor(),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorManager.getBorderColor()),
                    ),
                    child: Center(
                      child: Text(
                        '卡片背景',
                        style: TextStyle(color: ColorManager.getTextPrimaryColor()),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: ColorManager.getDividerColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '分割线',
                        style: TextStyle(color: ColorManager.getTextPrimaryColor()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 基础颜色示例
  Widget _buildBasicColorsSection() {
    return Card(
      color: ColorManager.getCardBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '基础颜色',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 12),
            _buildColorRow('主色调', ColorManager.primaryColors),
            const SizedBox(height: 8),
            _buildColorRow('辅助色', ColorManager.secondaryColors),
            const SizedBox(height: 8),
            _buildColorRow('强调色', ColorManager.accentColors),
            const SizedBox(height: 8),
            _buildColorRow('中性色', ColorManager.neutralColors),
          ],
        ),
      ),
    );
  }
  
  /// 语义化颜色示例
  Widget _buildSemanticColorsSection() {
    return Card(
      color: ColorManager.getCardBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '语义化颜色',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSemanticColorCard('成功', ColorManager.success, Icons.check_circle),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSemanticColorCard('警告', ColorManager.warning, Icons.warning),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSemanticColorCard('错误', ColorManager.error, Icons.error),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSemanticColorCard('信息', ColorManager.info, Icons.info),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// 渐变色示例
  Widget _buildGradientSection() {
    return Card(
      color: ColorManager.getCardBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '渐变色',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 12),
            _buildGradientCard('主色调渐变', ColorManager.primaryGradient),
            const SizedBox(height: 12),
            _buildGradientCard('彩虹渐变', ColorManager.rainbowGradient),
            const SizedBox(height: 12),
            _buildGradientCard('日落渐变', ColorManager.sunsetGradient),
            const SizedBox(height: 12),
            _buildGradientCard('海洋渐变', ColorManager.oceanGradient),
          ],
        ),
      ),
    );
  }
  
  /// 颜色工具示例
  Widget _buildColorUtilsSection() {
    return Card(
      color: ColorManager.getCardBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '颜色工具',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '颜色转换:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 8),
            _buildColorConversionExample(),
            const SizedBox(height: 16),
            Text(
              '颜色混合:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 8),
            _buildColorBlendExample(),
          ],
        ),
      ),
    );
  }
  
  /// 颜色生成示例
  Widget _buildColorGenerationSection() {
    return Card(
      color: ColorManager.getCardBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '颜色生成',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedColor = ColorUtils.generateRandomColor();
                      });
                    },
                    child: const Text('随机颜色'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedColor = ColorUtils.generateRandomBrightColor();
                      });
                    },
                    child: const Text('明亮颜色'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedColor = ColorUtils.generateRandomSoftColor();
                      });
                    },
                    child: const Text('柔和颜色'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedColor = ColorUtils.getComplementaryColor(_selectedColor);
                      });
                    },
                    child: const Text('补色'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: _selectedColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorManager.getBorderColor()),
              ),
              child: Center(
                child: Text(
                  ColorUtils.colorToHex(_selectedColor),
                  style: TextStyle(
                    color: ColorUtils.getTextColorForBackground(_selectedColor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 颜色分析示例
  Widget _buildColorAnalysisSection() {
    return Card(
      color: ColorManager.getCardBackgroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '颜色分析',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.getTextPrimaryColor(),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorManager.getSurfaceColor(),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorManager.getBorderColor()),
              ),
              child: Text(
                ColorUtils.formatColorInfo(_selectedColor),
                style: TextStyle(
                  color: ColorManager.getTextPrimaryColor(),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '颜色名称: ${ColorUtils.getColorName(_selectedColor)}',
              style: TextStyle(
                color: ColorManager.getTextPrimaryColor(),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 构建颜色行
  Widget _buildColorRow(String title, List<Color> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorManager.getTextPrimaryColor(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: colors.map((color) {
            return Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: ColorManager.getBorderColor()),
                ),
                child: Center(
                  child: Text(
                    ColorUtils.colorToHex(color),
                    style: TextStyle(
                      color: ColorUtils.getTextColorForBackground(color),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  /// 构建语义化颜色卡片
  Widget _buildSemanticColorCard(String title, Color color, IconData icon) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  /// 构建渐变色卡片
  Widget _buildGradientCard(String title, LinearGradient gradient) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  /// 构建颜色转换示例
  Widget _buildColorConversionExample() {
    final originalColor = ColorManager.primary;
    final hexColor = ColorUtils.colorToHex(originalColor);
    final convertedColor = ColorUtils.hexToColor(hexColor);
    
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: originalColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '原始颜色',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.getTextSecondaryColor(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: convertedColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '转换后',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.getTextSecondaryColor(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Text(
                hexColor,
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.getTextPrimaryColor(),
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '十六进制',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.getTextSecondaryColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  /// 构建颜色混合示例
  Widget _buildColorBlendExample() {
    final color1 = ColorManager.primary;
    final color2 = ColorManager.secondary;
    final blendedColor = ColorUtils.blendColors(color1, color2, 0.5);
    
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: color1,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '颜色1',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.getTextSecondaryColor(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: blendedColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '混合后',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.getTextSecondaryColor(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '颜色2',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.getTextSecondaryColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
