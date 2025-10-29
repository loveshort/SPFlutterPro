/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/getX/pages/todo_detail_page.dart
 * @Description: Todo详情页面 - GetX响应式UI
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import '../utils/color_manager.dart';
import 'todo_form_page.dart';

class TodoDetailPage extends StatelessWidget {
  final String todoId;

  const TodoDetailPage({
    super.key,
    required this.todoId,
  });

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find<TodoController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('待办事项详情'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final todo = controller.getTodoById(todoId);
              if (todo != null) {
                Get.to(() => TodoFormPage(todo: todo));
              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value, controller),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('编辑'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('删除', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        final todo = controller.getTodoById(todoId);

        if (todo == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: ColorManager.error,
                ),
                const SizedBox(height: 16),
                Text(
                  '待办事项不存在',
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorManager.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('返回'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 完成状态卡片
              _buildStatusCard(todo, controller),

              const SizedBox(height: 20),

              // 基本信息卡片
              _buildInfoCard(todo),

              const SizedBox(height: 20),

              // 优先级和分类卡片
              _buildPriorityCategoryCard(todo),

              const SizedBox(height: 20),

              // 时间信息卡片
              _buildTimeCard(todo),

              const SizedBox(height: 20),

              // 操作按钮
              _buildActionButtons(todo, controller),
            ],
          ),
        );
      }),
    );
  }

  // 构建状态卡片
  Widget _buildStatusCard(TodoModel todo, TodoController controller) {
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
            colors: todo.isCompleted
                ? [
                    ColorManager.success.withOpacity(0.1),
                    ColorManager.success.withOpacity(0.05)
                  ]
                : [
                    ColorManager.primary.withOpacity(0.1),
                    ColorManager.primary.withOpacity(0.05)
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Icon(
              todo.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              size: 48,
              color: todo.isCompleted
                  ? ColorManager.success
                  : ColorManager.primary,
            ),
            const SizedBox(height: 12),
            Text(
              todo.isCompleted ? '已完成' : '进行中',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: todo.isCompleted
                    ? ColorManager.success
                    : ColorManager.primary,
              ),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: Text(
                todo.isCompleted ? '标记为未完成' : '标记为完成',
                style: TextStyle(
                  fontSize: 16,
                  color: ColorManager.textPrimary,
                ),
              ),
              value: todo.isCompleted,
              onChanged: (value) => controller.toggleTodoStatus(todo.id),
              activeColor: ColorManager.success,
            ),
          ],
        ),
      ),
    );
  }

  // 构建信息卡片
  Widget _buildInfoCard(TodoModel todo) {
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
                  Icons.info_outline,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '基本信息',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 标题
            _buildInfoRow('标题', todo.title, Icons.title),
            const SizedBox(height: 12),

            // 描述
            _buildInfoRow('描述', todo.description, Icons.description),
          ],
        ),
      ),
    );
  }

  // 构建优先级和分类卡片
  Widget _buildPriorityCategoryCard(TodoModel todo) {
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
                  Icons.category,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '分类信息',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildPriorityBadge(todo.priority),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCategoryBadge(todo.category),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建时间信息卡片
  Widget _buildTimeCard(TodoModel todo) {
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
                  Icons.access_time,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '时间信息',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 创建时间
            _buildTimeRow('创建时间', todo.createdAt, Icons.add_circle_outline),
            const SizedBox(height: 12),

            // 完成时间
            if (todo.completedAt != null)
              _buildTimeRow(
                  '完成时间', todo.completedAt!, Icons.check_circle_outline),

            const SizedBox(height: 12),

            // 持续时间
            if (todo.completedAt != null)
              _buildDurationRow(todo.createdAt, todo.completedAt!),
          ],
        ),
      ),
    );
  }

  // 构建操作按钮
  Widget _buildActionButtons(TodoModel todo, TodoController controller) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Get.to(() => TodoFormPage(todo: todo));
            },
            icon: const Icon(Icons.edit),
            label: const Text('编辑'),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.primary,
              side: BorderSide(color: ColorManager.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showDeleteConfirmDialog(todo, controller),
            icon: const Icon(Icons.delete),
            label: const Text('删除'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.error,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  // 构建信息行
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: ColorManager.textSecondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorManager.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 构建时间行
  Widget _buildTimeRow(String label, DateTime dateTime, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: ColorManager.textSecondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorManager.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDateTime(dateTime),
                style: TextStyle(
                  fontSize: 16,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 构建持续时间行
  Widget _buildDurationRow(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    String durationText = '';
    if (days > 0) durationText += '${days}天';
    if (hours > 0) durationText += '${hours}小时';
    if (minutes > 0) durationText += '${minutes}分钟';
    if (durationText.isEmpty) durationText = '不到1分钟';

    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 16,
          color: ColorManager.textSecondary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '持续时间',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorManager.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                durationText,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorManager.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 构建优先级标签
  Widget _buildPriorityBadge(Priority priority) {
    Color backgroundColor;
    Color textColor;

    switch (priority) {
      case Priority.urgent:
        backgroundColor = ColorManager.error.withOpacity(0.1);
        textColor = ColorManager.error;
        break;
      case Priority.high:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case Priority.medium:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        break;
      case Priority.low:
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.priority_high,
            size: 16,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            priority.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // 构建分类标签
  Widget _buildCategoryBadge(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.category,
            size: 16,
            color: ColorManager.primary,
          ),
          const SizedBox(width: 4),
          Text(
            category,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }

  // 格式化日期时间
  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}天前 (${dateTime.toString().split(' ')[0]})';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  // 处理菜单操作
  void _handleMenuAction(String action, TodoController controller) {
    switch (action) {
      case 'edit':
        final todo = controller.getTodoById(todoId);
        if (todo != null) {
          Get.to(() => TodoFormPage(todo: todo));
        }
        break;
      case 'delete':
        final todo = controller.getTodoById(todoId);
        if (todo != null) {
          _showDeleteConfirmDialog(todo, controller);
        }
        break;
    }
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog(TodoModel todo, TodoController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除"${todo.title}"吗？\n此操作无法撤销。'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteTodo(todo.id);
              Get.back(); // 返回列表页面
            },
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
