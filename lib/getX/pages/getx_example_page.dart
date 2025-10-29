/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/getX/pages/getx_example_page.dart
 * @Description: GetX示例入口页面 - 展示GetX功能特性
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/todo_service.dart';
import '../utils/color_manager.dart';
import 'todo_list_page.dart';

class GetXExamplePage extends StatelessWidget {
  const GetXExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX 完美示例'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 介绍卡片
            _buildIntroCard(),

            const SizedBox(height: 20),

            // 功能特性卡片
            _buildFeaturesCard(),

            const SizedBox(height: 20),

            // 示例演示卡片
            _buildDemoCard(),

            const SizedBox(height: 20),

            // 技术架构卡片
            _buildArchitectureCard(),

            const SizedBox(height: 20),

            // 开始体验按钮
            _buildStartButton(),
          ],
        ),
      ),
    );
  }

  // 构建介绍卡片
  Widget _buildIntroCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              ColorManager.primary.withOpacity(0.1),
              ColorManager.primary.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.rocket_launch,
                  size: 32,
                  color: ColorManager.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'GetX 完美示例',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '这是一个完整的GetX状态管理示例，展示了响应式编程、依赖注入、路由管理等核心功能。通过待办事项应用，您可以学习到GetX的最佳实践。',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建功能特性卡片
  Widget _buildFeaturesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '核心特性',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              icon: Icons.speed,
              title: '响应式状态管理',
              description: '使用Obx和Rx变量实现自动UI更新',
            ),
            _buildFeatureItem(
              icon: Icons.integration_instructions,
              title: '依赖注入',
              description: '通过Get.put和Get.find管理服务依赖',
            ),
            _buildFeatureItem(
              icon: Icons.route,
              title: '路由管理',
              description: 'Get.to、Get.back等便捷导航方法',
            ),
            _buildFeatureItem(
              icon: Icons.notifications,
              title: '消息提示',
              description: 'Get.snackbar、Get.dialog等UI反馈',
            ),
            _buildFeatureItem(
              icon: Icons.build,
              title: '服务层架构',
              description: '分离业务逻辑和数据操作',
            ),
          ],
        ),
      ),
    );
  }

  // 构建示例演示卡片
  Widget _buildDemoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.play_circle,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '示例演示',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDemoItem(
              icon: Icons.list,
              title: '待办事项列表',
              description: '展示响应式列表、搜索、过滤功能',
              onTap: () => _startTodoApp(),
            ),
            _buildDemoItem(
              icon: Icons.add_circle,
              title: '表单处理',
              description: '演示GetX表单验证和数据绑定',
              onTap: () => _startTodoApp(),
            ),
            _buildDemoItem(
              icon: Icons.details,
              title: '详情页面',
              description: '展示页面间数据传递和状态同步',
              onTap: () => _startTodoApp(),
            ),
            _buildDemoItem(
              icon: Icons.analytics,
              title: '统计功能',
              description: '演示数据统计和图表展示',
              onTap: () => _startTodoApp(),
            ),
          ],
        ),
      ),
    );
  }

  // 构建技术架构卡片
  Widget _buildArchitectureCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.architecture,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '技术架构',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildArchitectureItem(
              'Model层',
              'TodoModel - 数据模型定义',
              Icons.data_object,
            ),
            _buildArchitectureItem(
              'Service层',
              'TodoService - 业务逻辑处理',
              Icons.business,
            ),
            _buildArchitectureItem(
              'Controller层',
              'TodoController - 状态管理控制',
              Icons.control_camera,
            ),
            _buildArchitectureItem(
              'View层',
              'Pages - UI界面展示',
              Icons.view_module,
            ),
          ],
        ),
      ),
    );
  }

  // 构建开始体验按钮
  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _startTodoApp,
        icon: const Icon(Icons.play_arrow),
        label: const Text('开始体验 GetX 示例'),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // 构建功能项
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: ColorManager.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建演示项
  Widget _buildDemoItem({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: ColorManager.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ColorManager.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // 构建架构项
  Widget _buildArchitectureItem(
      String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 开始体验待办事项应用
  void _startTodoApp() {
    // 确保服务已初始化
    Get.put(TodoService(), permanent: true);

    Get.to(() => const TodoListPage());

    // 显示欢迎消息
    Get.snackbar(
      '欢迎体验',
      'GetX 待办事项应用已启动！',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorManager.success,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
