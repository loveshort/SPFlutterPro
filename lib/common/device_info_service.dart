/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 15:01:54
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 15:02:01
 * @FilePath: /SPFlutterPro/lib/common/device_info_service.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  DeviceInfoService._();

  static final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> getDeviceData() async {
    if (Platform.isAndroid) {
      final info = await _plugin.androidInfo;
      return {
        'platform': 'android',
        'brand': info.brand,
        'manufacturer': info.manufacturer,
        'model': info.model,
        'device': info.device,
        'version': info.version.release,
        'sdkInt': info.version.sdkInt,
        'hardware': info.hardware,
        'supportedAbis': info.supportedAbis,
      };
    } else if (Platform.isIOS) {
      final info = await _plugin.iosInfo;
      return {
        'platform': 'ios',
        'name': info.name,
        'systemName': info.systemName,
        'systemVersion': info.systemVersion,
        'model': info.model,
        'localizedModel': info.localizedModel,
        'identifierForVendor': info.identifierForVendor,
        'isPhysicalDevice': info.isPhysicalDevice,
      };
    } else if (Platform.isMacOS) {
      final info = await _plugin.macOsInfo;
      return {
        'platform': 'macos',
        'model': info.model,
        'arch': info.arch,
        'osRelease': info.osRelease,
      };
    }
    return {'platform': 'unknown'};
  }
}
