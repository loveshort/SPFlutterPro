/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/getX/pages/todo_list_page.dart
 * @Description: Todo列表页面 - GetX响应式UI
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import '../utils/color_manager.dart';
import 'todo_detail_page.dart';
import 'todo_form_page.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化控制器
    final TodoController controller = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('待办事项'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // 过滤器按钮
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context, controller),
          ),
          // 统计信息按钮
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => _showStatisticsDialog(context, controller),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.isNotEmpty) {
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
                  controller.errorMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorManager.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshTodos(),
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        final filteredTodos = controller.filteredTodos;

        if (filteredTodos.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.checklist,
                  size: 64,
                  color: ColorManager.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  controller.searchQuery.isNotEmpty ? '没有找到匹配的待办事项' : '暂无待办事项',
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorManager.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.to(() => const TodoFormPage()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('添加待办事项'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // 搜索栏
            _buildSearchBar(controller),

            // 过滤器标签
            _buildFilterTags(controller),

            // 待办事项列表
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshTodos,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredTodos.length,
                  itemBuilder: (context, index) {
                    final todo = filteredTodos[index];
                    return _buildTodoCard(todo, controller);
                  },
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const TodoFormPage()),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  // 构建搜索栏
  Widget _buildSearchBar(TodoController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: controller.setSearchQuery,
        decoration: InputDecoration(
          hintText: '搜索待办事项...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => controller.setSearchQuery(''),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorManager.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorManager.primary, width: 2),
          ),
        ),
      ),
    );
  }

  // 构建过滤器标签
  Widget _buildFilterTags(TodoController controller) {
    return Obx(() {
      final hasFilters = controller.searchQuery.isNotEmpty ||
          controller.selectedPriority != null ||
          controller.selectedCategory.isNotEmpty ||
          !controller.showCompleted;

      if (!hasFilters) return const SizedBox.shrink();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 8,
          children: [
            if (controller.searchQuery.isNotEmpty)
              Chip(
                label: Text('搜索: ${controller.searchQuery}'),
                onDeleted: () => controller.setSearchQuery(''),
                deleteIcon: const Icon(Icons.close, size: 18),
              ),
            if (controller.selectedPriority != null)
              Chip(
                label: Text('优先级: ${controller.selectedPriority!.label}'),
                onDeleted: () => controller.setPriorityFilter(null),
                deleteIcon: const Icon(Icons.close, size: 18),
              ),
            if (controller.selectedCategory.isNotEmpty)
              Chip(
                label: Text('分类: ${controller.selectedCategory}'),
                onDeleted: () => controller.setCategoryFilter(''),
                deleteIcon: const Icon(Icons.close, size: 18),
              ),
            if (!controller.showCompleted)
              Chip(
                label: const Text('仅未完成'),
                onDeleted: () => controller.toggleShowCompleted(),
                deleteIcon: const Icon(Icons.close, size: 18),
              ),
            Chip(
              label: const Text('清除所有'),
              onDeleted: controller.clearFilters,
              backgroundColor: ColorManager.error.withOpacity(0.1),
              deleteIcon:
                  Icon(Icons.clear_all, size: 18, color: ColorManager.error),
            ),
          ],
        ),
      );
    });
  }

  // 构建待办事项卡片
  Widget _buildTodoCard(TodoModel todo, TodoController controller) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => Get.to(() => TodoDetailPage(todoId: todo.id)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 完成状态复选框
              Checkbox(
                value: todo.isCompleted,
                onChanged: (value) => controller.toggleTodoStatus(todo.id),
                activeColor: ColorManager.success,
              ),

              // 待办事项内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: todo.isCompleted
                            ? ColorManager.textSecondary
                            : ColorManager.textPrimary,
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // 描述
                    Text(
                      todo.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorManager.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // 标签行
                    Row(
                      children: [
                        // 优先级标签
                        _buildPriorityChip(todo.priority),
                        const SizedBox(width: 8),

                        // 分类标签
                        Chip(
                          label: Text(
                            todo.category,
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor:
                              ColorManager.primary.withOpacity(0.1),
                          labelStyle: TextStyle(color: ColorManager.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 操作按钮
              PopupMenuButton<String>(
                onSelected: (value) =>
                    _handleMenuAction(value, todo, controller),
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
        ),
      ),
    );
  }

  // 构建优先级标签
  Widget _buildPriorityChip(Priority priority) {
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

    return Chip(
      label: Text(
        priority.label,
        style: TextStyle(fontSize: 12, color: textColor),
      ),
      backgroundColor: backgroundColor,
    );
  }

  // 处理菜单操作
  void _handleMenuAction(
      String action, TodoModel todo, TodoController controller) {
    switch (action) {
      case 'edit':
        Get.to(() => TodoFormPage(todo: todo));
        break;
      case 'delete':
        _showDeleteConfirmDialog(todo, controller);
        break;
    }
  }

  // 显示删除确认对话框
  void _showDeleteConfirmDialog(TodoModel todo, TodoController controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除"${todo.title}"吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteTodo(todo.id);
            },
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  // 显示过滤器底部弹窗
  void _showFilterBottomSheet(BuildContext context, TodoController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '过滤器',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // 优先级过滤
            Text(
              '优先级',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('全部'),
                      selected: controller.selectedPriority == null,
                      onSelected: (selected) =>
                          controller.setPriorityFilter(null),
                    ),
                    ...Priority.values.map((priority) => FilterChip(
                          label: Text(priority.label),
                          selected: controller.selectedPriority == priority,
                          onSelected: (selected) =>
                              controller.setPriorityFilter(priority),
                        )),
                  ],
                )),

            const SizedBox(height: 20),

            // 分类过滤
            Text(
              '分类',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() => Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('全部'),
                      selected: controller.selectedCategory.isEmpty,
                      onSelected: (selected) =>
                          controller.setCategoryFilter(''),
                    ),
                    ...TodoCategory.values.map((category) => FilterChip(
                          label: Text(category.label),
                          selected:
                              controller.selectedCategory == category.label,
                          onSelected: (selected) =>
                              controller.setCategoryFilter(category.label),
                        )),
                  ],
                )),

            const SizedBox(height: 20),

            // 完成状态过滤
            Obx(() => SwitchListTile(
                  title: const Text('显示已完成的待办事项'),
                  value: controller.showCompleted,
                  onChanged: (value) => controller.toggleShowCompleted(),
                )),

            const SizedBox(height: 20),

            // 操作按钮
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.clearFilters,
                    child: const Text('清除所有'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('确定'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 显示统计信息对话框
  void _showStatisticsDialog(BuildContext context, TodoController controller) {
    final stats = controller.statistics;

    Get.dialog(
      AlertDialog(
        title: const Text('统计信息'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatItem('总计', stats['total'] ?? 0, ColorManager.primary),
            _buildStatItem(
                '已完成', stats['completed'] ?? 0, ColorManager.success),
            _buildStatItem(
                '未完成', stats['incomplete'] ?? 0, ColorManager.warning),
            _buildStatItem('高优先级', stats['highPriority'] ?? 0, Colors.orange),
            _buildStatItem('紧急', stats['urgent'] ?? 0, ColorManager.error),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('关闭'),
          ),
          if (stats['completed']! > 0)
            TextButton(
              onPressed: () {
                Get.back();
                _showDeleteCompletedConfirmDialog(controller);
              },
              style: TextButton.styleFrom(foregroundColor: ColorManager.error),
              child: const Text('删除已完成'),
            ),
        ],
      ),
    );
  }

  // 构建统计项
  Widget _buildStatItem(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 显示删除已完成确认对话框
  void _showDeleteCompletedConfirmDialog(TodoController controller) {
    final completedCount = controller.statistics['completed'] ?? 0;

    Get.dialog(
      AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除所有已完成的待办事项吗？\n共 $completedCount 个'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteCompletedTodos();
            },
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
