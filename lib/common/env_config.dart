/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 16:54:12
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 16:55:20
 * @FilePath: /SPFlutterPro/lib/common/env_config.dart
 * @Description: 环境配置工具类
 */
class EnvConfig {
  EnvConfig._();

  static String baseApi = '';
  static String envName = 'dev';

  static void apply({required String baseApiUrl, String name = 'dev'}) {
    baseApi = baseApiUrl;
    envName = name;
  }
}
