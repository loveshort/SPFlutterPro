/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/getX/controllers/todo_controller.dart
 * @Description: Todo控制器 - GetX状态管理
 */

import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';

class TodoController extends GetxController {
  // 服务依赖注入
  final TodoService _todoService = Get.find<TodoService>();

  // 响应式状态变量
  final RxList<TodoModel> _todos = <TodoModel>[].obs;
  final RxString _searchQuery = ''.obs;
  final Rx<Priority?> _selectedPriority = Rx<Priority?>(null);
  final RxString _selectedCategory = ''.obs;
  final RxBool _showCompleted = true.obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  List<TodoModel> get todos => _todos;
  String get searchQuery => _searchQuery.value;
  Priority? get selectedPriority => _selectedPriority.value;
  String get selectedCategory => _selectedCategory.value;
  bool get showCompleted => _showCompleted.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // 过滤后的待办事项
  List<TodoModel> get filteredTodos {
    List<TodoModel> filtered = _todos;

    // 按搜索查询过滤
    if (_searchQuery.value.isNotEmpty) {
      filtered = _todoService.searchTodos(_searchQuery.value);
    }

    // 按优先级过滤
    if (_selectedPriority.value != null) {
      filtered = filtered
          .where((todo) => todo.priority == _selectedPriority.value)
          .toList();
    }

    // 按分类过滤
    if (_selectedCategory.value.isNotEmpty) {
      filtered = filtered
          .where((todo) => todo.category == _selectedCategory.value)
          .toList();
    }

    // 按完成状态过滤
    if (!_showCompleted.value) {
      filtered = filtered.where((todo) => !todo.isCompleted).toList();
    }

    // 按优先级排序
    filtered.sort((a, b) {
      final priorityOrder = {
        Priority.urgent: 0,
        Priority.high: 1,
        Priority.medium: 2,
        Priority.low: 3,
      };
      return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
    });

    return filtered;
  }

  // 统计信息
  Map<String, int> get statistics => _todoService.getStatistics();

  @override
  void onInit() {
    super.onInit();
    _loadTodos();
    LogUtils.i('TodoController 初始化完成');
  }

  @override
  void onReady() {
    super.onReady();
    LogUtils.i('TodoController 准备就绪');
  }

  @override
  void onClose() {
    LogUtils.i('TodoController 已关闭');
    super.onClose();
  }

  // 加载待办事项
  Future<void> _loadTodos() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // 模拟网络延迟
      await Future.delayed(const Duration(milliseconds: 800));

      _todos.value = _todoService.todos;
      LogUtils.i('加载待办事项: ${_todos.length} 个');
    } catch (e) {
      _errorMessage.value = '加载失败: $e';
      LogUtils.e('加载待办事项失败: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  // 刷新数据
  Future<void> refreshTodos() async {
    await _loadTodos();
  }

  // 添加待办事项
  Future<bool> addTodo({
    required String title,
    required String description,
    Priority priority = Priority.medium,
    String category = '默认',
  }) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final newTodo = TodoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        priority: priority,
        category: category,
        createdAt: DateTime.now(),
      );

      final success = await _todoService.addTodo(newTodo);
      if (success) {
        _todos.value = _todoService.todos;
        Get.snackbar(
          '成功',
          '待办事项已添加',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.success,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        LogUtils.i('添加待办事项成功: $title');
      } else {
        _errorMessage.value = '添加失败';
        Get.snackbar(
          '错误',
          '添加待办事项失败',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.error,
          colorText: Colors.white,
        );
      }
      return success;
    } catch (e) {
      _errorMessage.value = '添加失败: $e';
      LogUtils.e('添加待办事项异常: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // 更新待办事项
  Future<bool> updateTodo(TodoModel todo) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final success = await _todoService.updateTodo(todo);
      if (success) {
        _todos.value = _todoService.todos;
        Get.snackbar(
          '成功',
          '待办事项已更新',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.success,
          colorText: Colors.white,
        );
        LogUtils.i('更新待办事项成功: ${todo.title}');
      } else {
        _errorMessage.value = '更新失败';
        Get.snackbar(
          '错误',
          '更新待办事项失败',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.error,
          colorText: Colors.white,
        );
      }
      return success;
    } catch (e) {
      _errorMessage.value = '更新失败: $e';
      LogUtils.e('更新待办事项异常: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // 删除待办事项
  Future<bool> deleteTodo(String id) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final success = await _todoService.deleteTodo(id);
      if (success) {
        _todos.value = _todoService.todos;
        Get.snackbar(
          '成功',
          '待办事项已删除',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.success,
          colorText: Colors.white,
        );
        LogUtils.i('删除待办事项成功: $id');
      } else {
        _errorMessage.value = '删除失败';
        Get.snackbar(
          '错误',
          '删除待办事项失败',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.error,
          colorText: Colors.white,
        );
      }
      return success;
    } catch (e) {
      _errorMessage.value = '删除失败: $e';
      LogUtils.e('删除待办事项异常: $e');
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  // 切换完成状态
  Future<bool> toggleTodoStatus(String id) async {
    try {
      final success = await _todoService.toggleTodoStatus(id);
      if (success) {
        _todos.value = _todoService.todos;
        LogUtils.i('切换待办事项状态成功: $id');
      }
      return success;
    } catch (e) {
      LogUtils.e('切换待办事项状态异常: $e');
      return false;
    }
  }

  // 批量删除已完成的待办事项
  Future<int> deleteCompletedTodos() async {
    try {
      _isLoading.value = true;
      final deletedCount = await _todoService.deleteCompletedTodos();
      if (deletedCount > 0) {
        _todos.value = _todoService.todos;
        Get.snackbar(
          '成功',
          '已删除 $deletedCount 个已完成的待办事项',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorManager.success,
          colorText: Colors.white,
        );
        LogUtils.i('批量删除已完成待办事项: $deletedCount 个');
      }
      return deletedCount;
    } catch (e) {
      LogUtils.e('批量删除异常: $e');
      return 0;
    } finally {
      _isLoading.value = false;
    }
  }

  // 设置搜索查询
  void setSearchQuery(String query) {
    _searchQuery.value = query;
    LogUtils.d('搜索查询: $query');
  }

  // 设置优先级过滤
  void setPriorityFilter(Priority? priority) {
    _selectedPriority.value = priority;
    LogUtils.d('优先级过滤: $priority');
  }

  // 设置分类过滤
  void setCategoryFilter(String category) {
    _selectedCategory.value = category;
    LogUtils.d('分类过滤: $category');
  }

  // 切换显示已完成
  void toggleShowCompleted() {
    _showCompleted.value = !_showCompleted.value;
    LogUtils.d('显示已完成: ${_showCompleted.value}');
  }

  // 清除所有过滤器
  void clearFilters() {
    _searchQuery.value = '';
    _selectedPriority.value = null;
    _selectedCategory.value = '';
    _showCompleted.value = true;
    LogUtils.d('清除所有过滤器');
  }

  // 获取待办事项详情
  TodoModel? getTodoById(String id) {
    try {
      return _todos.firstWhere((todo) => todo.id == id);
    } catch (e) {
      LogUtils.e('获取待办事项详情失败: $e');
      return null;
    }
  }

  // 验证待办事项数据
  String? validateTodoData({
    required String title,
    required String description,
  }) {
    if (title.trim().isEmpty) {
      return '标题不能为空';
    }
    if (title.trim().length < 2) {
      return '标题至少需要2个字符';
    }
    if (description.trim().isEmpty) {
      return '描述不能为空';
    }
    if (description.trim().length < 5) {
      return '描述至少需要5个字符';
    }
    return null;
  }
}
