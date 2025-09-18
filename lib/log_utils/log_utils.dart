/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 日志工具封装类 - 基于logger库
 */

import 'package:logger/logger.dart';

/// 日志工具类
/// 提供统一的日志接口，支持不同级别的日志输出
class LogUtils {
  static Logger? _logger;
  static bool _isEnabled = true;

  /// 初始化日志工具
  /// [enabled] 是否启用日志
  /// [minLevel] 最小日志级别
  /// [enableConsoleOutput] 是否启用控制台输出
  /// [enableFileOutput] 是否启用文件输出
  static void init({
    bool enabled = true,
    Level minLevel = Level.debug,
    bool enableConsoleOutput = true,
    bool enableFileOutput = false,
  }) {
    _isEnabled = enabled;

    if (!_isEnabled) return;

    _logger = Logger(
      filter: CustomLogFilter(minLevel),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      output: enableFileOutput 
          ? MultiOutput([
              ConsoleOutput(),
              FileOutput(),
            ])
          : ConsoleOutput(),
    );
  }

  /// Debug级别日志
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.debug, message, error, stackTrace);
  }

  /// Info级别日志
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.info, message, error, stackTrace);
  }

  /// Warning级别日志
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.warning, message, error, stackTrace);
  }

  /// Error级别日志
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.error, message, error, stackTrace);
  }

  /// Trace级别日志
  static void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.trace, message, error, stackTrace);
  }

  /// Fatal级别日志
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.fatal, message, error, stackTrace);
  }

  /// Verbose级别日志
  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.verbose, message, error, stackTrace);
  }

  /// WTF级别日志
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _log(Level.wtf, message, error, stackTrace);
  }

  /// 网络请求日志
  static void network(String method, String url, {
    Map<String, dynamic>? headers,
    dynamic data,
    int? statusCode,
    String? response,
  }) {
    if (!_isEnabled) return;

    final logMessage = '''
🌐 网络请求
├─ 方法: $method
├─ URL: $url
├─ 状态码: ${statusCode ?? 'N/A'}
├─ 请求头: ${headers?.toString() ?? 'N/A'}
├─ 请求数据: ${data?.toString() ?? 'N/A'}
└─ 响应数据: ${response?.toString() ?? 'N/A'}
''';
    
    _log(Level.info, logMessage);
    
    // 生成并打印curl命令
    final curlCommand = _generateCurlCommand(method, url, headers, data);
    if (curlCommand.isNotEmpty) {
      final curlMessage = '''
📋 Curl命令:
$curlCommand
''';
      _log(Level.info, curlMessage);
    }
  }

  /// 生成curl命令
  static String _generateCurlCommand(
    String method,
    String url,
    Map<String, dynamic>? headers,
    dynamic data,
  ) {
    try {
      final buffer = StringBuffer();
      buffer.write('curl -X $method');
      
      // 添加URL
      buffer.write(' "$url"');
      
      // 添加请求头
      if (headers != null && headers.isNotEmpty) {
        for (final entry in headers.entries) {
          buffer.write(' \\\n  -H "${entry.key}: ${entry.value}"');
        }
      }
      
      // 添加请求数据
      if (data != null) {
        String dataString;
        if (data is String) {
          dataString = data;
        } else if (data is Map || data is List) {
          dataString = data.toString();
        } else {
          dataString = data.toString();
        }
        
        // 转义特殊字符
        dataString = dataString.replaceAll('"', '\\"');
        buffer.write(' \\\n  -d "$dataString"');
      }
      
      return buffer.toString();
    } catch (e) {
      return '生成curl命令失败: $e';
    }
  }

  /// API响应日志
  static void apiResponse(String endpoint, {
    required int statusCode,
    dynamic data,
    String? error,
  }) {
    if (!_isEnabled) return;

    final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
    final logMessage = '''
$emoji API响应
├─ 端点: $endpoint
├─ 状态码: $statusCode
├─ 数据: ${data?.toString() ?? 'N/A'}
└─ 错误: ${error?.toString() ?? 'N/A'}
''';
    
    _log(statusCode >= 400 ? Level.error : Level.info, logMessage);
  }

  /// 用户行为日志
  static void userAction(String action, {Map<String, dynamic>? params}) {
    if (!_isEnabled) return;

    final logMessage = '''
👤 用户行为
├─ 动作: $action
└─ 参数: ${params?.toString() ?? 'N/A'}
''';
    
    _log(Level.info, logMessage);
  }

  /// 性能日志
  static void performance(String operation, Duration duration) {
    if (!_isEnabled) return;

    final logMessage = '''
⚡ 性能监控
├─ 操作: $operation
└─ 耗时: ${duration.inMilliseconds}ms
''';
    
    _log(Level.info, logMessage);
  }

  /// 设置日志开关
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// 设置最小日志级别
  static void setMinLevel(Level level) {
    if (_logger != null) {
      _logger = Logger(
        filter: CustomLogFilter(level),
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: true,
        ),
        output: ConsoleOutput(),
      );
    }
  }

  /// 内部日志方法
  static void _log(Level level, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!_isEnabled || _logger == null) return;

    switch (level) {
      case Level.debug:
        _logger!.d(message, error: error, stackTrace: stackTrace);
        break;
      case Level.info:
        _logger!.i(message, error: error, stackTrace: stackTrace);
        break;
      case Level.warning:
        _logger!.w(message, error: error, stackTrace: stackTrace);
        break;
      case Level.error:
        _logger!.e(message, error: error, stackTrace: stackTrace);
        break;
      case Level.trace:
        _logger!.t(message, error: error, stackTrace: stackTrace);
        break;
      case Level.fatal:
        _logger!.f(message, error: error, stackTrace: stackTrace);
        break;
      case Level.all:
        _logger!.i(message, error: error, stackTrace: stackTrace);
        break;
      case Level.verbose:
        _logger!.v(message, error: error, stackTrace: stackTrace);
        break;
      case Level.wtf:
        _logger!.wtf(message, error: error, stackTrace: stackTrace);
        break;
      case Level.nothing:
        // Level.nothing 不输出任何日志
        break;
      case Level.off:
        // Level.off 关闭所有日志
        break;
    }
  }
}

/// 自定义日志过滤器
class CustomLogFilter extends LogFilter {
  final Level minLevel;

  CustomLogFilter(this.minLevel);

  @override
  bool shouldLog(LogEvent event) {
    return event.level.index >= minLevel.index;
  }
}

/// 文件输出类
class FileOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // 这里可以实现文件输出逻辑
    // 例如使用path_provider保存到文件
    // 暂时使用控制台输出
    for (var line in event.lines) {
      print('📁 $line');
    }
  }
}

/// 日志级别枚举扩展
extension LevelExtension on Level {
  String get displayName {
    switch (this) {
      case Level.trace:
        return 'TRACE';
      case Level.debug:
        return 'DEBUG';
      case Level.info:
        return 'INFO';
      case Level.warning:
        return 'WARNING';
      case Level.error:
        return 'ERROR';
      case Level.fatal:
        return 'FATAL';
      case Level.all:
        return 'ALL';
      case Level.verbose:
        return 'VERBOSE';
      case Level.wtf:
        return 'WTF';
      case Level.nothing:
        return 'NOTHING';
      case Level.off:
        return 'OFF';
    }
  }
}