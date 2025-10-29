/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/getX/services/todo_service.dart
 * @Description: Todo服务层 - 处理数据操作
 */

import 'package:get/get.dart';
import 'package:common_flutter_network/common_flutter_network.dart';
import '../models/todo_model.dart';

class TodoService extends GetxService {
  static TodoService get to => Get.find();

  // 模拟本地存储
  final List<TodoModel> _todos = <TodoModel>[];

  // 获取所有待办事项
  List<TodoModel> get todos => List.unmodifiable(_todos);

  // 获取未完成的待办事项
  List<TodoModel> get incompleteTodos =>
      _todos.where((todo) => !todo.isCompleted).toList();

  // 获取已完成的待办事项
  List<TodoModel> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();

  // 按优先级获取待办事项
  List<TodoModel> getTodosByPriority(Priority priority) =>
      _todos.where((todo) => todo.priority == priority).toList();

  // 按分类获取待办事项
  List<TodoModel> getTodosByCategory(String category) =>
      _todos.where((todo) => todo.category == category).toList();

  // 搜索待办事项
  List<TodoModel> searchTodos(String query) {
    if (query.isEmpty) return _todos;

    return _todos
        .where((todo) =>
            todo.title.toLowerCase().contains(query.toLowerCase()) ||
            todo.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // 添加待办事项
  Future<bool> addTodo(TodoModel todo) async {
    try {
      // 模拟网络延迟
      await Future.delayed(const Duration(milliseconds: 500));

      _todos.add(todo);
      LogUtils.i('添加待办事项: ${todo.title}');
      return true;
    } catch (e) {
      LogUtils.e('添加待办事项失败: $e');
      return false;
    }
  }

  // 更新待办事项
  Future<bool> updateTodo(TodoModel updatedTodo) async {
    try {
      // 模拟网络延迟
      await Future.delayed(const Duration(milliseconds: 300));

      final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
      if (index != -1) {
        _todos[index] = updatedTodo;
        LogUtils.i('更新待办事项: ${updatedTodo.title}');
        return true;
      }
      return false;
    } catch (e) {
      LogUtils.e('更新待办事项失败: $e');
      return false;
    }
  }

  // 删除待办事项
  Future<bool> deleteTodo(String id) async {
    try {
      // 模拟网络延迟
      await Future.delayed(const Duration(milliseconds: 200));

      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final deletedTodo = _todos.removeAt(index);
        LogUtils.i('删除待办事项: ${deletedTodo.title}');
        return true;
      }
      return false;
    } catch (e) {
      LogUtils.e('删除待办事项失败: $e');
      return false;
    }
  }

  // 切换完成状态
  Future<bool> toggleTodoStatus(String id) async {
    try {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final todo = _todos[index];
        final updatedTodo = todo.copyWith(
          isCompleted: !todo.isCompleted,
          completedAt: !todo.isCompleted ? DateTime.now() : null,
        );
        _todos[index] = updatedTodo;
        LogUtils.i(
            '切换待办事项状态: ${updatedTodo.title} -> ${updatedTodo.isCompleted ? "完成" : "未完成"}');
        return true;
      }
      return false;
    } catch (e) {
      LogUtils.e('切换待办事项状态失败: $e');
      return false;
    }
  }

  // 批量删除已完成的待办事项
  Future<int> deleteCompletedTodos() async {
    try {
      final completedCount = _todos.where((todo) => todo.isCompleted).length;
      _todos.removeWhere((todo) => todo.isCompleted);
      LogUtils.i('批量删除已完成待办事项: $completedCount 个');
      return completedCount;
    } catch (e) {
      LogUtils.e('批量删除失败: $e');
      return 0;
    }
  }

  // 获取统计信息
  Map<String, int> getStatistics() {
    return {
      'total': _todos.length,
      'completed': completedTodos.length,
      'incomplete': incompleteTodos.length,
      'highPriority': getTodosByPriority(Priority.high).length,
      'urgent': getTodosByPriority(Priority.urgent).length,
    };
  }

  // 初始化示例数据
  Future<void> initializeSampleData() async {
    if (_todos.isNotEmpty) return;

    final sampleTodos = [
      TodoModel(
        id: '1',
        title: '学习GetX状态管理',
        description: '深入学习GetX的响应式编程和状态管理机制',
        priority: Priority.high,
        category: '学习',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TodoModel(
        id: '2',
        title: '完成Flutter项目',
        description: '完成购物应用的开发并发布到应用商店',
        priority: Priority.urgent,
        category: '工作',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TodoModel(
        id: '3',
        title: '购买生活用品',
        description: '去超市购买牛奶、面包、水果等生活必需品',
        priority: Priority.medium,
        category: '购物',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
      TodoModel(
        id: '4',
        title: '阅读技术书籍',
        description: '阅读《Flutter实战》第5章，学习Widget生命周期',
        priority: Priority.low,
        category: '学习',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        isCompleted: true,
        completedAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      TodoModel(
        id: '5',
        title: '锻炼身体',
        description: '去健身房进行1小时的有氧运动',
        priority: Priority.medium,
        category: '健康',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isCompleted: true,
        completedAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];

    _todos.addAll(sampleTodos);
    LogUtils.i('初始化示例数据: ${_todos.length} 个待办事项');
  }

  @override
  void onInit() {
    super.onInit();
    initializeSampleData();
    LogUtils.i('TodoService 初始化完成');
  }

  @override
  void onClose() {
    LogUtils.i('TodoService 已关闭');
    super.onClose();
  }
}
