/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 16:54:04
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 16:55:28
 * @FilePath: /SPFlutterPro/lib/common/debounce_throttle.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:async';

class Debouncer {
  Debouncer(this.delay);

  final Duration delay;
  Timer? _timer;

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class Throttler {
  Throttler(this.interval);

  final Duration interval;
  bool _locked = false;

  void call(void Function() action) {
    if (_locked) return;
    _locked = true;
    action();
    Timer(interval, () => _locked = false);
  }
}
