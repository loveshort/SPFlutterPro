/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: HTTP响应数据模型
 */

/// HTTP响应状态枚举
enum HttpStatus {
  success,    // 成功
  error,      // 错误
  loading,    // 加载中
  timeout,    // 超时
  network,    // 网络错误
  unknown,    // 未知错误
}

/// 通用HTTP响应数据模型
class HttpsResult<T> {
  /// 响应状态
  final HttpStatus status;
  
  /// 响应数据
  final T? data;
  
  /// 错误信息
  final String? message;
  
  /// 错误代码
  final int? code;
  
  /// 是否成功
  final bool isSuccess;
  
  /// 响应时间戳
  final DateTime timestamp;
  
  /// 请求路径
  final String? path;
  
  /// 请求参数
  final Map<String, dynamic>? params;

  const HttpsResult({
    required this.status,
    this.data,
    this.message,
    this.code,
    required this.isSuccess,
    required this.timestamp,
    this.path,
    this.params,
  });

  /// 创建成功响应
  factory HttpsResult.success({
    required T data,
    String? message,
    String? path,
    Map<String, dynamic>? params,
  }) {
    return HttpsResult<T>(
      status: HttpStatus.success,
      data: data,
      message: message ?? '请求成功',
      code: 200,
      isSuccess: true,
      timestamp: DateTime.now(),
      path: path,
      params: params,
    );
  }

  /// 创建错误响应
  factory HttpsResult.error({
    required String message,
    int? code,
    HttpStatus? status,
    String? path,
    Map<String, dynamic>? params,
  }) {
    return HttpsResult<T>(
      status: status ?? HttpStatus.error,
      message: message,
      code: code,
      isSuccess: false,
      timestamp: DateTime.now(),
      path: path,
      params: params,
    );
  }

  /// 创建加载中响应
  factory HttpsResult.loading({
    String? message,
    String? path,
    Map<String, dynamic>? params,
  }) {
    return HttpsResult<T>(
      status: HttpStatus.loading,
      message: message ?? '请求中...',
      isSuccess: false,
      timestamp: DateTime.now(),
      path: path,
      params: params,
    );
  }

  /// 创建超时响应
  factory HttpsResult.timeout({
    String? message,
    String? path,
    Map<String, dynamic>? params,
  }) {
    return HttpsResult<T>(
      status: HttpStatus.timeout,
      message: message ?? '请求超时',
      code: 408,
      isSuccess: false,
      timestamp: DateTime.now(),
      path: path,
      params: params,
    );
  }

  /// 创建网络错误响应
  factory HttpsResult.networkError({
    String? message,
    String? path,
    Map<String, dynamic>? params,
  }) {
    return HttpsResult<T>(
      status: HttpStatus.network,
      message: message ?? '网络连接失败',
      code: -1,
      isSuccess: false,
      timestamp: DateTime.now(),
      path: path,
      params: params,
    );
  }

  /// 从JSON创建响应
  factory HttpsResult.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    final statusValue = json['status'] as String?;
    HttpStatus status;
    switch (statusValue) {
      case 'success':
        status = HttpStatus.success;
        break;
      case 'error':
        status = HttpStatus.error;
        break;
      case 'loading':
        status = HttpStatus.loading;
        break;
      case 'timeout':
        status = HttpStatus.timeout;
        break;
      case 'network':
        status = HttpStatus.network;
        break;
      default:
        status = HttpStatus.unknown;
    }

    T? data;
    if (json['data'] != null && fromJsonT != null) {
      data = fromJsonT(json['data']);
    }

    return HttpsResult<T>(
      status: status,
      data: data,
      message: json['message'] as String?,
      code: json['code'] as int?,
      isSuccess: json['isSuccess'] as bool? ?? false,
      timestamp: DateTime.parse(json['timestamp'] as String),
      path: json['path'] as String?,
      params: json['params'] as Map<String, dynamic>?,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      'data': data,
      'message': message,
      'code': code,
      'isSuccess': isSuccess,
      'timestamp': timestamp.toIso8601String(),
      'path': path,
      'params': params,
    };
  }

  /// 复制并修改
  HttpsResult<T> copyWith({
    HttpStatus? status,
    T? data,
    String? message,
    int? code,
    bool? isSuccess,
    DateTime? timestamp,
    String? path,
    Map<String, dynamic>? params,
  }) {
    return HttpsResult<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      code: code ?? this.code,
      isSuccess: isSuccess ?? this.isSuccess,
      timestamp: timestamp ?? this.timestamp,
      path: path ?? this.path,
      params: params ?? this.params,
    );
  }

  @override
  String toString() {
    return 'HttpsResult{status: $status, data: $data, message: $message, code: $code, isSuccess: $isSuccess, timestamp: $timestamp, path: $path}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HttpsResult<T> &&
        other.status == status &&
        other.data == data &&
        other.message == message &&
        other.code == code &&
        other.isSuccess == isSuccess &&
        other.timestamp == timestamp &&
        other.path == path;
  }

  @override
  int get hashCode {
    return Object.hash(
      status,
      data,
      message,
      code,
      isSuccess,
      timestamp,
      path,
    );
  }
}

/// 分页响应数据模型
class PageResult<T> {
  /// 数据列表
  final List<T> data;
  
  /// 当前页码
  final int currentPage;
  
  /// 每页数量
  final int pageSize;
  
  /// 总页数
  final int totalPages;
  
  /// 总数量
  final int totalCount;
  
  /// 是否有下一页
  final bool hasNext;
  
  /// 是否有上一页
  final bool hasPrevious;

  const PageResult({
    required this.data,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
    required this.hasNext,
    required this.hasPrevious,
  });

  /// 从JSON创建分页响应
  factory PageResult.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    final dataList = (json['data'] as List?)
        ?.map((item) => fromJsonT(item))
        .toList() ?? <T>[];

    return PageResult<T>(
      data: dataList,
      currentPage: json['currentPage'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      totalPages: json['totalPages'] as int? ?? 1,
      totalCount: json['totalCount'] as int? ?? 0,
      hasNext: json['hasNext'] as bool? ?? false,
      hasPrevious: json['hasPrevious'] as bool? ?? false,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'currentPage': currentPage,
      'pageSize': pageSize,
      'totalPages': totalPages,
      'totalCount': totalCount,
      'hasNext': hasNext,
      'hasPrevious': hasPrevious,
    };
  }

  @override
  String toString() {
    return 'PageResult{data: ${data.length} items, currentPage: $currentPage, pageSize: $pageSize, totalPages: $totalPages, totalCount: $totalCount}';
  }
}

/// 列表响应数据模型
class ListResult<T> {
  /// 数据列表
  final List<T> data;
  
  /// 列表长度
  final int length;
  
  /// 是否为空
  final bool isEmpty;
  
  /// 是否不为空
  final bool isNotEmpty;

  const ListResult({
    required this.data,
    required this.length,
    required this.isEmpty,
    required this.isNotEmpty,
  });

  /// 从JSON创建列表响应
  factory ListResult.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    final dataList = (json['data'] as List?)
        ?.map((item) => fromJsonT(item))
        .toList() ?? <T>[];

    return ListResult<T>(
      data: dataList,
      length: dataList.length,
      isEmpty: dataList.isEmpty,
      isNotEmpty: dataList.isNotEmpty,
    );
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'length': length,
      'isEmpty': isEmpty,
      'isNotEmpty': isNotEmpty,
    };
  }

  @override
  String toString() {
    return 'ListResult{data: ${data.length} items, isEmpty: $isEmpty}';
  }
}
