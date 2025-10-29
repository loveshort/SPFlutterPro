/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/getX/pages/todo_form_page.dart
 * @Description: Todo添加/编辑页面 - GetX表单处理
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../models/todo_model.dart';
import '../utils/color_manager.dart';

class TodoFormPage extends StatefulWidget {
  final TodoModel? todo;

  const TodoFormPage({
    super.key,
    this.todo,
  });

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  final TodoController _controller = Get.find<TodoController>();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Priority _selectedPriority = Priority.medium;
  String _selectedCategory = '默认';
  bool _isLoading = false;

  bool get _isEditing => widget.todo != null;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // 初始化表单
  void _initializeForm() {
    if (_isEditing) {
      final todo = widget.todo!;
      _titleController.text = todo.title;
      _descriptionController.text = todo.description;
      _selectedPriority = todo.priority;
      _selectedCategory = todo.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '编辑待办事项' : '添加待办事项'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 基本信息卡片
              _buildBasicInfoCard(),

              const SizedBox(height: 20),

              // 优先级选择卡片
              _buildPriorityCard(),

              const SizedBox(height: 20),

              // 分类选择卡片
              _buildCategoryCard(),

              const SizedBox(height: 20),

              // 预览卡片
              _buildPreviewCard(),

              const SizedBox(height: 30),

              // 操作按钮
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // 构建基本信息卡片
  Widget _buildBasicInfoCard() {
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

            // 标题输入框
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '标题',
                hintText: '请输入待办事项标题',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManager.primary, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '标题不能为空';
                }
                if (value.trim().length < 2) {
                  return '标题至少需要2个字符';
                }
                return null;
              },
              onChanged: (value) => setState(() {}),
            ),

            const SizedBox(height: 16),

            // 描述输入框
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: '描述',
                hintText: '请输入待办事项的详细描述',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManager.primary, width: 2),
                ),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '描述不能为空';
                }
                if (value.trim().length < 5) {
                  return '描述至少需要5个字符';
                }
                return null;
              },
              onChanged: (value) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  // 构建优先级选择卡片
  Widget _buildPriorityCard() {
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
                  Icons.priority_high,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '优先级',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: Priority.values.map((priority) {
                final isSelected = _selectedPriority == priority;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPriority = priority),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _getPriorityColor(priority).withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? _getPriorityColor(priority)
                            : Colors.grey.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.priority_high,
                          size: 16,
                          color: isSelected
                              ? _getPriorityColor(priority)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          priority.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? _getPriorityColor(priority)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // 构建分类选择卡片
  Widget _buildCategoryCard() {
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
                  '分类',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: TodoCategory.values.map((category) {
                final isSelected = _selectedCategory == category.label;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedCategory = category.label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorManager.primary.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? ColorManager.primary
                            : Colors.grey.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.category,
                          size: 16,
                          color:
                              isSelected ? ColorManager.primary : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color:
                                isSelected ? ColorManager.primary : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // 构建预览卡片
  Widget _buildPreviewCard() {
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
                  Icons.preview,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '预览',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 预览内容
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题预览
                  if (_titleController.text.isNotEmpty)
                    Text(
                      _titleController.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.textPrimary,
                      ),
                    ),

                  if (_titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty)
                    const SizedBox(height: 8),

                  // 描述预览
                  if (_descriptionController.text.isNotEmpty)
                    Text(
                      _descriptionController.text,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorManager.textSecondary,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                  if (_titleController.text.isNotEmpty ||
                      _descriptionController.text.isNotEmpty)
                    const SizedBox(height: 8),

                  // 标签预览
                  Row(
                    children: [
                      _buildPriorityChip(_selectedPriority),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(
                          _selectedCategory,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: ColorManager.primary.withOpacity(0.1),
                        labelStyle: TextStyle(color: ColorManager.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建操作按钮
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Get.back(),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.textSecondary,
              side: BorderSide(color: ColorManager.border),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('取消'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(_isEditing ? '更新' : '添加'),
          ),
        ),
      ],
    );
  }

  // 构建优先级标签
  Widget _buildPriorityChip(Priority priority) {
    return Chip(
      label: Text(
        priority.label,
        style: TextStyle(
          fontSize: 12,
          color: _getPriorityColor(priority),
        ),
      ),
      backgroundColor: _getPriorityColor(priority).withOpacity(0.1),
    );
  }

  // 获取优先级颜色
  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.urgent:
        return ColorManager.error;
      case Priority.high:
        return Colors.orange;
      case Priority.medium:
        return Colors.blue;
      case Priority.low:
        return Colors.green;
    }
  }

  // 处理提交
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      bool success;

      if (_isEditing) {
        // 更新现有待办事项
        final updatedTodo = widget.todo!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _selectedPriority,
          category: _selectedCategory,
        );
        success = await _controller.updateTodo(updatedTodo);
      } else {
        // 添加新待办事项
        success = await _controller.addTodo(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _selectedPriority,
          category: _selectedCategory,
        );
      }

      if (success) {
        Get.back();
      }
    } catch (e) {
      print('提交待办事项失败: $e');
      Get.snackbar(
        '错误',
        '操作失败，请重试',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorManager.error,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
