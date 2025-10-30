/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 16:54:12
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 16:55:20
 * @FilePath: /SPFlutterPro/lib/common/env_config.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
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
