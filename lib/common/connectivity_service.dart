/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 14:58:58
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 15:08:19
 * @FilePath: /SPFlutterPro/lib/common/connectivity_service.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService._();

  static final Connectivity _connectivity = Connectivity();
  static final StreamController<bool> _onlineController =
      StreamController<bool>.broadcast();
  static StreamSubscription<dynamic>? _subscription;

  static Stream<bool> get onlineStream => _onlineController.stream;

  static Future<void> init() async {
    final result = await _connectivity.checkConnectivity();
    _onlineController.add(_isAnyOnline(result));
    _subscription =
        _connectivity.onConnectivityChanged.listen((dynamic result) {
      bool online;
      if (result is List) {
        online = _isAnyOnline(result.cast<ConnectivityResult>());
      } else if (result is ConnectivityResult) {
        online = _isOnline(result);
      } else {
        online = false;
      }
      _onlineController.add(online);
    });
  }

  static Future<bool> isOnline() async {
    final result = await _connectivity.checkConnectivity();
    return _isAnyOnline(result);
  }

  static bool _isOnline(ConnectivityResult result) {
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet;
  }

  static bool _isAnyOnline(List<ConnectivityResult> results) {
    for (final r in results) {
      if (_isOnline(r)) return true;
    }
    return false;
  }

  static void dispose() {
    _subscription?.cancel();
    _onlineController.close();
  }
}
